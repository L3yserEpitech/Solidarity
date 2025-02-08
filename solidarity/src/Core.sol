// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Core {
    address public owner;
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    uint256 public airDropAmount;
    uint256 public duration;

    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _totalSupply, uint256 _airDropAmount, uint256 _duration) {
        owner = msg.sender;
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        airDropAmount = _airDropAmount;
        duration = _duration;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function setOwner(address _owner) public onlyOwner {
        owner = _owner;
    }
}