
class ou_agt_config extends uvm_object;
    `uvm_object_utils(ou_agt_config)

     virtual jk_ff vif; 
     
    uvm_active_passive_enum is_active;

    function  new(string name="ou_agt_config");
    super.new(name);

    endfunction
endclass