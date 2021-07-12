# druckbar.sol

// contracts/GameItem.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./transfer.sol";


contract GameItem is ERC721URIStorage {
	transferContract[] public transferContracts;
	
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    
    // Mapping from token ID to owner address
    mapping (uint256 => address) private _owners;

    // Mapping owner address to token count
    mapping (address => uint256) private _balances;

    constructor() ERC721("GameItem", "ITM") {}

    function awardItem(address player, string memory tokenURI)
        public
        returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(player, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
	
	function _transfer(address from, address to, uint256 tokenId) internal virtual override {
        
	    transferContract tContract = new transferContract(from, to, tokenId);
        transferContracts.push(tContract);

        super._transfer(from, address(tContract), tokenId);
	}
	
	function transfer(address from, address to, uint256 tokenId) public virtual {
	    super._transfer(from, to, tokenId);
	}
}