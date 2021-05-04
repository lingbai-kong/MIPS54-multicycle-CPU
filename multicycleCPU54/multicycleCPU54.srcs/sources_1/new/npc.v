`timescale 1ns / 1ns
module npc(
    input [31:0] a,
    input rst,
    output [31:0] r
    );
    assign r = rst ? a : a+4;
endmodule