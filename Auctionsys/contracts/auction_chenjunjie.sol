// SPDX-License-Identifier: UNLISENSED
pragma solidity ^0.8.0;

contract auction_chenjunjie {
    enum ProductStatus_chenjunjie { Open, Sold, Notsold }
    enum ProductCondition_chenjunjie { New, Old }

    uint public productIndex_chenjunjie;
    mapping (address => mapping(uint => ProductInfo_chenjunjie)) stores_chenjunjie;
    mapping (uint => address) productIdInStore_chenjunjie;

    struct ProductInfo_chenjunjie {
        uint id;
        string name;
        string category;
        uint auctionStartTime;
        uint auctionEndTime;
        uint startPrice;
        address highestBidder;
        uint highestBid;
        uint secondHighestBid;
        uint totalBids;
        ProductStatus_chenjunjie status;
        ProductCondition_chenjunjie condition;
        mapping(address => mapping(bytes32 => BidInfo_chenjunjie)) bids;
    }

    struct BidInfo_chenjunjie {
        address bidder;
        uint productId;
        uint value;
        bool reveal_status;
    }

    constructor() {
        productIndex_chenjunjie = 0;
    }

    function addProductToStore(string memory _name, string memory _category,
    uint _auctionStartTime,uint _auctionEndTime, uint _startPrice, uint _productCondition) public {
        require(_auctionStartTime < _auctionEndTime, "Auction start time must be earlier than the end time");
        productIndex_chenjunjie += 1;
        ProductInfo_chenjunjie storage product = stores_chenjunjie[msg.sender][productIndex_chenjunjie];
        product.id = productIndex_chenjunjie;
        product.name = _name;
        product.category = _category;
        product.auctionStartTime = _auctionStartTime;
        product.auctionEndTime = _auctionEndTime;
        product.startPrice = _startPrice;
        product.status = ProductStatus_chenjunjie.Open;
        product.condition = ProductCondition_chenjunjie(_productCondition);
        productIdInStore_chenjunjie[productIndex_chenjunjie] = msg.sender;
    }

    function getProduct(uint _productId) view public returns (uint, string memory, string memory,
    uint, uint, uint, ProductStatus_chenjunjie, ProductCondition_chenjunjie) {
        ProductInfo_chenjunjie storage product = stores_chenjunjie[productIdInStore_chenjunjie[_productId]][_productId];
        return (product.id, product.name, product.category, product.auctionStartTime,
         product.auctionEndTime, product.startPrice, product.status, product.condition);
    }

    function bid(uint _productId, bytes32 _bid) payable public returns(bool) {
        ProductInfo_chenjunjie storage product = stores_chenjunjie[productIdInStore_chenjunjie[_productId]][_productId];
        require(block.timestamp >= product.auctionStartTime, "Auction start time must be earlier");
        require(block.timestamp <= product.auctionEndTime, "Auction end time must be later");
        require(msg.value > product.startPrice, "The value must be larger than start price");
        require(product.bids[msg.sender][_bid].bidder == address(0), "The bidder must be null");
        product.bids[msg.sender][_bid] = BidInfo_chenjunjie(msg.sender, _productId, msg.value, false);
        product.totalBids += 1;
        return true;
    }

    function bidcheck(uint _productId, string memory _amount, string memory _secretkey) public {
        ProductInfo_chenjunjie storage product = stores_chenjunjie[productIdInStore_chenjunjie[_productId]][_productId];
        require(block.timestamp >= product.auctionEndTime, "Auction did not end yet");
        bytes32 sealedBid = keccak256(abi.encodePacked(_amount, _secretkey));
        BidInfo_chenjunjie memory bidDetails = product.bids[msg.sender][sealedBid];
        require(bidDetails.bidder > address(0), "Bidder must exist");
        require(bidDetails.reveal_status == false, "Bid has been revealed");
        uint amount = stringToUint(_amount);
        uint drawback;
        if (bidDetails.value < amount) {
            drawback = bidDetails.value;
        } else {
            if (address(product.highestBidder) == address(0)) {
                product.highestBidder = msg.sender;
                product.highestBid = amount;
                product.secondHighestBid = product.startPrice;
                drawback = bidDetails.value - amount;
            } else {
                if (amount > product.highestBid) {
                    product.secondHighestBid = product.highestBid;
                    payable(product.highestBidder).transfer(product.highestBid);
                    product.highestBid = amount;
                    product.highestBidder = msg.sender;
                    drawback = bidDetails.value - amount;
                } else if (amount > product.secondHighestBid) {
                    product.secondHighestBid = amount;
                    drawback = bidDetails.value;
                } else {
                    drawback = bidDetails.value;
                }
            }
        }
        if (drawback > 0) {
            payable(msg.sender).transfer(drawback);
        }
        product.bids[msg.sender][sealedBid].reveal_status = true;
    }

    function stringToUint(string memory s) private pure returns(uint) {
        bytes memory b = (bytes(s));
        uint result = 0;
        for (uint i = 0; i < b.length; i++) {
            if (b[i] >= 0x30 && b[i] <= 0x39) {
                result = result * 10 + (uint(uint8(b[i])) - 48);
            }
        }
        return result;
    }

    function highestBidderDetails(uint _productId) public view returns(address, uint, uint) {
        ProductInfo_chenjunjie storage product = stores_chenjunjie[productIdInStore_chenjunjie[_productId]][_productId];
        return (product.highestBidder, product.highestBid, product.secondHighestBid);
    }

    function totalBids(uint _productId) public view returns(uint) {
        ProductInfo_chenjunjie storage product = stores_chenjunjie[productIdInStore_chenjunjie[_productId]][_productId];
        return product.totalBids;
    }
}