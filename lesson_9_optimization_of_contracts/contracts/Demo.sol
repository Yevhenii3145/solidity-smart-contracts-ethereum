// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// 15 gwei
// 0.00003532 USD
contract Optimized {
    // uint demo; // Gas used 67066 // более оптимально не присваивать данные к переменной
    // uint demo = 1; // Gas used 89240
    // uint128 a = 1; // Gas used 113512 // эти 2 переменные можно упаковать в 1 ячейку размером в 32 байта
    // uint128 b = 1;
    // uint256 c = 1;
    // bytes32 public hash = 0x9c22ff5f21f0b81b113e63f7db6da94fed; // Gas used 114791 сразу записать хеш лучше
    /*
    mapping(address => uint) payments;  // mapping ипользовать предпочтительнее чем массивы 

    function pay() external payable {
        require(msg.sender != address(0), "zero address");
        payments[msg.sender] = msg.value;
    } // Gas used 23498 // более оптимизированно
    */
    /*
    uint[10] payments; // если все-таки использовать массивы, то все таки предпочтительнее сразу задавать им размер
    // uint8[] demo = [1,2,3]; // Gas used 127248 // если уже использовать массивы фиксированной длинны то лучше, то нужно указать обьем памяти, который следует зарезервировать
    function pay() external payable {
        require(msg.sender != address(0), "zero address");
        payments[0] = msg.value;
    } // Gas used 23438
    */
    /*
    uint c = 5;
    uint d;
    function calc() public {
        uint a = 1 + c;
        uint b = 2 * c;
        d = a + b;
    } // Gas used 46124 // Предпочтительнее делать расчеты прямо внутри функции, а не вызывать другую функуцию
    // Но также нужно страраться, чтобы функции не были слишком большими
    */

    uint public result = 1;

    function doWork(uint[] memory data) public {
        uint temp = 1;
        for (uint i = 0; i < data.length; i++) {
            temp *= data[i];
        }
        result = temp;
    } // Gas used 29698 // Более оптимизированно не работать каждый раз с переменной из блокчейна
    // А провести все вычисления в функции и один раз переприсвоить значение переменной блокчейна
}

contract Unoptimized {
    // uint demo = 0; // Gas used 69324
    // uint8 demo = 1; // Gas used 89629
    // uint128 a = 1; // Gas used 135362 // переменная в своей ячейке 32 байта
    // uint256 c = 1; // переменная в своей ячейке 32 байта
    // uint128 b = 1; // переменная в своей ячейке 32 байта
    // bytes32 public hesh = keccak256(abi.encodePacked("test")); // Gas used 116440
    /*
    mapping(address => uint) payments;

    function pay() external payable {
        address _from = msg.sender;
        require(_from != address(0), "zero address");
        payments[_from] = msg.value;
    } // Gas used 23512  создание лишней промежуточной переменной дороже стоит
    */
    /*
    uint[] payments;
    // uint[] demo = [1,2,3]; // Gas used 158612

    function pay() external payable {
        require(msg.sender != address(0), "zero address");
        payments.push(msg.value);
    } // Gas used 45618
    */
    /*
    uint c = 5;
    uint d;
    function calc() public {
        uint a = 1 + c;
        uint b = 2 * c;
        call2(a, b);
    }
    function call2(uint a, uint b) private {
        d = a + b;
    } // Gas used 46158
    */

    uint public result = 1;

    function doWork(uint[] memory data) public {
        for (uint i = 0; i < data.length; i++) {
            result *= data[i];
        }
    } // Gas used 30128
}
