NPM_BIN:=$(shell npm bin)
BUILD_DIR=build
BROWSER_TEST_DIR:=$(BUILD_DIR)/browsertest
SOURCE_DIR=src

CLOSURE_COMPILER=/Users/ej/Downloads/compiler.jar
CLOSURE_FLAGS=--language_in ECMASCRIPT5_STRICT --warning_level VERBOSE --compilation_level ADVANCED_OPTIMIZATIONS --externs mocha_externs.js

all: $(BUILD_DIR)/basic_browser/compiled.js $(BUILD_DIR)/node/compiled.js test

test: $(BUILD_DIR)/node/tested.stamp

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

$(BUILD_DIR)/basic_browser/compiled.js: basic_browser/relative.js basic_browser/module.js basic_browser/module_test.js
	mkdir -p $(BUILD_DIR)/basic_browser
	java -jar $(CLOSURE_COMPILER) $(CLOSURE_FLAGS) $^ --js_output_file $@

$(BUILD_DIR)/node/tested.stamp: node/relative.js node/module.js node/module_test.js
	mkdir -p $(BUILD_DIR)/node
	$(NPM_BIN)/mocha --reporter spec node/module_test.js
	touch $@

$(BUILD_DIR)/node/compiled.js: node/relative.js node/module.js node/module_test.js
	mkdir -p $(BUILD_DIR)/node
	java -jar $(CLOSURE_COMPILER) $(CLOSURE_FLAGS) --externs node_externs.js $^ --js_output_file $@
