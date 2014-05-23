NPM_BIN:=$(shell npm bin)
BUILD_DIR=build

CLOSURE_COMPILER=java -jar node_modules/closure-compiler/lib/vendor/compiler.jar
CLOSURE_FLAGS=--language_in ECMASCRIPT5_STRICT --warning_level VERBOSE --compilation_level ADVANCED_OPTIMIZATIONS
KARMA=node_modules/karma/bin/karma

all: test $(BUILD_DIR)/node_and_browser_closure/caller.js

test: $(BUILD_DIR)/browser/mylib_test.js.stamp

clean:
	$(RM) -r $(BUILD_DIR)

$(BUILD_DIR)/browser/mylib_test.js.stamp: browser/browser.conf.js browser/mylib.js browser/mylib_test.js
	mkdir -p $(dir $@)
	$(KARMA) start $< --single-run
	touch $@

$(BUILD_DIR)/node_and_browser_closure/caller.js: node_and_browser_closure/mylib.js node_and_browser_closure/caller.js
	mkdir -p $(dir $@)
	$(CLOSURE_COMPILER) $(CLOSURE_FLAGS) $^ --js_output_file $@ --externs node_and_browser_closure/externs_node.js
