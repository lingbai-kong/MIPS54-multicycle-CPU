`timescale 1ns / 1ns
module SLTU(
    input [31:0] a,
    input [31:0] b,
    output [31:0] r,
    output carry
    );
    assign r=(a<b)? 1:0;
    assign carry=(a<b)? 1:0;
endmodule