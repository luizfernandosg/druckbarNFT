# 202104142109 TragbarNFT development
#Ethereum #Projekt #NFT #TragbarNFT

## Development

[](https://rinkeby.etherscan.io/address/0xc19075abac9b57e0054e60092907049a6e7dcaeb)
[](https://rinkeby.etherscan.io/address/0xb6a4a76b081248c867670ac99075270cd255d43c#code)

## Resources

### Ethereum smart contracts

[OpenZeppelin contracts](https://docs.openzeppelin.com/contracts/4.x/)

[INTRODUCTION TO SMART CONTRACTS](https://ethereum.org/en/developers/docs/smart-contracts/)

[learn by coding](https://ethereum.org/en/developers/learning-tools/)

[INTERACT WITH OTHER CONTRACTS FROM SOLIDITY](https://ethereum.org/en/developers/tutorials/interact-with-other-contracts-from-solidity/)

[DEPLOYING YOUR FIRST SMART CONTRACT](https://ethereum.org/en/developers/tutorials/deploying-your-first-smart-contract/)

[HOW TO IMPLEMENT AN ERC-721 MARKET](https://ethereum.org/en/developers/tutorials/how-to-implement-an-erc721-market/)

[Solidity by Example](https://solidity-by-example.org/)

[2 Factor authentication with Smart Contracts](https://blog.softwaremill.com/2-factor-authentication-with-smart-contracts-edd325f08b7a)

### OpenSea NFT marketplace


[OpenSea: ERC721 Tutorial](https://docs.opensea.io/docs/getting-started)

[OpenSea Basic Integration](https://docs.opensea.io/docs/opensea-integration)

[OpenSea: JavaScript SDK](https://github.com/ProjectOpenSea/opensea-js)

[OpenSea docs](https://docs.opensea.io/)

### Node.js framework


[Express framework for Node.js](https://expressjs.com/)

[Node.js Tutorial for Beginners: Learn Node in 1 Hour](https://www.youtube.com/watch?v=TlB_eWDSMt4)

[Learn Express Middleware In 14 Minutes](https://www.youtube.com/watch?v=lY6icfhap2o)

[Live Server Extension in Visual Studio Code](https://www.youtube.com/watch?v=WzE0yqwbdgU)

[Using nodemon with NodeJS Servers](https://www.youtube.com/watch?v=kV6MJ9W4whM)

[Express framework for Node.js](https://expressjs.com/)

[Node.js Tutorial for Beginners: Learn Node in 1 Hour](https://www.youtube.com/watch?v=TlB_eWDSMt4)

[Learn Express Middleware In 14 Minutes](https://www.youtube.com/watch?v=lY6icfhap2o)

[Live Server Extension in Visual Studio Code](https://www.youtube.com/watch?v=WzE0yqwbdgU)

[Using nodemon with NodeJS Servers](https://www.youtube.com/watch?v=kV6MJ9W4whM)

### Others

[Aragon whitepaper](https://github.com/aragon/whitepaper)

## Code

	// contracts/GameItem.sol
	// SPDX-License-Identifier: MIT
	pragma solidity ^0.8.0;

	import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
	import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
	import "@openzeppelin/contracts/utils/Counters.sol";

	contract GameItem is ERC721URIStorage {
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
	}