//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
#import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

contract PriceFeedConsumer {

    AggregatorV3Interface internal priceFeed;

    /**
     * Network: Kovan
     * Aggregator: USDT/ETH
     * Address: 0x0bF499444525a23E7Bb61997539725cA2e928138
     */
    constructor(address aggregator, address _usdt, address _weth) {
        priceFeed = AggregatorV3Interface(aggregator);
    }

    function getLatestPriceAndDecimal() public view returns (int, int) {
        (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        uint decimal = priceFeed.decimals();
        return (price, decimal);
    }    
}