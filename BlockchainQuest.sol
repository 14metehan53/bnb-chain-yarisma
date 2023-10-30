// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "./Sword.sol";
import "./Gold.sol";
import "./Consumable.sol";
import "./SafetyScroll.sol";
import "./Lapis.sol";

contract Game {

    SWORD private sword;
    RISEIN private gold;
    Consumable private consumable;
    SafetyScroll private scroll;
    Lapis private lapis;

    // @@@ EVENTS @@@
    event PlayerRegistered(address indexed player);
    event MobDefeated(string mobName, uint256 reward);
    event SwordEnhanced(uint256 swordID, uint256 newPower);
    event SwordEnchanted(uint256 swordID, uint256 newPower);

    struct Player {
        uint health;
        uint maxHealth;
        uint attackPower;
        uint swordID;
        bool isRegistered;
        uint money;
        uint lastAttack;
    }

    struct Mob {
        string name;
        uint health;
        uint maxHealth;
        uint attackPower;
        uint gold;
    }

    struct Item {
        string name;
        uint ID;
        uint price;
        uint power;
    }

    constructor(address _consumableAddress, address _swordAddress, address _goldAddress, address _scrollAddress, address _lapisAddress) {
        consumable = Consumable(_consumableAddress);
        sword      = SWORD(_swordAddress);
        gold       = RISEIN(_goldAddress);
        scroll     = SafetyScroll(_scrollAddress);
        lapis      = Lapis(_lapisAddress);

        // npc items
        addItem("smallPotion", 0, 50, 50);
        addItem("middlePotion", 1, 100, 150);
        addItem("bigPotion", 2, 200, 400);

        // mobs, mini boss and boss
        addMob("fox",100,5,100);
        addMob("kimuraku",100,15,900);
        addMob("opalus",100,22,1200);
        addMob("seraphim",100,26,2800);

    }

    mapping(address => Player) private players;
    mapping(uint => Item) public idToItems;

    uint8 private gift;

    Mob[] public mob;

    function startReset() external {
        require(players[msg.sender].isRegistered == false);

        Player memory player;

        player.health = 100;
        player.maxHealth = 100;
        player.attackPower = 20;
        player.isRegistered = true;
        players[msg.sender] = player;

        emit PlayerRegistered(msg.sender);
    }

    // fox(mob), chimera(mob)
    function fox() checkRegister external {

        if (players[msg.sender].attackPower >= mob[0].health) {
            uint8 possibility = rand(10);

            players[msg.sender].health -= mob[0].attackPower;
            mob[0].health               = mob[0].maxHealth;

            gold.mint(msg.sender, mob[0].gold);

            players[msg.sender].money += gold.balanceOf(msg.sender);

            if (possibility <= 9) {
                sword.safeMint(msg.sender);
            }

            emit MobDefeated(mob[0].name, mob[0].gold);

        } else if (players[msg.sender].health <= mob[0].attackPower) {

            players[msg.sender].isRegistered = false; 

        } else {
            players[msg.sender].health -= mob[0].attackPower;
            mob[0].health              -= players[msg.sender].attackPower;
        }
    }


    // kimuraku(mini boss), opalus(boss) seraphim(boss)
    function kimuraku() checkRegister external {

        if (players[msg.sender].attackPower >= mob[1].health) {
            uint8 possibility = rand(10);

            players[msg.sender].health -= mob[1].attackPower;
            mob[1].health               = mob[2].maxHealth;

            gold.mint(msg.sender, mob[1].gold);

            players[msg.sender].money += gold.balanceOf(msg.sender);

            if(possibility <= 9) {
                // random lapis
                uint8 randNumber = rand(4);
                lapis.mint(msg.sender, randNumber, 1, "");
            }

            emit MobDefeated(mob[1].name, mob[1].gold);

        } else if (players[msg.sender].health <= mob[1].attackPower) {

            players[msg.sender].isRegistered = false; 

        } else {
            players[msg.sender].health -= mob[1].attackPower;
            mob[1].health              -= players[msg.sender].attackPower;
        }
    }

    function opalus() checkRegister external {

        if (players[msg.sender].attackPower >= mob[2].health) {
            uint8 possibility = rand(10);

            players[msg.sender].health -= mob[2].attackPower;
            mob[2].health               = mob[2].maxHealth;

            gold.mint(msg.sender, mob[3].gold);

            players[msg.sender].money += gold.balanceOf(msg.sender);

            if(possibility <= 9) {
                // safety scroll
                scroll.mint(msg.sender, 0, 1, "");
            }

            emit MobDefeated(mob[2].name, mob[2].gold);

        } else if (players[msg.sender].health <= mob[2].attackPower) {

            players[msg.sender].isRegistered = false; 

        } else {
            players[msg.sender].health -= mob[2].attackPower;
            mob[2].health              -= players[msg.sender].attackPower;
        }

    }

    function seraphim() checkRegister external {

        if (players[msg.sender].attackPower >= mob[3].health) {
            uint8 possibility = rand(10);

            players[msg.sender].health -= mob[3].attackPower;
            mob[3].health               = mob[3].maxHealth;

            gold.mint(msg.sender, mob[3].gold);

            players[msg.sender].money += gold.balanceOf(msg.sender);

            if(possibility <= 9) {
                // safety scroll, lapis, gold, sword
                uint8 randNumber = rand(4);

                scroll.mint(msg.sender, 0, 1, "");
                lapis.mint(msg.sender, randNumber, 1, "");
                gold.mint(msg.sender, 2800);
                sword.safeMint(msg.sender);
            }

            emit MobDefeated(mob[3].name, mob[3].gold);

        } else if (players[msg.sender].health <= mob[3].attackPower) {

            players[msg.sender].isRegistered = false; 

        } else {
            players[msg.sender].health -= mob[3].attackPower;
            mob[3].health              -= players[msg.sender].attackPower;
        }

    }

    function showPlayer() external view returns(uint,uint,uint,uint,bool,uint) {
        return (
            players[msg.sender].health,
            players[msg.sender].maxHealth,
            players[msg.sender].attackPower,
            players[msg.sender].swordID,
            players[msg.sender].isRegistered,
            gold.balanceOf(msg.sender)
        );
    }

    function equip(uint _id) ownerOf(_id) external {
        uint attackPower =  sword.viewSword(_id).power;

        // aynı itemi birden fazla giyebiliyorduk şimdi ise aynı itemden bir kez giyebiliyoruz
        if(!sword.showIsEquip(_id) == true) {
            sword.changeEquip(_id,true);

            players[msg.sender].swordID = _id;
            players[msg.sender].attackPower += attackPower;

        } else {
            uint id      = players[msg.sender].swordID;
            uint attackk = sword.viewSword(id).power;

            players[msg.sender].attackPower -= attackk;
            players[msg.sender].attackPower += attackPower;
        }
        
    }

    function usePotion(uint _id) external {
        require(consumable.balanceOf(msg.sender, _id) > 0, "No potion with this ID found");

        consumable.burn(msg.sender, _id, 1);

        if((players[msg.sender].health + idToItems[_id].power) >=  players[msg.sender].health) {

            players[msg.sender].health = players[msg.sender].maxHealth;
            
        } else {
            players[msg.sender].health += idToItems[_id].power;
        }
    }

    function freeStarterPack() checkGift external {
        // Free Starter Pack
        sword.safeMint(msg.sender); // random stat sword
        gold.mint(msg.sender, 200000); // 2500 gold
        consumable.mint(msg.sender, 1, 20, ""); // 20 potion
        scroll.mint(msg.sender, 0, 50, ""); // 50 scroll
        lapis.mint(msg.sender, 0, 10, ""); // 10 str
        lapis.mint(msg.sender, 1, 10, ""); // 10 dex
        lapis.mint(msg.sender, 2, 10, ""); // 10 luc
        lapis.mint(msg.sender, 3, 10, ""); // 10 rec

        // used gift
        unchecked {
            gift += 1;
        }
    }

    function buyPotion(uint8 _id, uint16 _amount) external {
        uint price = idToItems[_id].price * _amount;

        require(gold.balanceOf(msg.sender) >= price, "You don't have money to buy potions.");

        gold.burnFrom(msg.sender, price);
        players[msg.sender].money -= price;
        consumable.mint(msg.sender, _id, _amount, "");
    }

    function addItem(string memory _name, uint _id, uint _price, uint _power) private {
        Item memory item;

        item.name      = _name;
        item.ID        = _id;
        item.price     = _price;
        item.power     = _power;
        idToItems[_id] = item;
    }

    // enchant sword
    function enchant(uint8 _id) ownerOf(_id) external  {
        uint8 possibility = rand(11);

        if (possibility >= sword.viewSword(_id).plus) {
            // safety scroll and 500 gold are required to upgrade the sword
            if (scroll.balanceOf(msg.sender,0) > 0 && gold.balanceOf(msg.sender) >= 500) {
                gold.burnFrom(msg.sender, 500);
                scroll.burn(msg.sender, 0, 1);

                uint8 extraPower = rand(21);
                sword.setSwordMap(_id, sword.viewSword(_id).power += extraPower, sword.viewSword(_id).plus +1 );
                if (sword.showIsEquip(_id)) {
                    players[msg.sender].attackPower                    = (20 + sword.viewSword(_id).power);
                }

                emit SwordEnchanted(_id, sword.viewSword(_id).power);
            }
        } else {
            players[msg.sender].swordID = 0;
            sword.burn(_id);
            players[msg.sender].attackPower = 20; // default attack power
            sword.changeEquip(_id, false); // unequip sword
        }
    }

    function blackSmith(uint16 _swordId, uint32 _lapisId) ownerOf(_swordId) external {
        require(scroll.balanceOf(msg.sender, 0) > 0, "You do not have safety scroll");
        require(lapis.balanceOf(msg.sender, _lapisId) > 0, "No lapis with id found");
        require(gold.balanceOf(msg.sender) >= 500, "You have less than 500 gold balance");

        uint8 possibility = rand(7);

        if (possibility <= 4) {
            if (lapis.balanceOf(msg.sender, _lapisId) > 0 && gold.balanceOf(msg.sender) >= 500) {
                sword.setSwordMap(_swordId, sword.viewSword(_swordId).power += lapis.viewLapis(_lapisId), sword.viewSword(_swordId).plus);
                
                if (sword.showIsEquip(_swordId)) {
                    players[msg.sender].attackPower = (20 + sword.viewSword(_swordId).power);
                }

                lapis.burn(msg.sender, _lapisId, 1);
                gold.burnFrom(msg.sender, 500);

                emit SwordEnhanced(_swordId, sword.viewSword(_swordId).power);
            }
        } else {
            scroll.burn(msg.sender, 0, 1);
            gold.burnFrom(msg.sender, 500);
            lapis.burn(msg.sender, _lapisId, 1);
        }
    }

    function addMob(string memory _mobName, uint _maxHealth, uint _attackPower, uint _gold) private {
        Mob memory mobb;

        mobb.name        = _mobName;
        mobb.health      = _maxHealth;
        mobb.maxHealth   = _maxHealth;
        mobb.attackPower = _attackPower;
        mobb.gold        = _gold;

        mob.push(mobb);
    }

    function rand(uint8 range) private view returns(uint8) {
        return uint8(uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)))) % range ;
    }

    modifier checkGift {
        require(gift < 1, "you already used the gift");
        _;
    }

    modifier ownerOf(uint _id) {
        require(sword.ownerOf(_id) == msg.sender);
        _;
    }

    modifier checkRegister {
        require(!players[msg.sender].isRegistered == false, "please start game!");
        _;
    }

}