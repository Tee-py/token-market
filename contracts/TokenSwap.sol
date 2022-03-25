// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "interface/IPriceFeed.sol";


contract TokenSwap {

    IERC20 usdt;
    IERC20 weth;
    IPriceFeed feed;
    address payable reserve;

    constructor(address _usdt, address _weth, address _reverve, address _feed){
        usdt = IERC20(_usdt);
        weth = IERC20(_weth);
        feed = IPriceFeed(_feed);
        reserve = payable(_reverve);
    }

    function swapToken(uint amount) payable {
        (price, decimals) = feed.getLatestPriceAndDecimal();
        require(msg.value >= amount*price*decimals, "Insufficient Value for Swap");
        usdt.transferFrom(msg.sender, reserve, amount*10**18);
        weth.transferFrom(reserve, msg.sender, amount*10**18);
    }


}

