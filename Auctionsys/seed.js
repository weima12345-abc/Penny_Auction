EcommerceStore_chenjunjie = artifacts.require("./EcommerceStore_chenjunjie.sol");

module.exports = function() {
    amt_1 = web3.utils.toWei('1', 'ether');
    current_time = Math.round(new Date() / 1000);
    EcommerceStore_chenjunjie.deployed().then(function(i) {i.addProductToStore('HUAWEI P90', 'Cell Phone made in China', 'Qma8bkQfx43QEEUnURck1H4VDthvvX8WjxDWPRULF7PaHY', 'Qma2sibrxHBB77YqZz1HThf3CTXe9sCfUqixJ8934FabxG', current_time, current_time + 400, amt_1, 0).then(function(f) {console.log(f)})});
    EcommerceStore_chenjunjie.deployed().then(function(i) {i.addProductToStore('IPHONE 8', 'IOS Cell Phone', 'QmXG3AztqzfRz7b89S8Dx1EXtvUywYLa3x1wzUECFL7S6p', 'Qma2sibrxHBB77YqZz1HThf3CTXe9sCfUqixJ8934FabxG', current_time, current_time + 400, amt_1, 0).then(function(f) {console.log(f)})});
    EcommerceStore_chenjunjie.deployed().then(function(i) {i.productIndex_chenjunjie.call().then(function(f){console.log(f)})});
}