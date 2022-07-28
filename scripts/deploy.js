const { ethers } = require("ethers");

const main = async () => {
  const [deployer] = await hre.ethers.getSigners();
  const accountBalance = await deployer.getBalance();

  const provider = new ethers.providers.JsonRpcProvider(
    process.env.ALCHEMY_RINKEBY_API_KEY_URL
  );

  const gasPrice = await provider.getGasPrice();
  console.log("Gas price: ", gasPrice);

  console.log(
    "Account balance: ",
    hre.ethers.utils.formatEther(accountBalance)
  );

  // console.log(hre.ethers.utils.parseUnits("2", "gwei"));

  console.log("Deploying with account: ", deployer.address);
  const nftContractFactory = await hre.ethers.getContractFactory("MyEpicNFT");
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log("Contract deployed to:", nftContract.address);

  // Call the function.
  let txn = await nftContract.makeNft();
  // Wait for it to be mined.
  await txn.wait();
  console.log("Minted NFT #1");
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
