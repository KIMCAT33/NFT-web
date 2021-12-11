// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
    building out the minting function:
    a. nft to point to an address
    b. keep track of the token ids
    c. keep track of token owner addresses to token ids
    d. keep track of how many tokens an owner address has 
    e. create an event that emits a trasfer log - contract address, where it is being minted to, the id
    */

contract ERC721 {

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    
    // mapping in solidity creates a hash table of key pair values

    // Mapping from token id to the owner 

    mapping(uint256 => address) private _tokenOwner;

    // Mapping from owner to number of owned tokens
    mapping(address => uint256) private _OwnedTokensCount;
    
    /*
    1. write a function called mint that takes two arguments an address called to and an integer tokenId.
    2. add internal visibility to the signature
    3. set the tokenOwner of the tokenId to the address argument 'to'.
    4. increase the owner token count by 1 each time the function is called

    BONUS
    create two requirements -
    5. require that the mind address isn't 0
    6. require that the token has not already been minted
    */

    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero

    function balanceOf(address _owner) public view returns(uint256) {
        require(_owner!=address(0), "ERROR: Don't permit zero address");
        return _OwnedTokensCount[_owner];
    }

    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
    function ownerOf(uint256 _tokenId) public view returns(address){
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), 'owner query for non-existent token');
        return owner;

    }

    function _exists(uint256 tokenId) internal view returns(bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    function _mint(address to, uint256 tokenId) internal virtual {

        require(to != address(0), 'ERC721: minting to the zero address');
        require(!_exists(tokenId), 'ERC721: token already minted');


        _tokenOwner[tokenId] = to;
        _OwnedTokensCount[to] += 1;
        
        emit Transfer(address(0), to, tokenId);
        

    }


}

