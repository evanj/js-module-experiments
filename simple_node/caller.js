var mylib = require('./mylib');

var privateAddFive = function(a) {
  console.log('caller.js privateAddFive:', a);
  return a + 5;
};

console.log('caller.js');
console.log('privateAddFive(7):', privateAddFive(7));
console.log('mylib.publicAddSix(7):', mylib.publicAddSix(7));
