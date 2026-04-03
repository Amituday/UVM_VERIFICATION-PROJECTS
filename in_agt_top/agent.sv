class agent extends uvm_agent ; 
  
    `uvm_component_utils(agent)
   
     driver d1; 
     monitor m1; 
    sequencer s1; 
     in_agt_config in_con;


    function new(string name="agent" , uvm_component parent);
     super.new(name,parent);
     endfunction


    function void build_phase (uvm_phase phase);
    m1= monitor ::type_id::create("m1",this);
   if(!uvm_config_db #(in_agt_config)::get(this,"","in_agt_config",in_con))
     `uvm_fatal(get_type_name(),"the config faled to get ")
     
     if(in_con.is_active==UVM_ACTIVE)begin 

        d1 =driver ::type_id::create("d1",this);
        s1=sequencer::type_id::create("s1",this);
     end 
super.build_phase(phase);

    endfunction 


function void connect_phase(uvm_phase phase);
 super.connect_phase(phase);
 
 if(in_con.is_active==UVM_ACTIVE)begin 

    d1.seq_item_port.connect(s1.seq_item_export);
 end 
 endfunction 
 

endclass
