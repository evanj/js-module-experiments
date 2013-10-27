# JavaScript Module Experiments

One of the many sucky things about JavaScript is its lack of support for modules. As a result, a number of people have built different systems which are all sort of incompatible. In trying to get a good JavaScript development setup, I did these experiments about JS modules. Comments welcomed.


## Ideal Goals

* Run unit tests in a browser.
* Run unit tests in a browser from the command line (PhantomJS).
* Import modules in Node.
* Run unit tests from the command line using Node.
* Type checking using the Closure compiler.
* Development flow: save the file, click reload, see your changes.


Sadly, since JavaScript modules are mostly incompatible, to do this we use Google Closure-style modules, and use some hacky scripts to transform them to other forms. I chose to use Google Closure modules since they work with the Closure Compiler type checks, and have a minimum of boilerplate, making them easy to write.

To make this work, unfortunately I need to transform the Javascript files from one form to another.


## Common types of JavaScript modules

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

Example: [`basic_browser`](../../tree/master/basic_browser)

* ✓ `someLocal` is hidden in the anonymous closure.
* ✓ runs directly in a browser.
* ✓ can be type checked.
* ✗ dependencies must be "magically" loaded by some other system.
* ✗ requires a bunch of boilerplate for deeply nested namespaces.


### Node modules
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

Example: [`node`](../../tree/master/node)

* ✓ someLocal is purely local
* ✓ npm fetches dependencies, and browserify can run it in a browser.
* ✓ relatively free of boilerplate
* ✗ can't be type checked: Closure doesn't understand require.


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

* ✓ `someLocal` is a global (use `goog.scope` to hide it)
* ✓ npm fetches dependencies, and browserify can run it in a browser.
* ✓ relatively free of boilerplate
* ✗ can't be type checked: Closure doesn't understand require.


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
