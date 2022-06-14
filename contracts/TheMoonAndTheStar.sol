// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Base64.sol";

contract TheMoonAndTheStar is ERC721Enumerable, Ownable {
  using Strings for uint256;
  uint256 public cost = 0.05 ether;
  uint256 public maxSupply = 10000;
  bool public paused = false;
  struct Circ {
    string name;
    string description;
    string circx;
    string circy;
  }
  struct ImageInfo {
    string name;
    string description;
    uint256 starx;
    uint256 stary;
    uint256 stara;
    uint256 starb;
    uint256 starc;
    uint256 stard;
    uint256 stare;
    uint256 starf;
    uint256 starg;
    uint256 starh;
    uint256 moonx;
    uint256 moony;
    uint256 moonwidth;
    }

  mapping (uint256 => Circ) public circles;
  mapping (uint256 => ImageInfo) public coordinates;

  constructor() ERC721("Circle", "C") {}

  // public
  function mint() public payable {
    uint256 supply = totalSupply();
    require(!paused);
    require(supply + 1 <= maxSupply);

    // set canvas length plus margin
    // Circ memory newCircle = Circ(
    //   string(abi.encodePacked('C #',uint256(supply + 1).toString())),
    //   "This is an on chain nft test",
    //   randomNum(500,block.difficulty,supply).toString(),
    //   randomNum(500,block.timestamp,supply).toString()
    // );
    ImageInfo memory newCoordinates = ImageInfo(
        string(abi.encodePacked('Moon and Star #',uint256(supply + 1).toString())),
        "This is an on chain nft test",
        randomNum(600,block.difficulty,supply).toString(),
        randomNum(500,block.timestamp,supply).toString(),

    )

    if (msg.sender != owner()) {
      require(msg.value >= cost);
    }

    circles[supply + 1] = newCircle;
    _safeMint(msg.sender, supply + 1);
  }

  function randomNum(uint256 _mod, uint256 _seed, uint256 _salt) public view returns(uint256) {
    uint256 num = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, _seed, _salt))) % _mod;
    return num + 50; // set required margin
  }

  // calculations done here
  function buildImage(uint256 _tokenId) public pure returns(string memory) {
    //function buildImage(uint256 _tokenId) public pure returns(string memory) {
    // Circ memory currentCircle = circles[_tokenId];
    uint256 x = _tokenId;
    x = x + 50;
    
    // ImageInfo memory imageCoordinates = ImageInfo(
    //   250 + _tokenId,
    //   100,
    //   242,
    //   123,
    //   261,
    //   109,
    //   238,
    //   109,
    //   258,
    //   123,
    //   200,
    //   200,
    //   60
    // );
    return Base64.encode(bytes(abi.encodePacked(
      '<svg height="1024" width="1024" xmlns="http://www.w3.org/2000/svg">',
      '<rect width="1024" height="1024" fill="black" />',
     //'<polygon points="',imageCoordinates.starx.toString(),' ', imageCoordinates.stary.toString(),' ', imageCoordinates.stara.toString(),' ', imageCoordinates.starb.toString(),' ', imageCoordinates.starc.toString(),' ', imageCoordinates.stard.toString(),' ', imageCoordinates.stare.toString(),' ', imageCoordinates.starf.toString(),' ', imageCoordinates.starg.toString(),' ', imageCoordinates.starh.toString() ,'" fill="white"/>',
     '',buildStar(),
     '',buildMoon(),
    //  '<path d="M',imageCoordinates.moonx.toString(),' ',imageCoordinates.moony.toString(),' A10 10 0 1 0 ',imageCoordinates.moonx.toString(),' ',(imageCoordinates.moony+70).toString(),' A',imageCoordinates.moonwidth.toString(), ' 55 0 0 1 ',imageCoordinates.moonx.toString(),' ',imageCoordinates.moony.toString(), ' Z" transform="rotate(-40, 150, 150)" fill="white"/>',
    //  '<path d="M',imageCoordinates.moonx.toString(),' ',imageCoordinates.moony.toString(),' A10 10 0 1 0 ',imageCoordinates.moonx.toString(),' ',(imageCoordinates.moony+70).toString(),' A',imageCoordinates.moonwidth.toString(), ' 55 0 0 1 ',imageCoordinates.moonx.toString(),' ',imageCoordinates.moony.toString(), ' Z" transform="rotate(-40, 150, 150)" fill="white"/>',
    // '<polygon points="',starx,' ', stary,' ', stara,' ', starb,' ', starc,' ', stard,' ', stare,' ', starf,' ', starg,' ', starh ,'" fill="white"/>',
    // '<path d="M',moonx.toString(),' ',moony.toString(),' A10 10 0 1 0 ',moonx.toString(),' ',(moony+70).toString(),' A',moonwidth.toString(), ' 55 0 0 1 ',moonx.toString(),' ',moony.toString(), ' Z" transform="rotate(-40, 150, 150)" fill="white"/>',
    // '<path d="M',moonx,' ',moony,' ', 'A10 10 0 1 0 ', moonx,' ',moony+70, ' A',moonwidth, ' 55 0 0 1 ',moonx,' ',moony, ' Z" transform="rotate(-40, 150, 150)" fill="white"/>',

      '</svg>'
    )));
  }

  function buildStar(uint256 _tokenId) public pure returns(string memory) {
    ImageInfo memory currentCoordinates = coordinates[_tokenId];
    ImageInfo memory imageCoordinates = ImageInfo(
      250,
      100,
      242,
      123,
      261,
      109,
      238,
      109,
      258,
      123,
      200,
      200,
      60
    );
    return string(abi.encodePacked('<polygon points="',imageCoordinates.starx.toString(),' ', imageCoordinates.stary.toString(),' ', imageCoordinates.stara.toString(),' ', imageCoordinates.starb.toString(),' ', imageCoordinates.starc.toString(),' ', imageCoordinates.stard.toString(),' ', imageCoordinates.stare.toString(),' ', imageCoordinates.starf.toString(),' ', imageCoordinates.starg.toString(),' ', imageCoordinates.starh.toString() ,'" fill="white"/>'));
    
  }

  function buildMoon(uint256 _tokenId) public pure returns(string memory){
    ImageInfo memory currentCoordinates = coordinates[_tokenId];
    ImageInfo memory imageCoordinates = ImageInfo(
      250,
      100,
      242,
      123,
      261,
      109,
      238,
      109,
      258,
      123,
      200,
      200,
      60
    );

    return string(abi.encodePacked('<path d="M',imageCoordinates.moonx.toString(),' ',imageCoordinates.moony.toString(),' A10 10 0 1 0 ',imageCoordinates.moonx.toString(),' ',(imageCoordinates.moony+70).toString(),' A',imageCoordinates.moonwidth.toString(), ' 55 0 0 1 ',imageCoordinates.moonx.toString(),' ',imageCoordinates.moony.toString(), ' Z" transform="rotate(-40, 150, 150)" fill="white"/>'));
  }

  // function walletOfOwner(address _owner)
  //   public
  //   view
  //   returns (uint256[] memory)
  // {
  //   uint256 ownerTokenCount = balanceOf(_owner);
  //   uint256[] memory tokenIds = new uint256[](ownerTokenCount);
  //   for (uint256 i; i < ownerTokenCount; i++) {
  //     tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
  //   }
  //   return tokenIds;
  // }

  function tokenURI(uint256 _tokenId)
    public
    view
    virtual
    override
    returns (string memory)
  {
    require(
      _exists(_tokenId),
      "ERC721Metadata: URI query for nonexistent token"
    );
    Circ memory currentCircle = circles[_tokenId];
    return string(abi.encodePacked(
      'data:application/json;base64,', Base64.encode(bytes(abi.encodePacked(
        '{"name":"',
        currentCircle.name,
        '", "description":"',
        currentCircle.description,
        '", "image":"',
        'data:image/svg+xml;base64,',
        buildImage(_tokenId),
        //attributes
        '", "attributes": [',
        '{',
        '"trait_type":"x-pos",',
        '"value":',
        currentCircle.circx,
        '},',
        '{',
        '"trait_type":"y-pos",',
        '"value":',
        currentCircle.circy,
        '}',
        ']',
        '}'
      )))));
  }

  //only owner
    
  function setCost(uint256 _newCost) public onlyOwner {
    cost = _newCost;
  }

  function pause(bool _state) public onlyOwner {
    paused = _state;
  }
 
  function withdraw() public payable onlyOwner {
    (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
    require(success);
  }
}