package p1;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // ── 1. Transactions (used by everyone) ────────────────────────
  `include "wr_xtn.sv"

  // ── 2. Config objects (used by agents/drivers/monitors) ───────
  `include "int_agent_config.sv"
  `include "out_agent_config.sv"
  `include "env_config.sv"

  // ── 3. Input agent components ─────────────────────────────────
  `include "sequener.sv"
  `include "driver.sv"
  `include "monitor.sv"
  `include "seq.sv"
  `include "agent.sv"
  `include "agt_top.sv"

  // ── 4. Output agent components ────────────────────────────────
  `include "sequencer1.sv"
  `include "driver1.sv"
  `include "monitor1.sv"
  `include "agent1.sv"
  `include "ou_agt_top.sv"

  // ── 5. Environment & scoreboard ───────────────────────────────
  `include "scoreborad.sv"    // fix typo → scoreboard.sv
  `include "env.sv"

  // ── 6. Test (must be last) ────────────────────────────────────
  `include "test.sv"

endpackage