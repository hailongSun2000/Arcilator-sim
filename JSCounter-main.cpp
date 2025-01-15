#include "JSCounter-model.h"

JSCounterModel::~JSCounterModel() {}

class ComparingJSCounterModel : public JSCounterModel {
public:
  std::vector<std::unique_ptr<JSCounterModel>> models;

  virtual ~ComparingJSCounterModel() {
  }

  void eval() override {
    for (auto &model : models) {
      auto t_before = std::chrono::high_resolution_clock::now();
      model->eval();
      auto t_after = std::chrono::high_resolution_clock::now();
      model->duration += t_after - t_before;
    }
  }

  void set_clock(bool clock) override {
    for (auto &model : models)
      model->set_clock(clock);
  }

  void set_reset(bool reset) override {
    for (auto &model : models)
      model->set_reset(reset);
  }

  Outputs get_outports() override {
    if(models.empty()){
      std::cout<<"============"<<std::endl;
      return {};
    }
    return models[0]->get_outports();
  }
};

int main(int argc, char **argv) {
  ComparingJSCounterModel model;
  model.models.push_back(makeArcilatorModel());

  for (unsigned i = 0; i < 10; i++) {
    if(i == 0 || i == 7){
    model.set_reset(true);
    model.eval();
    }

    model.set_clock(false);
    model.eval();
    model.set_clock(true);
    model.eval();

    if(i == 4) {
      model.set_reset(false);
      model.eval();
    }
      
    std::cout << "The cycle of the for loop: " << i << ",    ";
    std::cout << "counter value is: " << model.get_outports().io_q << std::endl;
  }
  return 0;
}
