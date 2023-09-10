var MyContract = artifacts.require("Election");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(MyContract);
};