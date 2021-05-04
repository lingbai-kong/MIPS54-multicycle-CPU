`timescale 1ns / 1ns
module top(
    input clk_in,
    input reset,
    output [7:0] o_seg,
    output [7:0] o_sel,
    
    input mux_disp,
    input mux_clk
);
    wire CLK_10MHZ;
    wire CLK_10HZ;
    wire CLK_CPU;
    wire [31:0] data;
    wire [31:0] inst;
    wire [31:0] pc;
    wire cs;
    assign cs = 1;
    assign CLK_CPU = mux_clk? CLK_10HZ:CLK_10MHZ;
    assign data = mux_disp? pc:inst;
    divider#(5) Divider1 (clk_in,reset,CLK_10MHZ);
    divider#(5000000) Divider2 (clk_in,reset,CLK_10HZ);
    
    sccomp_dataflow_with_ipcore cpu (CLK_CPU,reset,inst,pc);
    seg7x16 display (clk_in,reset,cs,data,o_seg,o_sel);
endmodule