pragma solidity ^0.8.7;

import "./Telephone2.sol";

contract Telephone {
    Telephone2 public telephone2 = Telephone2(0xDc0851816b8EB4FD52B8B24EEFCA076C7A61a249);

    function solveChallenge() public {
        telephone2.solveChallenge();
    }
}
