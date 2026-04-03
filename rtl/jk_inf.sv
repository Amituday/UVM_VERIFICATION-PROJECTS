interface jk_ff (input bit clk);
logic j,k;
logic rst; 
logic q; 
clocking rd_drv @(posedge clk );
  default input #1 output #0; 
   output j; 
   output k ; 
   output rst; 
endclocking 

clocking rd_mon @(posedge clk);
default input #1 output #0; 
 input j; 
 input k ; 
 input rst;
 
endclocking 

clocking wr_mon @(posedge clk);
default input #1 output #0; 
input q; 
endclocking 

modport RD_DRV (clocking rd_drv);
modport RD_MON (clocking rd_mon);
modport WR_MON(clocking wr_mon);

endinterface 
