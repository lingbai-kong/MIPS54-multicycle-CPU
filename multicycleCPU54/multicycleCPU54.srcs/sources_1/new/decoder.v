`timescale 1ns / 1ns
module decoder(
    input [31:0] inst,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [4:0] shamt,
    output [15:0] immediate,
    output [25:0] address,
    output reg [5:0] out
    );
    assign rs = inst[25:21];
    assign rt = inst[20:16];
    assign rd = inst[15:11];
    assign shamt = inst[10:6];
    assign immediate = inst[15:0];
    assign address = inst[25:0];
    assign base = inst[25:21];
    assign offset = inst[15:0];
    
    parameter ADD=6'd1,ADDU=6'd2,SUB=6'd3,SUBU=6'd4,AND=6'd5,OR=6'd6,XOR=6'd7,NOR=6'd8,SLT=6'd9,SLTU=6'd10,SLL=6'd11,SRL=6'd12,SRA=6'd13,SLLV=6'd14,SRLV=6'd15,SRAV=6'd16,JR=6'd17,
    ADDI=6'd18,ADDIU=6'd19,ANDI=6'd20,ORI=6'd21,XORI=6'd22,LW=6'd23,SW=6'd24,BEQ=6'd25,BNE=6'd26,SLTI=6'd27,SLTIU=6'd28,LUI=6'd29,J=6'd30,JAL=6'd31,
    DIV=6'd32,DIVU=6'd33,MULT=6'd34,MULTU=6'd35,BGEZ=6'd36,JALR=6'd37,LBU=6'd38,LHU=6'd39,LB=6'd40,LH=6'd41,SB=6'd42,SH=6'd43,BREAK=6'd44,SYSCALL=6'd45,ERET=6'd46,MFHI=6'd47,MFLO=6'd48,
    MTHI=6'd49,MTLO=6'd50,MFC0=6'd51,MTC0=6'd52,CLZ=6'd53,TEQ=6'd54;
    
    wire [11:0] tmp;
    assign tmp = {inst[31:26],inst[5:0]};
    always @ (*)
    begin
        casez(tmp)
            12'b000000100000 :out <= ADD;
            12'b000000100001 :out <= ADDU;
            12'b000000100010 :out <= SUB;
            12'b000000100011 :out <= SUBU;
            12'b000000100100 :out <= AND;
            12'b000000100101 :out <= OR;
            12'b000000100110 :out <= XOR;
            12'b000000100111 :out <= NOR;
            12'b000000101010 :out <= SLT;
            12'b000000101011 :out <= SLTU;
            12'b000000000000 :out <= SLL;
            12'b000000000010 :out <= SRL;
            12'b000000000011 :out <= SRA;
            12'b000000000100 :out <= SLLV;
            12'b000000000110 :out <= SRLV;
            12'b000000000111 :out <= SRAV;
            12'b000000001000 :out <= JR;
            12'b001000?????? :out <= ADDI;
            12'b001001?????? :out <= ADDIU;
            12'b001100?????? :out <= ANDI;
            12'b001101?????? :out <= ORI;
            12'b001110?????? :out <= XORI;
            12'b100011?????? :out <= LW;
            12'b101011?????? :out <= SW;
            12'b000100?????? :out <= BEQ;
            12'b000101?????? :out <= BNE;
            12'b001010?????? :out <= SLTI;
            12'b001011?????? :out <= SLTIU;
            12'b001111?????? :out <= LUI;
            12'b000010?????? :out <= J;
            12'b000011?????? :out <= JAL;
            //23extend
            12'b000000011010 :out <= DIV;
            12'b000000011011 :out <= DIVU;
            12'b000000011000 :out <= MULT;
            12'b000000011001 :out <= MULTU;
            12'b000001?????? :out <= BGEZ;
            12'b000000001001 :out <= JALR;
            12'b100100?????? :out <= LBU;
            12'b100101?????? :out <= LHU;
            12'b100000?????? :out <= LB;
            12'b100001?????? :out <= LH;
            12'b101000?????? :out <= SB;
            12'b101001?????? :out <= SH;
            12'b000000001101 :out <= BREAK;
            12'b000000001100 :out <= SYSCALL;
            12'b010000011000 :out <= ERET;
            12'b000000010000 :out <= MFHI;
            12'b000000010010 :out <= MFLO;
            12'b000000010001 :out <= MTHI;
            12'b000000010011 :out <= MTLO;
            12'b010000000000 :begin
                if(rs==5'b00000) out <= MFC0;
                else if(rs==5'b00100) out <= MTC0;
            end
            12'b011100100000 :out <= CLZ;
            12'b000000110100 :out <= TEQ;
            default:          out <= 32'bx;
        endcase
    end 
endmodule