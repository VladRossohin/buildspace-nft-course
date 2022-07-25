// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("RossohinNFT", "ROSSOHIN") {
        console.log("NFT contract sheesh");
    }

    function makeNft() public {
        uint256 newItemId = _tokenIds.current();

        _safeMint(msg.sender, newItemId);

        _setTokenURI(
            newItemId,
            "data:application/json;base64,ewogICAgIm5hbWUiOiAiRm91ckNvbG9yQ29tYm8iLAogICAgImRlc2NyaXB0aW9uIjogIkFuIE5GVCBnZW5lcmF0ZWQgYnkgcm9zc29oaW4iLAogICAgImltYWdlIjogImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjRiV3h1Y3owaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1qQXdNQzl6ZG1jaUlIQnlaWE5sY25abFFYTndaV04wVW1GMGFXODlJbmhOYVc1WlRXbHVJRzFsWlhRaUlIWnBaWGRDYjNnOUlqQWdNQ0F6TlRBZ016VXdJajQ4Y21WamRDQjNhV1IwYUQwaU1UQXdKU0lnYUdWcFoyaDBQU0l4TURBbElpQnpkSGxzWlQwaVptbHNiRG9qWVRnMElpOCtQSEpsWTNRZ2QybGtkR2c5SWpFd01DVWlJR2hsYVdkb2REMGlOelVsSWlCemRIbHNaVDBpWm1sc2JEb2pPRE0wSWk4K1BISmxZM1FnZDJsa2RHZzlJakV3TUNVaUlHaGxhV2RvZEQwaU5UQWxJaUJ6ZEhsc1pUMGlabWxzYkRvak1USXpJaTgrUEhKbFkzUWdkMmxrZEdnOUlqRXdNQ1VpSUdobGFXZG9kRDBpTWpVbElpQnpkSGxzWlQwaVptbHNiRG9qWVdabUlpOCtQSFJsZUhRZ2VEMGlOVEFsSWlCNVBTSTFNQ1VpSUdSdmJXbHVZVzUwTFdKaGMyVnNhVzVsUFNKdGFXUmtiR1VpSUhSbGVIUXRZVzVqYUc5eVBTSnRhV1JrYkdVaUlITjBlV3hsUFNKbWFXeHNPaU5tWm1ZN1ptOXVkQzFtWVcxcGJIazZjMlZ5YVdZN1ptOXVkQzF6YVhwbE9qRTBjSGdpUGtadmRYSkRiMnh2Y2tOdmJXSnZQQzkwWlhoMFBqd3ZjM1puUGc9PSIKfQ=="
        );

        console.log(
            "An NFT w/ ID %s has been minted to %s",
            newItemId,
            msg.sender
        );

        _tokenIds.increment();
    }
}
