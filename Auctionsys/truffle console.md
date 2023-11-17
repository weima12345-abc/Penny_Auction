```solidity
$ truffle compile
$ truffle migrate
$ truffle console
truffle(development)>  amt_1 = web3.utils.toWei('1', 'ether');
'1000000000000000000'
truffle(development)>  current_time = Math.round(new Date() / 1000);
truffle(development)>  auction_chenjunjie.deployed().then(function(i) {i.addProductToStore('HUAWEI P90', 'Cell Phones made in China', 'imagelink', 'desclink', current_time, current_time + 2000, amt_1, 0).then(function(f) {console.log(f)})});
truffle(development)>  auction_chenjunjie.deployed().then(function(i) {i.getProduct.call(1).then(function(f) {console.log(f)})});
truffle(development)>  auction_chenjunjie.deployed().then(function(i) {i.getProduct.call(2).then(function(f) {console.log(f)})});
truffle(development)>  web3.eth.getAccounts().then(function(acc){ accounts = acc });
truffle(development)>  accounts[0];
'0x2dc193E86f01D70c32eE547c09A69F7B2955B1F2'
truffle(development)> web3.eth.getBalance(accounts[0])
'99952601300000000000'
truffle(development)> web3.eth.getBalance(accounts[1])
'100000000000000000000'
truffle(development)>  sealedBid = web3.utils.sha3((2 * amt_1) + 'mysecretacc1').toString('hex');
truffle(development)> auction_chenjunjie.deployed().then(function(i) {i.bid(1, sealedBid, {value: 3*amt_1, from: accounts[0]}).then(function(f) {console.log(f)})});
truffle(development)>  sealedBid = web3.utils.sha3((3 * amt_1) + 'mysecretacc2').toString('hex');
truffle(development)> auction_chenjunjie.deployed().then(function(i) {i.bid(1, sealedBid, {value: 3*amt_1, from: accounts[1]}).then(function(f) {console.log(f)})});
truffle(development)> web3.eth.getBalance(accounts[0])
'96897969480000000000'
truffle(development)> web3.eth.getBalance(accounts[1])
'96998078160000000000'
truffle(development)>  auction_chenjunjie.deployed().then(function(i) {i.bidcheck(1, (2*amt_1).toString(), 'mysecretacc1', {from: accounts[0]}).then(function(f) {console.log(f)})})
truffle(development)>  auction_chenjunjie.deployed().then(function(i) {i.bidcheck(1, (3*amt_1).toString(), 'mysecretacc2', {from: accounts[1]}).then(function(f) {console.log(f)})})


```