#include "JSCounter-arc.h"
#include "JSCounter-model.h"
#include <fstream>
#include <optional>

namespace {
class ArcilatorJSCounterModel : public JSCounterModel {
  JSCounter model;

public:
  ArcilatorJSCounterModel() { name = "arcs"; }

  void eval() override { JSCounter_eval(&model.storage[0]); }

  Ports get_ports() override {
    return {
#define PORT(name) model.view.name,
#include "ports.def"
    };
  }

  void set_reset(bool reset) override {
    model.view.rst_n = reset;
  }

  void set_clock(bool clock) override {
    model.view.clk = clock;
  }

  Outputs get_outports() override{
    Outputs out;
    out.io_q = model.view.q;
    return out;
  }
};
} // namespace

std::unique_ptr<JSCounterModel> makeArcilatorModel() {
  return std::make_unique<ArcilatorJSCounterModel>();
}