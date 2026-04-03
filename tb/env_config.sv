class env_config extends uvm_object ; 

   `uvm_object_utils(env_config)
    virtual jk_ff vif; 
    in_agt_config i1; 
    ou_agt_config oo1;
    uvm_active_passive_enum is_active; 


    function new(string name="env_config");
    super.new(name);
    endfunction 

endclass 



