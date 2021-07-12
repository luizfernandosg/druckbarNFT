# cars.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract transferContract {
    address public from;
    address public to;
    uint256 public tokenId;


    constructor(address _from, address _to, uint256 _tokenId) payable {
        from = _from;
        to = _to;
        tokenId = _tokenId;
    }
}

