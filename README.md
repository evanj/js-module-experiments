# JavaScript Module Experiments

One of the many sucky things about JavaScript is its lack of support for modules. As a result, a number of people have built different systems which are all sort of incompatible. While trying to figure out a good JavaScript development setup, I found it helpful to implement a simple module in a few different ways. Comments welcomed.

## Building/running tests

1. Install PhantomJS: `brew install phantomjs`
2. Install NPM dependencies: `npm install`
3. Run the compiler and tests: `make`
* Delete intermediate files: `make clean`

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


### Google Closure modules
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

Example: [`closure`](closure)

* ✓ relatively free of boilerplate.
* ✓ there is a way to determine which files are needed.
* ✓ can be type checked.
* ✗ `someLocal` is global, although you can put everything in a closure to hide it (or use `goog.scope`). However, this may not be needed, since the compiler will tell you if you clobber another variable.
* ✗ doesn't work directly in node.
* ✗ requires Closure library (although see [`closure/fakebase.js`](closure/fakebase.js))
* ✗ not widely used.


### NodeJS module that is Closure Compiler friendly
```javascript
/** @suppress{duplicate} */
var namespace = namespace || {};
namespace.module = namespace.module || {};
(function() {
var global = global || require('global');
namespace.relative = namespace.relative || require('./relative');

var someLocal = function() {
  return 5;
};

namespace.module.myFunction = function() {
  return global.someFunction() + namespace.relative.someFunction() + someLocal();
};

if (typeof exports !== 'undefined') {
  for (var member in namespace.relative) {
    if (namespace.relative.hasOwnProperty(member)) {
      exports[member] = namespace.relative[member];
    }
  }
}
})();

```

To make this work: 

* Use `@suppress{duplicate}` on namespaces to suppress duplicate warnings.
* Import modules using `require` if they don't exist (```var module = module || require('module');```).
* Always use "fully qualified" names (`namespace.module.symbol`).
* Detect the `exports` object using typeof, and export all properties.

* ✓ can be type checked.
* ✓ can be used with Node.
* ✓ can be used in the browser, with or without compilation.
* ✗ no clean way to determine which files are required.
* ✗ some ugly boilerplate is required.


# Other Projects using Closure Compiler:

* https://github.com/Lindurion/closure-pro-build
* https://github.com/steida/este
* https://github.com/google/module-server

