`timescale 1ns / 1ns
module ADD(
    input signed [31:0] a,
    input signed [31:0] b,
    output reg signed [31:0] r,
    output reg overflow
    );
//    assign t=a+b;
//    assign overflow=(t[32]==1)? 1:0;
    always@(*)
    begin
       r=a+b;
       if(((a[31]==0)&&(b[31]==0)&&(r[31]==1))||((a[31]==1)&&(b[31]==1)&&(r[31]==0)))
            overflow=1;
       else
            overflow=0;
    end
endmodule