import { ethers } from "hardhat";

async function main() {
  const PriceFeed = await ethers.getContractFactory("PriceFeed");
  const USDT = await ethers.getContractFactory("USDT");
  const WETH = await ethers.getContractFactory("WETH");


  const priceFeed = await PriceFeed.deploy();
  await priceFeed.deployed();
  const weth = await WETH.deploy();
  await weth.deployed();
  const usdt = await USDT.deploy();
  await usdt.deployed();
  const price = await priceFeed.getLatestPriceAndDecimal()

  console.log("PriceFeed deployed to:", priceFeed.address);
  console.log(`WETH TOKEN DEPLOYED AT ${weth.address}`)
  console.log(`USDT TOKEN DEPLOYED AT ${usdt.address}`)
  console.log(`The price of 1USDT/ETH is ${price}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});