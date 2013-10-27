/** @suppress{duplicate} */
var namespace = namespace || {};
namespace.relative = namespace.relative || {};
(function() {

/**
@param {string} a
*/
var someLocal = function(a) {
  return 8 * a.length;
};

/**
@param {number} a
*/
namespace.relative.relativeFunction = function(a) {
  return someLocal('hi') + a;
};

})();
