require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.1",
  networks: {
    rinkeby: {
      url: process.env.ALCHEMY_RINKEBY_API_KEY_URL,
      accounts: [process.env.RINKEBY_PRIVATE_KEY],
      // gas: 2100000,
      // gasPrice: 8000000000,
      // saveDeployments: true,
    },
    goerli: {
      url: process.env.ALCHEMY_GOERLI_API_KEY_URL,
      accounts: [process.env.GOERLI_PRIVATE_KEY],
    },
  },
};
