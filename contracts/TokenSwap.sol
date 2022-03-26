// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "interface/IPriceFeed.sol";


contract TokenSwap {

    IERC20 usdt;
    IERC20 weth;
    IPriceFeed feed;
    address payable reserve;

    event Swap(address indexed swapper, uint amount);

    constructor(address _usdt, address _weth, address _reverve, address _feed){
        usdt = IERC20(_usdt);
        weth = IERC20(_weth);
        feed = IPriceFeed(_feed);
        reserve = payable(_reverve);
    }

    function swapToken(uint amount) {
        (price, decimals) = feed.getLatestPriceAndDecimal();
        uint usdtToPay = price*amount;
        require(usdt.allowance(msg.sender, address(this)>=usdtToPay), "Insufficient Allowance for Swap");
        require(weth.balanceOf(reserve)>=amount*10**18, "Insufficient Balance In Reserve");
        bool res = usdt.transferFrom(msg.sender, reserve, usdtToPay);
        require(res, "Failed To Send USDT");
        bool res2 = weth.transferFrom(reserve, msg.sender, amount*10**18);
        require(res2, "Failed To Send WETH");
        emit Swap(msg.sender, amount);
    }


}

