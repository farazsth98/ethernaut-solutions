pragma solidity ^0.8.7;

contract Force {
    function selfDestruct() public{
        selfdestruct(payable(0x89B29454795d0A63e1c858bf4361c0Db0D7fcAAc));
    }

    receive() external payable {

    }
}
