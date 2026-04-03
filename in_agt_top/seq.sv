class seq extends uvm_sequence#(trans);
  `uvm_object_utils(seq)

  function new(string name = "seq");
    super.new(name);
  endfunction

  task body();
    trans req;                             
    repeat(40) begin
      req = trans::type_id::create("req"); 
      start_item(req);
      assert(req.randomize());
      finish_item(req);
    end
  endtask

endclass