`timescale 1ns / 1ns
module z(
    input PC_CLK,
    input reset,        
    input Z_ENA,   
    input [31:0] D_ALU,
    input zero,
    input carry,
    input negative,
    input overflow,        
    output [31:0] D_Z,
    output D_zero,
    output D_carry,
    output D_negative,
    output D_overflow
);
    wire un[3:0];
    pcreg Save_ALU (PC_CLK,reset,Z_ENA,D_ALU,D_Z);
    Ansynchronous Save_zero (PC_CLK,zero,Z_ENA,~reset,D_zero,un[3]);
    Ansynchronous Save_carry (PC_CLK,carry,Z_ENA,~reset,D_carry,un[2]);
    Ansynchronous Save_negative (PC_CLK,negative,Z_ENA,~reset,D_negative,un[1]);
    Ansynchronous Save_overflow (PC_CLK,overflow,Z_ENA,~reset,D_overflow,un[0]);
endmodule