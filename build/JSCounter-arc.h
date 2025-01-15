#include "arcilator-runtime.h"
extern "C" {
void JSCounter_eval(void* state);
}

class JSCounterLayout {
public:
  static const char *name;
  static const unsigned numStates;
  static const unsigned numStateBytes;
  static const std::array<Signal, 3> io;
  static const Hierarchy hierarchy;
};

const char *JSCounterLayout::name = "JSCounter";
const unsigned JSCounterLayout::numStates = 3;
const unsigned JSCounterLayout::numStateBytes = 5;
const std::array<Signal, 3> JSCounterLayout::io = {
  Signal{"clk", 0, 1, Signal::Input},
  Signal{"rst_n", 1, 1, Signal::Input},
  Signal{"q", 4, 4, Signal::Output},
};

const Hierarchy JSCounterLayout::hierarchy = Hierarchy{"internal", 0, 0, (Signal[]){}, (Hierarchy[]){}};

class JSCounterView {
public:
  uint8_t &clk;
  uint8_t &rst_n;
  uint8_t &q;
  struct {} internal;
  uint8_t *state;

  JSCounterView(uint8_t *state) :
    clk(*(uint8_t*)(state+0)),
    rst_n(*(uint8_t*)(state+1)),
    q(*(uint8_t*)(state+4)),
    internal({}),
    state(state) {}
};

class JSCounter {
public:
  std::vector<uint8_t> storage;
  JSCounterView view;

  JSCounter() : storage(JSCounterLayout::numStateBytes, 0), view(&storage[0]) {
  }
  void eval() { JSCounter_eval(&storage[0]); }
  ValueChangeDump<JSCounterLayout> vcd(std::basic_ostream<char> &os) {
    ValueChangeDump<JSCounterLayout> vcd(os, &storage[0]);
    vcd.writeHeader();
    vcd.writeDumpvars();
    return vcd;
  }
};

#define JSCOUNTER_PORTS \
  PORT(clk) \
  PORT(rst_n) \
  PORT(q)
