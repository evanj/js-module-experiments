NPM_BIN:=$(shell npm bin)
BUILD_DIR=build
BROWSER_TEST_DIR:=$(BUILD_DIR)/browsertest
SOURCE_DIR=src

CLOSURE_COMPILER=java -jar $(HOME)/Downloads/compiler.jar
CLOSURE_FLAGS=--language_in ECMASCRIPT5_STRICT --warning_level VERBOSE --compilation_level ADVANCED_OPTIMIZATIONS

all: $(BUILD_DIR)/basic_browser/compiled.js $(BUILD_DIR)/node/compiled.js $(BUILD_DIR)/closure/compiled.js test

test: $(BUILD_DIR)/basic_browser/tested.stamp $(BUILD_DIR)/node/tested.stamp $(BUILD_DIR)/node/compiled-tested.stamp $(BUILD_DIR)/closure/tested.stamp $(BUILD_DIR)/node/browser-tested.stamp

clean:
	$(RM) -r $(BUILD_DIR)

# JS_TESTS:=$(shell find $(SOURCE_DIR) -type f -name '*_test.js')

# test: $(BROWSER_TEST_DIR)/index.html
# 	$(BIN)/mocha --reporter spec $(JS_TESTS)

# $(BROWSER_TEST_DIR)/index.html: ./makemochahtml.py $(JS_TESTS)
# 	./makemochahtml.py $(BROWSER_TEST_DIR)/index.html $(JS_TESTS)

# $(BROWSER_TEST_DIR)/mocha.css:
# 	mkdir -p $(BROWSER_TEST_DIR)
# 	$(BIN)/mocha init $(BROWSER_TEST_DIR)

$(BUILD_DIR)/simple_both_closure/caller.js: simple_both_closure/mylib.js simple_both_closure/caller.js
	mkdir -p $(dir $@)
	$(CLOSURE_COMPILER) $(CLOSURE_FLAGS) $^ --js_output_file $@ --externs simple_both_closure/externs_node.js

$(BUILD_DIR)/basic_browser/compiled.js: basic_browser/relative.js basic_browser/module.js basic_browser/module_test.js
	mkdir -p $(dir $@)
	java -jar $(CLOSURE_COMPILER) $(CLOSURE_FLAGS) $^ --js_output_file $@

$(BUILD_DIR)/basic_browser/tested.stamp: basic_browser/*.js
	mkdir -p $(dir $@)
	$(NPM_BIN)/mocha-phantomjs basic_browser/test.html
	touch $@

$(BUILD_DIR)/closure/tested.stamp: closure/*.js
	mkdir -p $(dir $@)
	$(NPM_BIN)/mocha-phantomjs closure/test.html
	touch $@

$(BUILD_DIR)/node/tested.stamp: node/relative.js node/module.js node/module_test.js
	mkdir -p $(dir $@)
	$(NPM_BIN)/mocha --reporter spec node/module_test.js
	touch $@

$(BUILD_DIR)/node/compiled-tested.stamp: $(BUILD_DIR)/node/compiled.js
	mkdir -p $(dir $@)
	$(NPM_BIN)/mocha --reporter spec $^
	touch $@

$(BUILD_DIR)/node/browser-tested.stamp: node/*.js
	mkdir -p $(dir $@)
	$(NPM_BIN)/mocha-phantomjs node/test.html
	touch $@

$(BUILD_DIR)/node/compiled.js: node/relative.js node/module.js node/module_test.js
	mkdir -p $(dir $@)
	java -jar $(CLOSURE_COMPILER) $(CLOSURE_FLAGS) --externs node_externs.js $^ --js_output_file $@

$(BUILD_DIR)/closure/compiled.js: closure/relative.js closure/module.js closure/module_test.js
	mkdir -p $(dir $@)
	java -jar $(CLOSURE_COMPILER) $(CLOSURE_FLAGS) $^ --js_output_file $@
