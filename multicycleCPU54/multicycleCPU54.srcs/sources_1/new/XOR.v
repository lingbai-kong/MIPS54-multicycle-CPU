`timescale 1ns / 1ns
module XOR(
    input [31:0] a,
    input [31:0] b,
    output [31:0] r
    );
    assign r=a^b;
endmodule