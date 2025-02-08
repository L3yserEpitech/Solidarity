// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Core.sol";

contract CoreTest is Test {
    Core core;
    address owner = address(1);
    address contributor1 = address(2);
    address contributor2 = address(3);
    address contributor3 = address(4);

    uint256 initialFundsNeeded = 10 ether;
    uint256 totalSupply = 1000000;
    uint256 airDropAmount = 100;
    uint256 duration = 2 hours;

    function setUp() public {
        vm.startPrank(owner);
        core = new Core("ProjectX", "PXT", 18, initialFundsNeeded, totalSupply, airDropAmount, duration);
        vm.stopPrank();
    }

    function testDeployment() public view {
        assertEq(core.name(), "ProjectX");
        assertEq(core.symbol(), "PXT");
        assertEq(core.decimals(), 18);
        assertEq(core.fundsNeeded(), initialFundsNeeded);
        assertEq(core.getFundsRaised(), 0);
        assertEq(core.projectInProd(), false);
    }

    function testFundProject() public {
        vm.deal(contributor1, 5 ether);
        vm.prank(contributor1);
        core.fundProject{value: 5 ether}();

        assertEq(core.getFundsRaised(), 5 ether);
        assertEq(core.getContributedValue(contributor1), 5 ether);
    }

    function testMultipleContributors() public {
        vm.deal(contributor1, 4 ether);
        vm.deal(contributor2, 6 ether);

        vm.prank(contributor1);
        core.fundProject{value: 4 ether}();
        assertEq(core.getFundsRaised(), 4 ether);

        vm.prank(contributor2);
        core.fundProject{value: 6 ether}();
        assertEq(core.getFundsRaised(), 10 ether);
        assertEq(core.projectInProd(), true);
    }

    function testExceedFundsNeeded() public {
        vm.deal(contributor1, 10 ether);
        vm.deal(contributor2, 5 ether);

        vm.prank(contributor1);
        core.fundProject{value: 10 ether}();

        vm.prank(contributor2);
        vm.expectRevert();
        core.fundProject{value: 5 ether}();
    }

    function testStartProjectProduction() public {
        vm.deal(contributor1, 10 ether);

        vm.prank(contributor1);
        core.fundProject{value: 10 ether}();

        assertEq(core.projectInProd(), true);
    }

    function testRefundAfterEndTime() public {
        vm.deal(contributor1, 4 ether);
        vm.deal(contributor2, 6 ether);

        vm.prank(contributor1);
        core.fundProject{value: 4 ether}();

        vm.prank(contributor2);
        core.fundProject{value: 6 ether}();

        assertEq(core.getFundsRaised(), 10 ether);

        vm.warp(block.timestamp + 3 hours);

        uint256 balanceBefore1 = contributor1.balance;
        uint256 balanceBefore2 = contributor2.balance;

        vm.prank(owner);
        core.refundContributor();

        uint256 balanceAfter1 = contributor1.balance;
        uint256 balanceAfter2 = contributor2.balance;

        assertEq(balanceAfter1, balanceBefore1 + 4 ether);
        assertEq(balanceAfter2, balanceBefore2 + 6 ether);
    }

    function testRefundWithoutContributors() public {
        vm.warp(block.timestamp + 3 hours);

        vm.prank(owner);
        core.refundContributor();
    }

    function testOnlyOwnerCanSetOwner() public {
        vm.prank(contributor1);
        vm.expectRevert("Only owner can call this function");
        core.setOwner(contributor2);
    }

    function testGetContributors() public {
        vm.deal(contributor1, 5 ether);
        vm.deal(contributor2, 5 ether);

        vm.prank(contributor1);
        core.fundProject{value: 5 ether}();

        vm.prank(contributor2);
        core.fundProject{value: 5 ether}();

        Core.Contributor[] memory contributors = core.getContributors();

        assertEq(contributors.length, 2);
        assertEq(contributors[0].contributor, contributor1);
        assertEq(contributors[0].amount, 5 ether);
        assertEq(contributors[1].contributor, contributor2);
        assertEq(contributors[1].amount, 5 ether);
    }

    function testGetContributedValue() public {
        vm.deal(contributor1, 3 ether);

        vm.prank(contributor1);
        core.fundProject{value: 3 ether}();

        assertEq(core.getContributedValue(contributor1), 3 ether);
        assertEq(core.getContributedValue(contributor2), 0 ether);
    }

    function testCannotRefundBeforeEndTime() public {
        vm.deal(contributor1, 5 ether);

        vm.prank(contributor1);
        core.fundProject{value: 5 ether}();

        vm.expectRevert("Function not available yet");
        core.refundContributor();
    }

    function testPourcentageTFV() public {
        vm.deal(contributor1, 3 ether);
        vm.deal(contributor2, 7 ether);

        vm.prank(contributor1);
        core.fundProject{value: 3 ether}();

        assertEq(core.getPourcentageTFV(contributor1), 0);

        vm.prank(contributor2);
        core.fundProject{value: 7 ether}();

        assertEq(core.getPourcentageTFV(contributor1), 30);
        assertEq(core.getPourcentageTFV(contributor2), 70);
    }
}
