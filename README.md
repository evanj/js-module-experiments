# JavaScript Module Experiments

This repository contains some simple examples I used to figure out how to get an "ideal" JavaScript module setup that works for us. We wanted:

* Code to work in both NodeJS and the browser without modification.
* Unit tests to run in both, from the command line (we use jasmine, jasmine-node, and Karma).
* Type-checked with the Closure compiler.

This repository shows how to do this.


## Building/running tests

1. Install PhantomJS (using Brew on Mac: `brew install phantomjs`)
1. Install NPM dependencies: `npm install`
2. Compile with Closure, run all tests: `make`
3. Check out the examples. E.g. `open simple_both_closure/example_compiled.html`


## Brief contents

* `browser`: Web browser module
    - Example use: `open browser/example.html`
    - Browser unit test: `open browser/mylib_test.html`
    - Automated unit test: ``
* `node`: Same example for NodeJS. Run `node node/caller.js`.
* `node_and_browser`: Module that works with both: `open node_and_browser/example.html` and run `node node_and_browser/caller.js`.
* `node_and_browser_closure`: Module that works with both and can by type-checked using Google's Closure compiler.


# Other Projects using Closure Compiler:

* https://github.com/Lindurion/closure-pro-build
* https://github.com/steida/este
* https://github.com/google/module-server

