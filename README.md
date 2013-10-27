# Example JavaScript Project Setup

## Goals

* Type checking using the Closure compiler.
* Run unit tests in a browser.
* Run unit tests in a browser from the command line (PhantomJS).
* Import modules in Node.
* Run unit tests from the command line using Node.
* Development flow: save the file, click reload, see your changes.


Sadly, since JavaScript modules are mostly incompatible, to do this we use Google Closure-style modules, and use some hacky scripts to transform them to other forms. I chose to use Google Closure modules since they work with the Closure Compiler type checks, and have a minimum of boilerplate, making them easy to write.

To make this work, unfortunately I need to transform the Javascript files from one form to another.


## Types of JavaScript modules

This is just a subset. 

### Basic browser module
```javascript
/** @suppress{duplicate} */
var namespace = namespace || {};
namespace.module = namespace.module || {};
(function(){

var someLocal = function() {
  return 5;
};

namespace.module.myFunction = function() {
  return namespace.relative.someFunction() + someLocal();
};

})();
```

* ✓ someLocal is hidden in the anonymous closure.
* ✓ runs directly in a browser.
* ✓ can be type checked.
* ✗ dependencies must be "magically" loaded by some other system.
* ✗ requires a bunch of boilerplate for deeply nested namespaces.


### Node/CommonJS modules
```javascript
var global = require('global');
var relative = require('./relative');

var someLocal = function() {
  return 5;
};

exports.myFunction = function() {
  return global.someFunction() + relative.someFunction() + someLocal();
};
```

* Browserify can transform this into a browser friendly version.


### Native Google Closure modules
```javascript
goog.provide('namespace.module');

goog.require('global');
goog.require('namespace.relative');

var someLocal = function() {
  return 5;
};

namespace.module.myFunction = function() {
  return global.someFunction() + namespace.relative.someFunction() + someLocal();
};
```

* someLocal ends up in the global namespace, but the compiler will rename/remove it.


### NodeJS/Browserify module that is Closure Compiler friendly
```javascript
var namespace = {};
namespace.module = {};
var global = require('global');
namespace.relative = require('./relative');

var someLocal = function() {
  return 5;
}

namespace.module.myFunction = function() {
  return global.someFunction() + namespace.relative.someFunction() + someLocal();
};
```
