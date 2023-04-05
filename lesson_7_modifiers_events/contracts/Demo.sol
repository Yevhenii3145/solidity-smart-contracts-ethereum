// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo {
    // require
    // revert
    // assert
    address owner;

    // события
    event Paid(address indexed _from, uint _amount, uint _timestamp);

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        emit Paid(msg.sender, msg.value, block.timestamp);
    }

    function pay() external payable {
        emit Paid(msg.sender, msg.value, block.timestamp); // в журнал событий будет записано данное событие, за это не платим деньги как за хранение в блокчейне
        // + можно написать фронтенд и используя библиотеку ethers.js подписаться на прослушивание событий в журнале, но изнутри смартконтракта считать события с журнала нельзя
    }
    
    // модификаторы
    modifier onlyOwner(address _to) {
        require(msg.sender == owner, "you are not an owner!"); // Проверяем, чтобы функцию по списанию средств вызывал владелец контракта, а не кто-либо другой
        require(_to != address(0), "incorrect address!"); // Проверяем чтобы адрес не был равен нулевому(по умолчанию) адресу
        _;
        //require(...) - проверки после выпонения тела функции
    }

    // встроенные функции проверки
    function withdraw(address payable _to) external onlyOwner(_to) {
        /*
        require(msg.sender == owner, "you are not an owner!"); // встроенная в язык функция которая проверяет, чтобы условие выполнялось, либо транзакция будет отменена, будет вызвана ошибка и будет выведена строка которая идет вторым аргументом
        // 2 вариант - это использовать функцию revert
        if(msg.sender != owner) {
            revert("you are not an owner!"); // функция вызовет ошибку error с указанным текстом
        }
        // 3 вариант - это функция assert
        assert(msg.sender == owner); // в если условие преобразуется в ложное то assert вызовет ошибку типа Panic (обычно эти ошибки вызываются когда в смартконтакте происходит что типа деление на ноль или подобные ошибки)
        // из ошибки assert нельзя понять в чем конкретно ошибка т.к. нет сообщения используется редко
        */

        _to.transfer(address(this).balance);
    }
}
