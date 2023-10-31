const { expect } = require('chai');

describe('Game', function () {
  let Game;
  let game;
  let gold;
  let sword;
  let consumable;
  let scroll;
  let lapis;
  let owner;

  beforeEach(async function () {
    [owner] = await hre.ethers.getSigners();

    const GoldFactory = await ethers.getContractFactory('RISEIN');
    const gold = await GoldFactory.deploy(owner.address);
    await gold.deployed();

    const SwordFactory = await ethers.getContractFactory('SWORD');
    const sword = await SwordFactory.deploy(owner.address);
    await sword.deployed();

    const ConsumableFactory = await ethers.getContractFactory('Consumable');
    const consumable = await ConsumableFactory.deploy(owner.address);
    await consumable.deployed();

    const SafetyScrollFactory = await ethers.getContractFactory('SafetyScroll');
    const scroll = await SafetyScrollFactory.deploy(owner.address);
    await scroll.deployed();

    const LapisFactory = await ethers.getContractFactory('Lapis');
    const lapis = await LapisFactory.deploy(owner.address);
    await lapis.deployed();

    const GameFactory = await ethers.getContractFactory('Game');
    game = await GameFactory.deploy(
      consumable.address,
      sword.address,
      gold.address,
      scroll.address,
      lapis.address
    );
    await game.deployed();

    await gold.transferOwnership(game.address);
    await sword.transferOwnership(game.address);
    await consumable.transferOwnership(game.address);
    await scroll.transferOwnership(game.address);
    await lapis.transferOwnership(game.address);
  });

  it('claim a free starter pack', async function () {
    // Ücretsiz başlangıç paketini talep et
    await game.freeStarterPack();
  });

  it('should allow player to register', async function () {
    await game.startReset();
    const playerData = await game.showPlayer();
    const isRegistered = playerData[4];
    expect(isRegistered).to.equal(true);
  });

  it('should allow player to defeat a mob', async function () {
    await game.startReset();
    await game.fox(); // Assuming "fox" is a function to defeat a mob in your contract
    // Check relevant game state changes here
  });

  it('should allow player to equip a sword', async function () {
    await game.startReset();
    await game.freeStarterPack();
    await game.equip(0);
  });

  it('should allow player to enchant a sword', async function () {
    await game.startReset();
    await game.freeStarterPack();
    await game.equip(0);
    await game.enchant(0);
  });

  it('should allow player to use blacksmith', async function () {
    await game.startReset();
    await game.freeStarterPack();
    await game.equip(0);
    await game.blackSmith(0, 0);
  });
});
