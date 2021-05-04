`timescale 1ns / 1ns
module sccomp_dataflow(
    input clk_in,
    input reset,
    output [31:0] inst,
    output [31:0] pc
);
    wire IM_ena;
    wire IM_w;
    wire DM_ena;
    wire DM_w;
    wire [31:0] addr;
    wire [31:0] rdata;
    wire [31:0] wdata;
    wire finish;
    wire [31:0] IM_wdata;
    assign IM_wdata = 32'b0;
    cpu sccpu (clk_in,reset,IM_ena,IM_w,pc,inst,DM_ena,DM_w,addr,rdata,wdata,finish);
    memory IMEM (clk_in,IM_ena,IM_w,(pc-32'h00400000)/4,IM_wdata,inst);
    //IMEM IMEM(pc[12:2],inst);
    memory DMEM (clk_in,DM_ena,DM_w,(addr-32'h10010000)/4,wdata,rdata);
    //DMEM DMEM(addr[12:2],wdata,clk_in,DM_w,rdata);
endmodule
module sccomp_dataflow_with_ipcore(
    input clk_in,
    input reset,
    output [31:0] inst,
    output [31:0] pc
);
    wire IM_ena;
    wire IM_w;
    wire DM_ena;
    wire DM_w;
    wire [31:0] addr;
    wire [31:0] rdata;
    wire [31:0] wdata;
    wire finish;
    wire [31:0] IM_wdata;
    assign IM_wdata = 32'b0;
    cpu sccpu (clk_in,reset,IM_ena,IM_w,pc,inst,DM_ena,DM_w,addr,rdata,wdata,finish);
    //memory IMEM (clk_in,IM_ena,IM_w,(pc-32'h00400000)/4,IM_wdata,inst);
    IMEM IMEM(pc[12:2],inst);
    //memory DMEM (clk_in,DM_ena,DM_w,(addr-32'h10010000)/4,wdata,rdata);
    DMEM DMEM(addr[12:2],wdata,clk_in,DM_w,rdata);
endmodule