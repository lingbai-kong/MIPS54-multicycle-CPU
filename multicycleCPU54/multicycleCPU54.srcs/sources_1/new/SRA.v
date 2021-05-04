`timescale 1ns / 1ns
module SRA(
    input signed [31:0] a,
    input signed [31:0] b,
    output signed [31:0] r,
    output reg carry
    );
    integer i;
    always@(*) 
    begin
    i=a-1;
    if(i<=31)
        carry=b[i];
    else
        carry=b[31];
    end
    assign r=b>>>a;
endmodule