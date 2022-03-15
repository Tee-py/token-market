// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract TokenSwap{

    AggregatorV3Interface internal priceFeed;

    IERC20 TokenA;
    IERC20 TokenB;

    uint decimal = 10**18;

    uint swapId;

    mapping(uint => swapInfo) offer;

    mapping(address => buyerInfo) buyer;

    /**
     * Network: Kovan
     * Aggregator: ETH/USD
     * Address: 0x9326BFA02ADD2366b30bacB125260Af641031331
     */
    constructor(address aggregator) {
        priceFeed = AggregatorV3Interface(aggregator);
    }

    
}