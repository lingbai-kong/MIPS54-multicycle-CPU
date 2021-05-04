`timescale 1ns / 1ns
module SLT(
    input signed [31:0] a,
    input signed [31:0] b,
    output signed [31:0] r
    );
    assign r=(a<b)? 1:0;
endmodule