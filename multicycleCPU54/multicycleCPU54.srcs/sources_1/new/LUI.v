`timescale 1ns / 1ns
module LUI(
    input [31:0] a,
    input [31:0] b,
    output [31:0] r
    );
    assign r={b[15:0],16'b0};
endmodule