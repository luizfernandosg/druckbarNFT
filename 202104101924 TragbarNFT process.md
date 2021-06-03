# 202104101924 TragbarNFT process
#Ethereum #Projekt #NFT #TragbarNFT

## Process

1. minter mints NFT
2. buyer buys NFT (buyer becomes receiver)
3. smart contract is deployed
    1. NFT is transfered to smart contract
    2. smart contract generates individual codes
		1. for receiver -> is sent to receiver
		2. to printer -> is sent to printer
4. printer prints wearable
	1. prints printer code
	2. sends wearable to receiver
5. receiver receives wearable
	1. receiver gives receiver code to smart contract
	2. receiver gives printer code to smart contract
6. smart contract sends NFT to receiver, value to minter and printer fees to printer
	* expiration period
		* if codes are not received
			* contract is nulled
				* NFT is left on the contract
				* values are returned