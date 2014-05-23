var privateAddFive = function(a) {
  return 5 + a;
};

module.exports.publicAddSix = function(b) {
  return privateAddFive(b) + 1;
};
