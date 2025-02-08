// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Core {
    address public owner;
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public fundsNeeded;
    uint256 internal fundsRaised = 0;
    uint256 public totalSupply;
    uint256 public airDropAmount;
    uint256 public duration;
    uint256 public endTime;
    bool public projectInProd = false;

    struct Contributor {
        address contributor;
        uint256 amount;
        uint8 pourcentageTFV;
    }
    Contributor[] public contributors;

    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _fundNeeded,
        uint256 _totalSupply,
        uint256 _airDropAmount,
        uint256 _duration
    ) {
        owner = msg.sender;
        name = _name;
        symbol = _symbol;
        fundsNeeded = _fundNeeded;
        decimals = _decimals;
        totalSupply = _totalSupply;
        airDropAmount = _airDropAmount;
        duration = _duration;
        endTime = block.timestamp + _duration;
    }

    event ProjectStarted(string message);
    event projectRefunded(string message);    

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier onlyAfterEndTime() {
        require(block.timestamp >= endTime, "Function not available yet");
        _;
    }

    modifier maxFundsNeededReached() {
        require(fundsNeeded > fundsRaised, "Max funds needed reached");
        _;
    }

    modifier projectInProduction() {
        require(projectInProd == true, "Project is not in production");
        _;
    }

    modifier projectNotInProduction() {
        require(projectInProd == false, "Project is in production");
        _;
    }

    function setOwner(address _owner) public onlyOwner {
        owner = _owner;
    }

    function fundProject() public payable projectNotInProduction maxFundsNeededReached{
        require(msg.value > 0, "Amount must be greater than 0");
        contributors.push(Contributor(msg.sender, msg.value, 0));
        setFundsRaised(fundsRaised + msg.value);
        emit projectRefunded("Project has been refunded");
        if (fundsRaised >= fundsNeeded) {
            startProjectProd();
        }
    }

    function refundContributor() public onlyAfterEndTime {
        for (uint256 i = 0; i < contributors.length; i++) {
            if (contributors[i].amount > 0) {
                payable(contributors[i].contributor).transfer(contributors[i].amount);
                delete contributors[i];
            }
        }
    }

    function startProjectProd() internal {
        projectInProd = true;
        for (uint i = 0; i < contributors.length; i++) {
            contributors[i].pourcentageTFV = uint8((contributors[i].amount * 100) / fundsRaised);
        }
        emit ProjectStarted("Project is now in production");
    }

    function setFundsRaised(uint256 _fundsRaised) internal {
        fundsRaised = _fundsRaised;
    }

    function getFundsRaised() public view returns (uint256) {
        return fundsRaised;
    }

    function getContributors() public view returns (Contributor[] memory) {
        return contributors;
    }

    function getContributedValue(address _contributor) public view returns (uint256) {
        for (uint256 i = 0; i < contributors.length; i++) {
            if (contributors[i].contributor == _contributor) {
                return contributors[i].amount;
            }
        }
        return 0;
    }

    function getPourcentageTFV(address _contributor) public view returns (uint8) {
        for (uint256 i = 0; i < contributors.length; i++) {
            if (contributors[i].contributor == _contributor) {
                return contributors[i].pourcentageTFV;
            }
        }
        return 0;
    }
}
