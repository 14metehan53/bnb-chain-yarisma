// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RISEIN is ERC20, ERC20Burnable, Ownable {
    constructor(address initialOwner) ERC20("RISEIN", "RSN") Ownable(initialOwner) {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burnFrom(address account, uint256 amount) public override onlyOwner {
        _burn(account, amount);
    }
}