// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
//import "@openzeppelin/contracts/utils/Counters.sol";

contract SWORD is ERC721, ERC721Burnable, Ownable {
    // using Counters for Counters.Counter;
    // Counters.Counter private _tokenIdCounter;

    Sword[] public sword;

    //mapping(address => Sword) public idToSword;

    constructor(address initialOwner) ERC721("SWORD", "SWR") Ownable(initialOwner) { }

    struct Sword {
        uint ID;
        uint power;
        uint8 plus;
        bool isEquip;
    }

    mapping(uint => Sword) public idToSwords;

    function showIsEquip(uint _id) public view returns(bool) {
        return idToSwords[_id].isEquip;
    }
 
    function changeEquip(uint _id, bool _chance) public {
        idToSwords[_id].isEquip = _chance;
    }

    function safeMint(address to) public onlyOwner {
       
        //uint256 tokenId = _tokenIdCounter.current();
        uint8 additionalPower = rand(30);
        Sword memory swordd;
        
        swordd.ID = 0;
        swordd.power = additionalPower;
        idToSwords[0] = swordd;
        _safeMint(to, 0);

        //_tokenIdCounter.increment();
    }

    function setSwordMap(uint _id, uint _power, uint8 _plus) public {
        idToSwords[_id].power = _power;
        idToSwords[_id].plus = _plus;
    }

    function burn(uint256 tokenId) public override onlyOwner{
        //solhint-disable-next-line max-line-length
        _burn(tokenId);
    }

    function viewSword(uint _id) public view returns(Sword memory){
        return idToSwords[_id];
    }

    function rand(uint8 range) private view returns(uint8) {
        return uint8(uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)))) % range ;
    }

}