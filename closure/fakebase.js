var goog = goog || {};

goog.globalContext_ = this;
goog.provide = function(argument) {
  var parts = argument.split('.');

  var context = goog.globalContext_;
  for (var i = 0; i < parts.length; i++) {
    var part = parts[i];
    var next = context[part];
    if (!next) {
      next = {};
      context[part] = next;
    }
    context = next;
  }
};

goog.require = function(argument) {
  var parts = argument.split('.');

  var context = goog.globalContext_;
  for (var i = 0; i < parts.length; i++) {
    console.log(context, i, parts[i]);
    var next = context[parts[i]];
    if (!next) {
      console.warn('warning: ' + argument + ' not defined; incorrect build?');
      break;
    }
    context = next;
  }
};

goog.scope = function(callable) {
  callable();
};
