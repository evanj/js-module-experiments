/** @suppress{duplicate} */
var namespace = namespace || {};
namespace.module = namespace.module || {};
(function(){

/**
@param {number} a
*/
var someLocal = function(a) {
  return 5 + a;
};

namespace.module.exported = function() {
  return someLocal(5) + namespace.relative.relativeFunction(5);
};

})();
