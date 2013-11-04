goog.provide('namespace.module');

goog.require('namespace.relative');

/**
@param {number} a
*/
var someLocal = function(a) {
  return 5 + a;
};

namespace.module.exported = function() {
  return someLocal(5) + namespace.relative.relativeFunction(5);
};

// window['exported'] = namespace.module.exported;
