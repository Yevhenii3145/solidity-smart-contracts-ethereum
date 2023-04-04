// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo {
    // public - (область видимости) данную функцию можно вызывать извне смартконтракта путем отправки  транзакции и изнутри смартконтракта (другая функция может обратится к функции котрая public)
    // external - к функции можно обращатся  только извне смартконтракта, а изнутри смарт контракта обращаться нельзя
    // internal - к функции можно обращаться изнутри смартконтракта, но нельзя извне (еще можно со смартконтрактов которые наследуют данный смартконтракт)
    // private - можно вызывать ТОЛЬКО изнутри смартконтракта (и нельзя из смартконтрактов которые его наследуют)

    // view - (модификатор)  функция может только считать данные в блокчейне но не модифицировать
    // pure - функция не может считать никакие данные в блокчейне
    // payable - функция может принимать денежные средства

    // address of curent smart contract 0x0165878A594ca255338adfa4d48449f69242Eb8F

    string message = "hello!"; // state
    uint public balance;

    // fallback functions - их используют для того чтобы смартконтракт принимал денежные средства без вызова какой-либо функции
    receive() external payable {
        // balance += msg.value; // просто зачисляет средства без вызова другой функции
    }
    fallback() external payable {
        // функция которая вызовется по умолчанию (чтобы не было ощибки и отката транзакции), если в трнзакции была вызвана функция которой нет в смартконтракте
    }
    function pay() external payable {
        balance += msg.value; // если средства пришли они автоматически зачислятся на баланс (можно ничего не писать в функции если она payable)
    }

    // transaction - платный вызов (эти функции не могут возвращать данные а только записывают их на блокчейн), созданы либо чтобы модифицировать данные либо переводить денежные средства, либо принимать средства
    function setMessage(string memory newMessage) external returns(string memory) {
        message = newMessage;
        return message;   //- нет смысла данные не возвращаются в транзакциях
    }
    // call - вызов за который не нужно платить, используется чтобы считать какие-то данные, либо сделать вычисления с данными из инпута но нельзя данные в блокчейне модифицировать

    function getBalance() public view returns(uint) {
        uint balanceVar = address(this).balance;
        return balanceVar;
    }
    function getBalanceTwo() public view returns(uint balanceVar) {
        balanceVar = address(this).balance;
        // в данной записи return не нужен
    }
   

    function getMessage() external view returns(string memory) {
        return message;
    } 
    // чистая функция
    function rate(uint amount) public pure returns(uint) {
        return amount * 3;
    }
}

