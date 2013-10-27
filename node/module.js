/** @suppress{duplicate} */
var namespace = namespace || {};
namespace.module = namespace.module || {};
(function() {
namespace.relative = namespace.relative || require('./relative');

/**
@param {number} a
*/
var someLocal = function(a) {
  return 5 + a;
};

namespace.module.exported = function() {
  return someLocal(5) + namespace.relative.relativeFunction(5);
};

exports.exported = namespace.module.exported;
})();
