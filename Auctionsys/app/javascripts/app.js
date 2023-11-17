// Import the page's CSS. Webpack will know what to do with it.
import "../stylesheets/app.css";

// Import libraries we need.
import { default as Web3 } from "web3";
import { default as contract } from "truffle-contract";
import ecommerce_store_artifacts from "../../build/contracts/auction_chenjunjie.json";

var auction_chenjunjie = contract(ecommerce_store_artifacts);

const ethUtil = require("ethereumjs-util");

window.App = {
  start: function() {
    var self = this;
    auction_chenjunjie.setProvider(web3.currentProvider);
    renderStore();
    $("#add-item-to-store").submit(function(event) {
      const req = $("#add-item-to-store").serialize();
      console.log("req: ", req);
      let params = JSON.parse(
        '{"' +
          req
            .replace(/"/g, '\\"')
            .replace(/&/g, '","')
            .replace(/=/g, '":"') +
          '"}'
      );
      console.log("params: ", params);
      let decodedParams = {};
      Object.keys(params).forEach(function(v) {
        decodedParams[v] = decodeURIComponent(decodeURI(params[v]));
      });
      saveProduct(decodedParams);
      event.preventDefault();
    });
  },
};

function renderStore() {
  auction_chenjunjie.deployed().then(function(i) {
    i.getProduct.call(1).then(function(p) {
      $("#product-list").append(buildProduct(p));
    });
    i.getProduct.call(2).then(function(p) {
      $("#product-list").append(buildProduct(p));
    });
  });
}

function buildProduct(product) {
  let node = $("<div/>");
  node.addClass("col-sm-3 text-center col-margin-bottom-1");
  node.append("<div>" + product[1] + "</div>");
  node.append("<div>" + product[2] + "</div>");
  node.append("<div>" + product[5] + "</div>");
  node.append("<div>" + product[6] + "</div>");
  node.append("<div>Ether " + product[7] + "</div>");
  return node;
}

function saveProduct(decodedParams) {
  saveProductToBlockchain(decodedParams);
}

function saveProductToBlockchain(params) {
  console.log(params);
  let auctionStartTime = Date.parse(params["product-auction-start"]) / 1000;
  let auctionEndTime =
    auctionStartTime + parseInt(params["product-auction-end"]) * 24 * 60 * 60;
  web3.eth.getAccounts().then(function(acc) {
    accounts = acc;
  });
  auction_chenjunjie.deployed().then(function(i) {
    i.addProductToStore(
      params["product-name"],
      params["product-category"],
      auctionStartTime,
      auctionEndTime,
      web3.utils.toWei(params["product-price"], "ether"),
      parseInt(params["product-condition"]),
      { from: accounts[0], gas: 440000 }
    ).then(function(f) {
      console.log(f);
      $("#msg").show();
      $("#msg").html("Your product was successfully added to your store!");
    });
  });
}

window.addEventListener("load", function() {
  // Checking if Web3 has been injected by the browser (Mist/MetaMask)
  if (typeof web3 !== "undefined") {
    console.warn(
      "Using web3 detected from external source. If you find that your accounts don't appear or you have 0 MetaCoin, ensure you've configured that source properly. If using MetaMask, see the following link. Feel free to delete this warning. :) http://truffleframework.com/tutorials/truffle-and-metamask"
    );
    // Use Mist/MetaMask's provider
    window.web3 = new Web3(web3.currentProvider);
  } else {
    console.warn(
      "No web3 detected. Falling back to http://localhost:8545. You should remove this fallback when you deploy live, as it's inherently insecure. Consider switching to Metamask for development. More info here: http://truffleframework.com/tutorials/truffle-and-metamask"
    );
    // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
    window.web3 = new Web3(
      new Web3.providers.HttpProvider("http://localhost:8545")
    );
  }

  App.start();
});
