const hre = require('hardhat');
const fs = require('fs');

async function main() {
  const deployer = (await hre.ethers.getSigners())[0]; // Deployer's address

  const RISEIN = await hre.ethers.getContractFactory('RISEIN');
  const risein = await RISEIN.deploy(deployer.address);
  await risein.deployed();

  const Sword = await hre.ethers.getContractFactory('SWORD');
  const sword = await Sword.deploy(deployer.address);
  await sword.deployed();

  const Consumable = await hre.ethers.getContractFactory('Consumable');
  const consumable = await Consumable.deploy(deployer.address);
  await consumable.deployed();

  const SafetyScroll = await hre.ethers.getContractFactory('SafetyScroll');
  const scroll = await SafetyScroll.deploy(deployer.address);
  await scroll.deployed();

  const Lapis = await hre.ethers.getContractFactory('Lapis');
  const lapis = await Lapis.deploy(deployer.address);
  await lapis.deployed();

  console.log('Gold deployed to:', risein.address);
  console.log('Sword deployed to:', sword.address);
  console.log('Consumable deployed to:', consumable.address);
  console.log('SafetyScroll deployed to:', scroll.address);
  console.log('Lapis deployed to:', lapis.address);

  // Deploy the Game contract
  const Game = await hre.ethers.getContractFactory('Game');
  const game = await Game.deploy(
    consumable.address,
    sword.address,
    risein.address,
    scroll.address,
    lapis.address
  );
  await game.deployed();

  console.log('Game deployed to:', game.address);

  let config = `module.exports = {
    consumableaddress : "${consumable.address}",
    swordaddress : "${sword.address}",
    goldaddress : "${risein.address}",
    scrolladdress : "${scroll.address}",
    lapisaddress : "${lapis.address}",
    gameaddress : "${game.address}",
  }
  `;
  let data = JSON.stringify(config);
  fs.writeFileSync('config.js', JSON.parse(data));
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
