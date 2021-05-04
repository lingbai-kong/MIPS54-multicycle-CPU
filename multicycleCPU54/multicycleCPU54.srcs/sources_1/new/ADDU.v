`timescale 1ns / 1ns
module ADDU(
    input [31:0] a,
    input [31:0] b,
    output[31:0] r,
    output reg carry
    );
    reg [32:0] t;
    always@(*)
    begin
        t=a+b;
        if(t[32]==1)
            carry=1;
        else
            carry=0;
    end
    assign r=t[31:0];
endmodule