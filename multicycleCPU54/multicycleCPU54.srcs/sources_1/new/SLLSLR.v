`timescale 1ns / 1ns
module SLLSLR(
    input [31:0] a,
    input [31:0] b,
    output [31:0] r,
    output reg carry
    );
    integer i;
    always@(*) 
    begin
    i=a-1;
    if(i<=31)
        carry=b[31-i];
    else
        carry=0;
    end
    assign r=b<<a;
endmodule