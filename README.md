# JavaScript Module Experiments

This repository contains some simple examples I used to figure out how to get an "ideal" JavaScript module setup that works for us. We wanted:

* Code to work in both NodeJS and the browser without modification.
* Unit tests to run in both, from the command line (we use jasmine, jasmine-node, and Karma).
* Type-checked with the Closure compiler.

This repository shows how to do this.


## Building and running tests

1. Install PhantomJS (using Brew on Mac: `brew install phantomjs`)
2. Install NPM dependencies: `npm install`
3. Compile with Closure, run all tests: `make`
4. Check out the examples. E.g. `open simple_both_closure/example_compiled.html`


## Detailed contents

* `browser`: Web browser module
  - Example: `open browser/example.html`
  - Browser unit test: `open browser/mylib_test.html`
  - Automated unit test: `node_modules/karma/bin/karma start browser/browser.conf.js --single-run`
* `node`: Same example for NodeJS.
  - Example: `node node/caller.js`
  - Unit test: `./node_modules/.bin/jasmine-node --matchAll node/mylib_test.js`
* `node_and_browser`: Module that works with both.
  - Example browser: `open node_and_browser/example.html` node: `node node_and_browser/caller.js`
  - Browser unit test: `open node_and_browser/mylib_test.html`
  - Automated browser test: `node_modules/karma/bin/karma start node_and_browser/node_and_browser.conf.js --single-run`
  - Automated node test: `./node_modules/.bin/jasmine-node --matchAll node_and_browser/mylib_test.js`
* `node_and_browser_closure`: Works with both and Closure compiler.
  - Example browser: `open node_and_browser_closure/example.html` node: `node node_and_browser_closure/caller.js`
  - Compiled: `open node_and_browser_closure/example_compiled.html` node: `node build/node_and_browser_closure/caller.js`
  - Browser unit test: `open node_and_browser_closure/mylib_test.html` or `open node_and_browser_closure/mylib_compiled_test.html`
  - Automated browser test: `node_modules/karma/bin/karma start node_and_browser_closure/uncompiled.conf.js --single-run`
  - Automated node test: `./node_modules/.bin/jasmine-node --matchAll node_and_browser_closure/mylib_test.js`


# Other Projects using Closure Compiler:

* https://github.com/Lindurion/closure-pro-build
* https://github.com/steida/este
* https://github.com/google/module-server
