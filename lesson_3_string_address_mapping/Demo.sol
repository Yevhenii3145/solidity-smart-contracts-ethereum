// SPDX-License-Identidier: MIT

pragma solidity ^0.8.0;

contract Demo {
    // ADRESSES
    address public myAddr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    // MAPPINGS
    mapping(address => uint) public payments; // storage
    // у мепингов ключом могут быть только простые типы данных

    

    function receiveFunds() public payable {
        payments[msg.sender] =  msg.value;
    }

    function transferTo(address targetAddr, uint amount) public {
        address payable _to = payable(targetAddr);
        _to.transfer(amount);
    }

    function getBlance(address targetAddr) public view returns(uint) {
        return targetAddr.balance;
    }

    // STRING
    string public myStr = "test"; // storage
    // большие  обьемы данных хранятся в облачном хранилище, а в самом блокчейне хранится ссылка 
    
    function demo (string memory newValueStr) public {
        string memory myTempStr = "temp";
        myStr = newValueStr; // после отработки функции значение myStr в блокчейне перезпишется
        // В solidity у строк не возможно посчитать длину и просто так нельзя сравнить без библиотек сторнних
    }
}