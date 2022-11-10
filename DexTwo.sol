// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FakeToken {
    function balanceOf(address) public pure returns (uint256) {
        return 1;
    }

    function transferFrom(
        address,
        address,
        uint256
    ) public pure returns (bool) {
        return true;
    }
}
