CXXFLAGS = -O3 -Wall -std=c++17 -no-pie
ARCILATOR_UTILS_ROOT ?= $(dir $(shell which arcilator))

BUILD_DIR ?= build
$(shell mkdir -p $(BUILD_DIR))

SOURCE_MODEL ?= JSCounter
BUILD_MODEL ?= $(BUILD_DIR)/JSCounter

 ARCILATOR_ARGS += --observe-wires=0 --observe-ports=0 --observe-named-values=0 --observe-registers=0 --observe-memories=0

#===-------------------------------------------------------------------------===
# Arcilator
#===-------------------------------------------------------------------------===

$(BUILD_MODEL)-arc.o $(BUILD_MODEL).json &: $(SOURCE_MODEL).mlir
	arcilator $< --state-file=$(BUILD_MODEL).json -o $(BUILD_MODEL)-arc.ll $(ARCILATOR_ARGS)
	opt -opaque-pointers -O1 -S $(BUILD_MODEL)-arc.ll | llc -opaque-pointers -O3 --filetype=obj -o $(BUILD_MODEL)-arc.o
	objdump -d $(BUILD_MODEL)-arc.o > $(BUILD_MODEL)-arc.s

$(BUILD_MODEL)-arc.h: $(BUILD_MODEL).json
	python3 $(ARCILATOR_UTILS_ROOT)/arcilator-header-cpp.py $< --view-depth 1 > $@


$(BUILD_MODEL)-model-arc.o: $(SOURCE_MODEL)-model-arc.cpp $(SOURCE_MODEL)-model.h $(BUILD_MODEL)-arc.h
	$(CXX) $(CXXFLAGS) -I$(ARCILATOR_UTILS_ROOT)/ -I$(BUILD_DIR) -c $< -o $@


$(BUILD_MODEL)-main: $(SOURCE_MODEL)-main.cpp $(BUILD_MODEL)-model-arc.o $(BUILD_MODEL)-arc.o
	$(CXX) $(CXXFLAGS) -g $^ -o $@

#===-------------------------------------------------------------------------===
# Convenience
#===-------------------------------------------------------------------------===

run: $(BUILD_MODEL)-main
	$<