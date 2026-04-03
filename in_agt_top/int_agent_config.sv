
class in_agt_config extends uvm_object;
    `uvm_object_utils(in_agt_config)

     virtual jk_ff vif; 

    uvm_active_passive_enum is_active;

    function  new(string name="in_agt_config");
    super.new(name);

    endfunction
endclass