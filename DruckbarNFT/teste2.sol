pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

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

contract transferContract is ERC721Holder, Ownable {
    address public from;
    address public to;
    uint256 public tokenId;
    bytes32 public hashGenerated;
    address public thisAddress = address(this);
    
    
    // Mapping from token ID to owner address
    // mapping (uint256 => address) private _owners;

    // Mapping owner address to token count
    // mapping (address => uint256) private _balances;

    // Mapping from token ID to approved address
    // mapping (uint256 => address) private _tokenApprovals;  
    
    // event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    // event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    
    enum State { Created, Locked, Release, Inactive }
    // The state variable has a default value of the first member, `State.created`
    State public state;

    modifier condition(bool _condition) {
        require(_condition);
        _;
    }    

    /// Only the buyer can call this function.
    error OnlyTo();
    /// Only the seller can call this function.
    error OnlyFrom();
    /// The function cannot be called at the current state.
    error InvalidState();
    /// The provided value has to be even.
    error ValueNotEven();
    
    error FalseHash();


    modifier onlyTo() {
        if (msg.sender != to)
            revert OnlyTo();
        _;
    }

    modifier onlyFrom() {
        if (msg.sender != from)
            revert OnlyFrom();
        _;
    }

    modifier inState(State _state) {
        if (state != _state)
            revert InvalidState();
        _;
    }

    /// event Aborted();
    /// event PurchaseConfirmed();
    /// event ItemReceived();
    /// event SellerRefunded();
    
    constructor(address _from, address _to, uint256 _tokenId) payable {
        from = _from;
        to = _to;
        tokenId = _tokenId;
    }

	function generateHash(string memory hashGenerator)
		public
		onlyFrom
		inState(State.Created)
		returns(bytes32)
	{
		state = State.Locked;
		hashGenerated = keccak256(abi.encodePacked(hashGenerator));
		
		return hashGenerated;
	
	}
    
	function authenticateHash(string memory hashAuthenticator)
		public
		onlyTo
		inState(State.Locked)
		returns(bool)
	{
        bool success = true;
        
		bytes32 hashAuthenticated = keccak256(abi.encodePacked(hashAuthenticator));
		
		if (hashAuthenticated != hashGenerated) {
            revert FalseHash();
		} else {
		    state = State.Release;

    		GameItem GI = GameItem(address(owner()));
        
            GI.approve(to, tokenId);
		    
		    return success;
		}
	}

    function completeTransfer(address from_, address to_, uint256 tokenId_) 
        public
        onlyTo
        inState(State.Release)
        returns(bool)
    {
        bool success = true;
        
        state = State.Inactive;
        
        GameItem GI = GameItem(address(owner()));
        
        GI.transfer(from_, to_, tokenId_);
        
        return success;

    }

}
