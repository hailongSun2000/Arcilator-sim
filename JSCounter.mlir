hw.module @JSCounter(in %clk : i1, in %rst_n : i1, out q : i4) {
  %c0_i4 = hw.constant 0 : i4
  %true = hw.constant true
  %0 = seq.to_clock %clk
  %q = seq.firreg %5 clock %0 reset async %1, %c0_i4: i4
  %1 = comb.xor %rst_n, %true : i1
  %2 = comb.extract %q from 0 : (i4) -> i1
  %3 = comb.xor %2, %true : i1
  %4 = comb.extract %q from 1 : (i4) -> i3
  %5 = comb.concat %3, %4 : i1, i3
  hw.output %q : i4
}

// func.func @main() {
//   %zero = arith.constant 0 : i1
//   %one = arith.constant 1 : i1
//   %lb = arith.constant 0 : index
//   %ub = arith.constant 10 : index
//   %step = arith.constant 1 : index
//   %rst_num = arith.constant 4 :index
//   %locked_num = arith.constant 9 : index

//   arc.sim.instantiate @JSCounter as %model {
//     %init_val = arc.sim.get_port %model, "q" : i4, !arc.sim.instance<@JSCounter>
//     arc.sim.emit "counter_initial_value", %init_val : i4

//     scf.for %i = %lb to %ub step %step {
//       arc.sim.set_input %model, "rst_n" = %one : i1, !arc.sim.instance<@JSCounter>
//       arc.sim.step %model : !arc.sim.instance<@JSCounter>

//       %cond = arith.cmpi eq, %i, %rst_num : index
//       scf.if %cond {
//         arc.sim.set_input %model, "rst_n" = %zero : i1, !arc.sim.instance<@JSCounter>
//         arc.sim.step %model : !arc.sim.instance<@JSCounter>
//       }

//       %cond1 = arith.cmpi ne, %i, %locked_num : index
//       scf.if %cond1 {
//         arc.sim.set_input %model, "clk" = %zero : i1, !arc.sim.instance<@JSCounter>
//         arc.sim.step %model : !arc.sim.instance<@JSCounter>
//         arc.sim.set_input %model, "clk" = %one : i1, !arc.sim.instance<@JSCounter>
//         arc.sim.step %model : !arc.sim.instance<@JSCounter>
//       }


//       %counter_val = arc.sim.get_port %model, "q" : i4, !arc.sim.instance<@JSCounter>
//       arc.sim.emit "counter_value", %counter_val : i4
//     }
//   }

//   return
// }