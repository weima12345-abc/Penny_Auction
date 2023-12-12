# Penny_Auction
基于区块链智能合约开发的竞拍系统

Webpack Truffle Box
This box it our most bare official implementation with Webpack. Includes contracts, migrations, tests, user interface and webpack build pipeline.

1. 下载全局truffe
npm install -g truffle

2. 下载依赖
truffle unbox webpack

3. 运行
truffle develop

4. 编译和迁移智能合约。请注意，在开发控制台中，我们不会在命令前面加上truffle
compile
migrate

5.运行 webpack 服务器进行前端热重载（在开发控制台之外）。智能合约更改必须手动重新编译和迁移。
// Serves the front-end on http://localhost:8080
npm run dev

6.Truffle 可以针对您的智能合约运行用 Solidity 或 JavaScript 编写的测试。请注意，如果您在开发控制台内或外部，该命令会略有不同。
test
// If outside the development console..
truffle test

————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

其他

如何将其与 EthereumJS TestRPC 一起使用？
就像修改配置文件一样简单！查看有关添加网络配置的文档。根据您使用的端口，您还需要更新 的第 96 行和第 98 行。app/javascripts/app.js

我遇到以下错误：错误：无法解决“../build/contracts/MetaCoin.json'
这意味着您尚未编译或迁移合同。运行 ，然后首先运行。truffle developcompilemigrate

完整错误：
ERROR in ./app/main.js
Module not found: Error: Can't resolve '../build/contracts/MetaCoin.json' in '/Users/tim/Documents/workspace/Consensys/test3/app'@ ./app/main.js 11:16-59


生成graphclient命令 ：    
配置   .graphclientrc.yml 文件
运行    graphclient build  命令


