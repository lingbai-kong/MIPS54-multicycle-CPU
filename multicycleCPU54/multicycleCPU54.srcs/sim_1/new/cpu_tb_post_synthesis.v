`timescale 1ns/1ns
module test_post_synthesis;
    reg         clk;
    reg         reset;
    wire [31:0] inst;
    wire [31:0] pc;
    sccomp_dataflow_with_ipcore uut (clk,reset,inst,pc);
  
    initial clk<=1;
    always #50 clk<=~clk;
        
    initial
    begin
        reset<=1;
        #100;
        reset<=0;
    end
endmodule