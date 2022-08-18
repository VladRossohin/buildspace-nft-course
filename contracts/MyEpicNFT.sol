// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";
import {Base64} from "./libraries/Base64.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    event NewNftMinter(address, uint256);

    string baseSvg =
        "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    string[] adjectives = [
        "Annoyed",
        "Polite",
        "Maniacal",
        "Obsolete",
        "Fast",
        "Broken",
        "Repulsive",
        "Picayune",
        "Oval",
        "Relevant",
        "Fearful",
        "Hideous",
        "Plausible",
        "Interesting",
        "Efficient",
        "Mushy",
        "Significant",
        "Noiseless",
        "Entertaining",
        "Small"
    ];

    string[] names = [
        "Rem",
        "Saitama",
        "Kaneki",
        "Hikigaya",
        "Mikasa",
        "Itachi",
        "Eren",
        "Kurisu",
        "Guts",
        "Gintoki",
        "Naruto",
        "Elric",
        "Killua",
        "Okabe",
        "Yagami",
        "Zoro",
        "Luffy",
        "Lawliet",
        "Ackerman",
        "Lelouch"
    ];
    string[] verbs = [
        "Speaks",
        "Calls",
        "Comes",
        "Repairs",
        "Drinks",
        "Rests",
        "Expands",
        "Confronts",
        "Dominates",
        "Supplies",
        "Signs",
        "Deserves",
        "Earns",
        "Shines",
        "Wonders",
        "Ignores",
        "Highlights",
        "Suffers",
        "Collects",
        "Slides"
    ];

    constructor() ERC721("RossohinNFT", "ROSSOHIN") {
        console.log("NFT contract sheesh");
    }

    function pickRandomWord(uint256 tokenId, string[] memory array)
        public
        view
        returns (string memory)
    {
        // The random generator
        uint256 rand = random(
            string(
                abi.encodePacked(
                    Strings.toString(block.timestamp),
                    Strings.toString(tokenId)
                )
            )
        );
        // Squash the # between 0 and the length of the array to avoid going out of bounds.
        rand = rand % array.length;
        return array[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function makeNft() public {
        uint256 newItemId = _tokenIds.current();

        string memory firstWord = pickRandomWord(newItemId, adjectives);
        string memory secondWord = pickRandomWord(newItemId, names);
        string memory thirdWord = pickRandomWord(newItemId, verbs);
        string memory combinedWord = string(
            abi.encodePacked(firstWord, secondWord, thirdWord)
        );

        string memory finalSvg = string(
            abi.encodePacked(baseSvg, combinedWord, "</text></svg>")
        );

        // Get all the JSON metadata in place and base64 encode it.
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        // We set the title of our NFT as the generated word.
                        combinedWord,
                        '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
                        // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        // Just like before, we prepend data:application/json;base64, to our data.
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log("\n--------------------");
        console.log(
            string(
                abi.encodePacked(
                    "https://nftpreview.0xdev.codes/?code=",
                    finalTokenUri
                )
            )
        );
        console.log("--------------------\n");

        _safeMint(msg.sender, newItemId);

        // Update your URI!!!
        _setTokenURI(newItemId, finalTokenUri);

        _tokenIds.increment();
        console.log(
            "An NFT w/ ID %s has been minted to %s",
            newItemId,
            msg.sender
        );

        emit NewNftMinter(msg.sender, newItemId);
    }
}
