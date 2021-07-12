# ERC721wCars.sol

// contracts/GameItem.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./cars.sol";


contract GameItem is ERC721URIStorage {
	Purchase[] public cars;
	string public tokenURIfrom;
	string public tokenURIto;
	
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

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
	
    function createAndSendEther(address _owner, string memory _model, uint _value)
        public
        payable
    {
        _owner = msg.sender;
        _value = msg.value;
        Purchase car = new Purchase(_owner, _model, _value);
        cars.push(car);
    }	
	
    function getCar(uint _index)
        public
        view
        returns (address owner, string memory model, uint balance)
    {
        Purchase car = cars[_index];

        return (car.owner(), car.model(), address(car).balance);
    }	
	
	function _transfer(address from, address to, uint256 tokenId) internal virtual override {
	    tokenURIfrom = "testeFROM";
	    tokenURIto = "testeTO";
	    awardItem(from, tokenURIfrom);
	    awardItem(to, tokenURIto);
	    emit Transfer(from, to, tokenId);
	}

}