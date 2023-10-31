require('@nomicfoundation/hardhat-toolbox');
//require('@nomiclabs/hardhat-ethers');
module.exports = {
  solidity: '0.8.21',
  networks: {
    localhost: {
      url: 'http://127.0.0.1:8545', // localhost RPC
    },
  },
};
