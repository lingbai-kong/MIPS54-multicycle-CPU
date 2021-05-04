`timescale 1ns / 1ns
module mux_pc(
    input [31:0] npc,
    input [31:0] rs,
    input [31:0] alu,
    input [31:0] II,
    input [31:0] epc,
    input [7:0] mux,
    output reg [31:0] out
);
    parameter mux_pc_NPC=8'd0,mux_pc_Rs=8'd1,mux_pc_ALU=8'd2,mux_pc_II=8'd3,mux_pc_EPC=8'd4;
    always@(*)
    begin
        case(mux)
        mux_pc_NPC:out<=npc;
        mux_pc_Rs:out<=rs;
        mux_pc_ALU:out<=alu;
        mux_pc_II:out<=II;
        mux_pc_EPC:out<=epc;
        endcase
    end
endmodule

module mux_rf(
    input [31:0] alu,
    input [31:0] ext1,
    input [31:0] dm_data,
    input [31:0] pc,
    input [31:0] clz,
    input [31:0] hi,
    input [31:0] lo,
    input [31:0] cbw,
    input [31:0] chw,
    input [31:0] cpr,
    input [7:0] mux,
    output reg [31:0] out
);
    parameter mux_rf_ALU=8'd0,mux_rf_EXT1=8'd1,mux_rf_DM_Data=8'd2,mux_rf_PC=8'd3,mux_rf_CLZ=8'd4,mux_rf_HI=8'd5,mux_rf_LO=8'd6,mux_rf_CBW=8'd7,mux_rf_CHW=8'd8,mux_rf_CPR=8'd9;
    always@(*)
    begin
        case(mux)
        mux_rf_ALU:out<=alu;
        mux_rf_EXT1:out<=ext1;
        mux_rf_DM_Data:out<=dm_data;
        mux_rf_PC:out<=pc;
        mux_rf_CLZ:out<=clz;
        mux_rf_HI:out<=hi;
        mux_rf_LO:out<=lo;
        mux_rf_CBW:out<=cbw;
        mux_rf_CHW:out<=chw;
        mux_rf_CPR:out<=cpr;
        endcase
    end
endmodule

module mux_alu(
    input [31:0] rs,
    input [31:0] rt,
    input [31:0] ext5,
    input [31:0] ext16,
    input [31:0] ext18,
    input [31:0] pc,
    input [7:0] mux,
    output reg [31:0] a,
    output reg [31:0] b
);
    parameter mux_alu_Rs_Rt=8'd0,mux_alu_ext5_Rt=8'd1,mux_alu_Rs_EXT16=8'd2,mux_alu_x_EXT16=8'd3,mux_alu_Rs_0=8'd4,mux_alu_EXT18_PC=8'd5;
    always@(*)
    begin
        case(mux)
        mux_alu_Rs_Rt:begin a<=rs;b<=rt;end
        mux_alu_ext5_Rt:begin a<=ext5;b<=rt;end
        mux_alu_Rs_EXT16:begin a<=rs;b<=ext16;end
        mux_alu_x_EXT16:begin a<=32'hxxxxxxxx;b<=ext16;end
        mux_alu_Rs_0:begin a<=rs;b<=32'b0;end
        mux_alu_EXT18_PC:begin a<=ext18;b<=pc;end
        endcase
    end
endmodule

module mux_hi(
    input [31:0] rs,
    input [31:0] div,
    input [31:0] divu,
    input [31:0] mult,
    input [31:0] multu,
    input [7:0] mux,
    output reg [31:0] out
);
    parameter mux_hi_Rs=8'd0,mux_hi_DIV=8'd1,mux_hi_DIVU=8'd2,mux_hi_MULT=8'd3,mux_hi_MULTU=8'd4;
    always@(*)
    begin
        case(mux)
        mux_hi_Rs:out<=rs;
        mux_hi_DIV:out<=div;
        mux_hi_DIVU:out<=divu;
        mux_hi_MULT:out<=mult;
        mux_hi_MULTU:out<=multu;
        endcase
    end
endmodule

module mux_lo(
    input [31:0] rs,
    input [31:0] div,
    input [31:0] divu,
    input [31:0] mult,
    input [31:0] multu,
    input [7:0] mux,
    output reg [31:0] out
);
    parameter mux_lo_Rs=8'd0,mux_lo_DIV=8'd1,mux_lo_DIVU=8'd2,mux_lo_MULT=8'd3,mux_lo_MULTU=8'd4;
    always@(*)
    begin
        case(mux)
        mux_lo_Rs:out<=rs;
        mux_lo_DIV:out<=div;
        mux_lo_DIVU:out<=divu;
        mux_lo_MULT:out<=mult;
        mux_lo_MULTU:out<=multu;
        endcase
    end
endmodule

module mux2_32(
    input [31:0] a,
    input [31:0] b,
    input choose,
    output reg [31:0] c
    );
    always @(*)
    begin
    case(choose)
        0:c <= a;
        1:c <= b;
        default:c <= 32'bz;
   endcase
   end
endmodule