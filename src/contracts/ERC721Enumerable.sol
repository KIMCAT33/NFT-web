// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';

abstract contract ERC721Enumberalbe is ERC721 {

    uint256[] private _allTokens;
    
    // mapping from tokenId to position in _allTokens array

    mapping(uint256 => uint256) private _allTokensIndex;

    // mapping of owner to list of all owner token ids
    mapping( address => uint256[]) private _ownedTokens;

    // mapping from token ID to index of the owner tokens list
    mapping(uint256 => uint256) private _ownedTokensIndex;


    function totalSupply() internal view returns (uint256){
        return _allTokens.length;
    }



    function _mint(address to, uint256 tokenId) internal override(ERC721) {
        super._mint(to, tokenId);

        // A. add tokens to the owner
        // B. all tokens to our totalsupply - to allTokens
        _addTokensToAllTokenEnumeration(tokenId);
        _addTokensToOwnerEnumeration(to, tokenId);
    }

    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private {
        // 1. add address and token id to the _ownedTokens
        // 2. ownedTokenIndex tokenId set to address of ownedTokens position
        // 3. we want to execute the function with minting
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    
    }

    function _addTokensToAllTokenEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function tokenByIndex(uint256 index) public view returns(uint256){
        require(index< totalSupply(), 'global index is out of bounds!' );
        return _allTokens[index];
    }

    function tokenOfOwnerByIndex(address owner, uint256 index) public view returns(uint256){
        require(index < balanceOf(owner),'owner index is out of bounds!');
        return _ownedTokens[owner][index];
    }

}