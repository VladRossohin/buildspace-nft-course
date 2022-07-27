const main = async () => {
  const nftContractFactory = await hre.ethers.getContractFactory("MyEpicNFT");
  const nftContract = await nftContractFactory.deploy({
    value: hre.ethers.utils.parseEther("1"),
  });
  await nftContract.deployed();

  console.log("Contract deployed to:", nftContract.address);

  let txn = await nftContract.makeNft();
  await txn.wait();
  console.log("Minted NFT #1");

  // call the same
  txn = await nftContract.makeNft();
  await txn.wait();
  console.log("Minted NFT #2");
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (err) {
    console.log(JSON.stringify(err));
    process.exit(1);
  }
};

runMain();
