// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface Preservation {
    function setFirstTime(uint256 _timeStamp) external;
}

contract Solve {
    address public a;
    address public b;
    uint256 owner;

    function setTime(uint256 _owner) public {
        owner = _owner;
    }
}
