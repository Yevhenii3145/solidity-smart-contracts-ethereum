// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo {
    // Struct
    struct Payment {
        uint amount;
        uint timestamp;
        address from;
        string message;
    }

    struct Balance {
        uint totalPayments;
        mapping(uint => Payment) payments;
    }

    mapping(address => Balance) public balances;

    function getPayment(address _addr, uint _index) public view returns(Payment memory) {
        return balances[_addr].payments[_index];
    }

    function pay(string memory message) public payable {
        uint paymentNum = balances[msg.sender].totalPayments;

        balances[msg.sender].totalPayments++;

        Payment memory newPayment = Payment(
            msg.value,
            block.timestamp,
            msg.sender,
            message
        );

        balances[msg.sender].payments[paymentNum] = newPayment;
    }

    /*
    // Byte
    bytes32 public myVar = "test here"; // bytes32: 0x7465737420686572650000000000000000000000000000000000000000000000
    bytes public myDynVar = "test here";  // bytes: 0x746573742068657265
    bytes public myNewDynVar = unicode"привет мир!"; // 0xd0bfd180d0b8d0b2d0b5d18220d0bcd0b8d18021
    // 1 --> 32
    // 32 * 8 = 256
    //uint256

    function demo1() public view returns(bytes1) {
        // return myVar.length;
        return myDynVar[0]; // 0x74 - битовое кодирование буквы "t"
    }
    function demo2() public view returns(uint) {
        return myDynVar.length;
    }
     function demo3() public view returns(uint) {
        return myNewDynVar.length;
    }
    */

    // Array
    // string[5] public strings; // массив строк в котором максимум 5 элементов
    /*
    uint[10] public items;

    function demo() public {
        items[0] = 100;
        items[1] = 200;
        items[4] = 400;
    }
    */

    /*
    uint [3][2] public items;
    
    function demo() public {
        items = [
            [1,2,3],
            [7,2,8]
        ];
    }
    */

    /*
    uint[] public items; //массив с динамичесской длиной
    uint public len;

    function demo() public {
        items.push(4); // метод push() доступен только для массивов с динамичесской длинной
        items.push(5);
        len = items.length;
    }

    function sampleMemory() public view returns(uint[] memory) {
        uint[] memory tempArray = new uint[](10);
        tempArray[0] = 1;
        return tempArray;
    }
    */

    // Enum
    enum Status { Paid, Delivered, Received}
    Status public currentStatus;

    function pay() public {
        currentStatus = Status.Paid;
    }
    
    function delivered() public {
        currentStatus = Status.Delivered;
    }
}