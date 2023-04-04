const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Payments", function () {
  let acc1;
  let acc2;
  let payments;

  beforeEach(async function () {
    [acc1, acc2] = await ethers.getSigners(); // Получаем информацию об тестовых аккаунтах на платформе hardhat
    const Payments = await ethers.getContractFactory("Payments", acc1); // Получение информации о скомпилированной версии смарт контракта
    payments = await Payments.deploy(); // Отправляем транзакцию /payments - это специальный объект с помощью которого мы будем взаимодействовать с смарт к.
    await payments.deployed(); // Ждем когда транзакция будет выполнена
    console.log(payments.address); // Узнаём по какому адресу мы развернули смарт контракт
  });
  it("should be deployed", async function () {
    expect(payments.address).to.be.properAddress; // Проверяем что адрес смарт контракта является корректным
  });
  it("should have 0 ether by default", async function () {
    const balance = await payments.currentBalance();
    expect(balance).to.eq(0);
  });
  it("should be possible to send funds", async function () {
    const sum = 100;
    const msg = "hello from hardhat";
    const tx = await payments
      .connect(acc2)
      .pay("hello from hardhat", { value: sum }); // Запускаем транзакцию от лица 2 аккаунта

    await expect(() => tx).to.changeEtherBalance([acc2, payments], [-sum, sum]);
    await tx.wait();

    // const balance = await payments.currentBalance(); // После того как транзакция прошла проверяем как изменился баланс
    // console.log(balance);
    const newPayment = await payments.getPayment(acc2.address, 0);
    console.log(newPayment);
    expect(newPayment.message).to.eq(msg);
    expect(newPayment.amount).to.eq(sum);
    expect(newPayment.from).to.eq(acc2.address);
  });
});
