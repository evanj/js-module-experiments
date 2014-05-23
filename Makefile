NPM_BIN:=$(shell npm bin)
BUILD_DIR=build

CLOSURE_COMPILER=java -jar node_modules/closure-compiler/lib/vendor/compiler.jar
CLOSURE_FLAGS=--language_in ECMASCRIPT5_STRICT --warning_level VERBOSE --compilation_level ADVANCED_OPTIMIZATIONS

all: $(BUILD_DIR)/simple_both_closure/caller.js

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
