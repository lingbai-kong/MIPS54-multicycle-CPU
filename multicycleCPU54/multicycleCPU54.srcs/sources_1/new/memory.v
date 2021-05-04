`timescale 1ns / 1ns
module memory(
    input clk,
    input ena,
    input wena,
    input [31:0] addr,
    input [31:0] wdata,
    output [31:0] rdata
);
    reg [31:0] regfiles [0:2047];
    assign rdata = regfiles[addr];
    always@(negedge clk)
    begin
        if(ena&&wena)
        begin
            regfiles[addr] <= wdata;
        end
    end
endmodule