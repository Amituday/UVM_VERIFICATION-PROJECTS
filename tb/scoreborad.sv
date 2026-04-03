class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  uvm_tlm_analysis_fifo#(trans) fifomh;
  uvm_tlm_analysis_fifo#(trans) fiforh;
  trans in, out;
  logic q;


   // covrage groups 
      
       covergroup c_jk;
       
       option.per_instance=1;

       cp_rst : coverpoint in.rst{
        bins r_0={0};
        bins r_1={1};
       }

       cp_j : coverpoint in.j{
        bins j_0={0};
        bins j_1={1};

       }
       cp_k: coverpoint in.k{
        bins k_0={0};
        bins k_1={1};
        
       }

       cp_q : coverpoint out.q{
        bins q0={0};
        bins q1={1};

       }

       cp_cross : cross cp_rst , cp_j,cp_k;


       endgroup




  function new(string name = "scoreboard", uvm_component parent);  
    super.new(name, parent);
    c_jk=new();
  endfunction

  
    
  function void build_phase(uvm_phase phase);                      
    super.build_phase(phase);
    fifomh = new("fifomh", this);
    fiforh = new("fiforh", this);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin

      fifomh.get(in);
      fiforh.get(out);

  // referance model 
  
      if(out.q == q) begin                                       
        `uvm_info(get_type_name(),
          $sformatf("matched || ref=%b | dut=%b", out.q, q), UVM_LOW)
      end
      else begin
        `uvm_info(get_type_name(),
          $sformatf("mis-matched || ref=%b | dut=%b", out.q, q), UVM_LOW)
      end

      if(in.rst)                                                
        q = 0;
      else begin
        case({in.j, in.k})
          2'b00: q = q;
          2'b01: q = 0;
          2'b10: q = 1;
          2'b11: q = ~q;
        endcase
      end

      c_jk.sample();

    end
  endtask

endclass