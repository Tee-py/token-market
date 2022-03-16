// SPDX-License-Identifier: MIT

interface IPriceFeed {

    function getLatestPriceAndDecimal() external returns (int, int);    
}