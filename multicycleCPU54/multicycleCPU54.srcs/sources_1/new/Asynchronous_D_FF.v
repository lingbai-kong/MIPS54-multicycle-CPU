`timescale 1ns / 1ns
module Ansynchronous(
    input CLK,
    input D,
    input ena,
    input RST_n,
    output reg Q1,
    output Q2
);
    assign Q2=~Q1;
    always@(negedge CLK or negedge RST_n)
    begin
    if(!RST_n)
    begin
        Q1<=0;
    end
    else if(ena)
    begin
        Q1<=D;
    end
    end
endmodule

module Ansynchronous1(
    input CLK,
    input D,
    input ena,
    input RST_n,
    output reg Q1,
    output Q2
);
    assign Q2=~Q1;
    always@(negedge CLK or negedge RST_n)
    begin
    if(!RST_n)
    begin
        Q1<=1;
    end
    else if(ena)
    begin
        Q1<=D;
    end
    end
endmodule