`include "uvm_macros.svh"
import uvm_pkg::*;          // ✅ needed for run_test()
import p1::*;               // ✅ fix 2 — makes test, env, etc. visible

`include "jk_pkg.sv"        // your package

module top;
  bit clk;

  always #5 clk = ~clk;

  jk_ff in0(clk);           // interface instance

  jk dut(                   // DUT connections via interface signals
    .clk(clk),
    .rst(in0.rst),
    .j(in0.j),
    .k(in0.k),
    .q(in0.q)
  );

  initial begin
    uvm_config_db#(virtual jk_ff)::set(null, "*", "vif", in0);  // ✅ set before run_test
    run_test("test");
  end

endmodule