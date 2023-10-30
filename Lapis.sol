// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Lapis is ERC1155, ERC1155Burnable, Ownable {

    constructor() ERC1155("") {

        lapis[0] = 20; // str
        lapis[1] = 15; // dex
        lapis[2] = 10; // luc
        lapis[3] = 5;  // rec

    }


    //mapping(uint => lapis) public lapiss;,
    mapping(uint32 => uint32) public lapis;

    function viewLapis(uint32 _lapisId) public view returns(uint32) {
        return lapis[_lapisId];
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data)
        public
        onlyOwner
    {
        _mint(account, id, amount, data);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }

    function burn(
        address account,
        uint256 id,
        uint256 value
    ) public override onlyOwner{
        _burn(account, id, value);
    }

}