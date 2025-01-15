#pragma once

#include <array>
#include <chrono>
#include <iostream>
#include <memory>
#include <string>
#include <vector>

struct Outputs {
  size_t io_q = 0;
};

/// Abstract interface to an Arcilator or Verilator model.
class JSCounterModel {
public:
  static constexpr const char *PORT_NAMES[] = {
#define PORT(name) #name,
#include "ports.def"
  };
  static constexpr size_t NUM_PORTS = sizeof(PORT_NAMES) / sizeof(*PORT_NAMES);
  using Ports = std::array<uint64_t, NUM_PORTS>;

  JSCounterModel() {}
  virtual ~JSCounterModel();

  virtual void eval() {}
  virtual Ports get_ports() { return {}; }
  virtual void set_clock(bool clock) {}
  virtual void set_reset(bool reset) {}
  virtual Outputs get_outports() {return {};}

  const char *name = "unknown";
  std::chrono::high_resolution_clock::duration duration =
      std::chrono::high_resolution_clock::duration::zero();
};

std::unique_ptr<JSCounterModel> makeArcilatorModel();
