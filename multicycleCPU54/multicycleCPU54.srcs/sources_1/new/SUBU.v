`timescale 1ns / 1ns
module SUBU(
    input [31:0] a,
    input [31:0] b,
    output[31:0] r,
    output reg carry
    );
    always@(*)
    begin
        if(a<b)
            carry=1;
        else
            carry=0;
    end
    assign r=a-b;
endmodule