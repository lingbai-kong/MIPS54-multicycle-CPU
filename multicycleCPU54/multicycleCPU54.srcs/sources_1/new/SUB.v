`timescale 1ns / 1ns
module SUB(
    input signed [31:0] a,
    input signed [31:0] b,
    output signed [31:0] r,
    output reg overflow
    );
     reg [31:0] t;
    always@(*)
    begin
        t=a-b;
        if(((a[31]==0)&&(b[31]==1)&&(t[31]==1))||((a[31]==1)&&(b[31]==0)&&(t[31]==0)))
            overflow=1;
        else
            overflow=0;
    end
    assign r=t[31:0];
endmodule