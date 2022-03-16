import { ethers } from "hardhat";

async function main() {
  const [owner, addr1] = await ethers.getSigners();
  const PriceFeed = await ethers.getContractFactory("PriceFeed");
  const USDT = await ethers.getContractFactory("USDT");
  const WETH = await ethers.getContractFactory("WETH");
  const TokenSwap = await ethers.getContractFactory("TokenSwap");

  const priceFeed = await PriceFeed.deploy();
  await priceFeed.deployed();
  const weth = await WETH.deploy();
  await weth.deployed();
  const usdt = await USDT.deploy();
  await usdt.deployed();
  const price = await priceFeed.getLatestPriceAndDecimal()
  const tokenSwap = await TokenSwap.deploy(usdt.address, weth.address, owner.address, priceFeed.address);
  await tokenSwap.deployed();

  console.log("PriceFeed deployed to:", priceFeed.address);
  console.log(`WETH TOKEN DEPLOYED AT ${weth.address}`);
  console.log(`USDT TOKEN DEPLOYED AT ${usdt.address}`);
  console.log(`TOKENSWAP DEPLOYED AT ${tokenSwap.address}`);
  console.log(`The price of 1USDT/ETH is ${price}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});