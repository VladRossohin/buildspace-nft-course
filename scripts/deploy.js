const main = async () => {
  const [deployer] = await hre.ethers.getSigners();
  const accountBalance = await deployer.getBalance();

  console.log("Deploying with account: ", deployer.address);
  console.log(
    "Account balance: ",
    hre.ethers.utils.formatEther(accountBalance)
  );

  const nftContractFactory = await hre.ethers.getContractFactory("MyEpicNFT");
  const nftContract = await nftContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.001"),
    // gasPrice: "1000000",
  });
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
