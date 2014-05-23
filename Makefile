BUILD_DIR=build

CLOSURE_COMPILER=java -jar node_modules/closure-compiler/lib/vendor/compiler.jar
CLOSURE_FLAGS=--language_in ECMASCRIPT5_STRICT --warning_level VERBOSE --compilation_level ADVANCED_OPTIMIZATIONS
KARMA=node_modules/karma/bin/karma
JASMINE_NODE=node_modules/.bin/jasmine-node
JASMINE_FLAGS=--captureExceptions --matchAll

all: $(BUILD_DIR)/node_and_browser_closure/caller.js $(BUILD_DIR)/node_and_browser_closure/mylib_test.js test

test: $(BUILD_DIR)/browser/mylib_test.js.stamp $(BUILD_DIR)/node/mylib_test.js.stamp $(BUILD_DIR)/node_and_browser/mylib_test.js.browserstamp $(BUILD_DIR)/node_and_browser/mylib_test.js.nodestamp $(BUILD_DIR)/node_and_browser_closure/mylib_test.js.uncompiled.browserstamp $(BUILD_DIR)/node_and_browser_closure/mylib_test.js.uncompiled.nodestamp $(BUILD_DIR)/node_and_browser_closure/mylib_test.js.compiled.browserstamp $(BUILD_DIR)/node_and_browser_closure/mylib_test.js.compiled.nodestamp

clean:
	$(RM) -r $(BUILD_DIR)

# Browser test using Karma and PhantomJS
$(BUILD_DIR)/browser/mylib_test.js.stamp: browser/browser.conf.js browser/mylib.js browser/mylib_test.js
	mkdir -p $(dir $@)
	$(KARMA) start $< --single-run
	touch $@

# Node test using jasmine-node
$(BUILD_DIR)/node/mylib_test.js.stamp: node/mylib_test.js node/mylib.js
	mkdir -p $(dir $@)
	$(JASMINE_NODE) $(JASMINE_FLAGS) $<
	touch $@

# node_and_browser tested with both
$(BUILD_DIR)/node_and_browser/mylib_test.js.browserstamp: node_and_browser/node_and_browser.conf.js node_and_browser/mylib.js node_and_browser/mylib_test.js
	mkdir -p $(dir $@)
	$(KARMA) start $< --single-run
	touch $@
$(BUILD_DIR)/node_and_browser/mylib_test.js.nodestamp: node_and_browser/mylib_test.js node_and_browser/mylib.js
	mkdir -p $(dir $@)
	$(JASMINE_NODE) $(JASMINE_FLAGS) $<
	touch $@

# Closure compiler type checks
$(BUILD_DIR)/node_and_browser_closure/caller.js: node_and_browser_closure/mylib.js node_and_browser_closure/caller.js
	mkdir -p $(dir $@)
	$(CLOSURE_COMPILER) $(CLOSURE_FLAGS) $^ --js_output_file $@ --externs node_and_browser_closure/externs_node.js
$(BUILD_DIR)/node_and_browser_closure/mylib_test.js: node_and_browser_closure/mylib.js node_and_browser_closure/mylib_test.js
	mkdir -p $(dir $@)
	$(CLOSURE_COMPILER) $(CLOSURE_FLAGS) $^ --js_output_file $@ --externs node_and_browser_closure/externs_node.js --externs node_and_browser_closure/externs_jasmine.js

# Run tests on the uncompiled source
$(BUILD_DIR)/node_and_browser_closure/mylib_test.js.uncompiled.browserstamp: node_and_browser_closure/uncompiled.conf.js node_and_browser_closure/mylib.js node_and_browser_closure/mylib_test.js
	mkdir -p $(dir $@)
	$(KARMA) start $< --single-run
	touch $@
$(BUILD_DIR)/node_and_browser_closure/mylib_test.js.uncompiled.nodestamp: node_and_browser_closure/mylib_test.js node_and_browser_closure/mylib.js
	mkdir -p $(dir $@)
	$(JASMINE_NODE) $(JASMINE_FLAGS) $<
	touch $@

# Run tests on the compiled output
$(BUILD_DIR)/node_and_browser_closure/mylib_test.js.compiled.browserstamp: node_and_browser_closure/compiled.conf.js build/node_and_browser_closure/mylib_test.js
	mkdir -p $(dir $@)
	$(KARMA) start $< --single-run
	touch $@
$(BUILD_DIR)/node_and_browser_closure/mylib_test.js.compiled.nodestamp:  build/node_and_browser_closure/mylib_test.js
	mkdir -p $(dir $@)
	$(JASMINE_NODE) $(JASMINE_FLAGS) $<
	touch $@
