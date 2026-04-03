class trans extends uvm_sequence_item;
 `uvm_object_utils(trans)

   rand logic  j, k ;
   rand logic rst;
    logic q; 
    
    constraint c1{ rst dist{0:=40,1:=60};}

   function new(string name = " trans");
    super.new(name);
    endfunction 


endclass 

