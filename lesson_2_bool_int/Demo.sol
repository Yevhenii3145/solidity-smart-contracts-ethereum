/ SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo {
    uint8 public myVal = 1;

    function dec() public {
        unchecked {
            myVal--;
        }
    }
}