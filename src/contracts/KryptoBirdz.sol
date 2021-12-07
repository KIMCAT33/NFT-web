// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721Connector.sol';

contract Kryptobird is ERC721Connector {

    // aaray to store our nfts
    string[] public KryptoBirdz;

    mapping(string => bool) _kryptoBirdzExists;

    function mint(string memory _kryptoBird) public {
        // This is deprecated - uint _id = KryptoBirdz.push(_kryptoBird);
        // .push no longer returns the length but a ref to the added element
        
        require(!_kryptoBirdzExists[_kryptoBird],'Error - kryptoBird already exists');
        KryptoBirdz.push(_kryptoBird);
        uint _id = KryptoBirdz.length - 1;

        _mint(msg.sender, _id);  

        _kryptoBirdzExists[_kryptoBird] = true; 

    }

    constructor() ERC721Connector('KryptoBird','KBIRDZ'){

    }

}
