// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo {

    // UNCHECKED
    uint8 public myVal = 254;

    function inc() public {
        //myVal = myVal + 1;
        unchecked {
            myVal +=1;
        }
        //myVal ++; // myVal--;
    }
    
    /*
    // MIN-MAX
    uint public minimum;
    uint public maximum;

    function demo() public {
        minimum = type(uint8).min;
        maximum = type(uint8).max;
    }
    */

    /*
    // UNSIGNED INTEGERS
    uint256 public myUint = 42;
    // 2 ** 256 = 1.1579209e+77
    uint8 public mySmallUint = 2;
    // 2 ** 8 = 256
    // 0 ---> (256-1)
    //uint16 uint24 uint 32 uint40 ...uint256
    
    // MATH
    function math(uint _inputUint) public {
        uint localUint = 42
        localUint + 1;
        localUint - 1;
        localUint * 2;
        localUint / 2;
        localUint ** 2;
        localUint % 3;
        -localUint; // -42

        localUint == 1;
        localUint != 1;
        localUint > 1;
        localUint >= 1;
        localUint < 2;
        localUint <= 2;
    }
    // SIGNED INTEGERS
    int public myInt = -42;
    int8 public mySmallInt = -1;
    // 2 ** 7 = 128
    -128 ---> (128-1)
    */

    /*
    // BOOLEAN
    bool public myBool = true; // state

    function myFunc(bool _inputBool) public {
        bool localBool = false; // local
        localBool && _inputBool // AND
        localBool || _inputBool // OR
        localBool == _inputBool // EQUAL
        localBool != _inputBool // NOT EQUAL
        !localBool // NOT
        if(_inputBool || localBool)
    }
    */
}