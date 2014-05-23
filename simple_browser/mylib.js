var mylib = {};
(function(){

var privateAddFive = function(a) {
  return 5 + a;
};

mylib.publicAddSix = function(b) {
  return privateAddFive(b) + 1;
};

})();
