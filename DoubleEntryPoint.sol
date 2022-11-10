// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface DelegateERC20 {
    function delegateTransfer(
        address to,
        uint256 value,
        address origSender
    ) external returns (bool);
}

interface CryptoVault {}

interface Forta {
    function setDetectionBot(address detectionBotAddress) external;

    function raiseAlert(address user) external;
}

contract DetectionBot {
    CryptoVault vault = CryptoVault(0xb65Bb330e8af4B82319D8047e73919C15e46152d);
    Forta forta = Forta(0x3Dee0A9D88AcBA8f9d951871d7574595787B46F4);

    function handleTransaction(address user, bytes calldata callData) public {
        // The fortaNotify modifier should only trigger when delegateTransfer() is
        // called, so we know what the calldata will be.
        // Remember to account for the selector of the function being called, which
        // will be the first 4 bytes of the callData
        (, , address origSender) = abi.decode(
            callData[4:],
            (address, uint256, address)
        );

        if (origSender == address(vault)) {
            forta.raiseAlert(user);
        }
    }
}
