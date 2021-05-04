`timescale 1ns / 1ns
module alu_selector(
    input[31:0] t0,
    input[31:0] t1,
    input[31:0] t2,
    input[31:0] t3,
    input[31:0] t4,
    input[31:0] t5,
    input[31:0] t6,
    input[31:0] t7,
    input[31:0] t8,
    input[31:0] t9,
    input[31:0] t10,
    input[31:0] t11,
    input[31:0] t12,
    input[31:0] t13,
    input[3:0] aluc,
    input[0:5] c,
    input[0:1] o,
    output reg[31:0] r,
    output reg carry,
    output reg overflow
    );
    always@(*)
    begin
    casex(aluc)
        4'b0000:begin r=t0;carry=c[0];end
        4'b0010:begin r=t1;overflow=o[0];end
        4'b0001:begin r=t2;carry=c[1];end
        4'b0011:begin r=t3;overflow=o[1];end
        4'b0100:r=t4;
        4'b0101:r=t5;
        4'b0110:r=t6;
        4'b0111:r=t7;
        4'b100x:r=t8;
        4'b1011:r=t9;
        4'b1010:begin r=t10;carry=c[2];end
        4'b1100:begin r=t11;carry=c[3];end
        4'b111x:begin r=t12;carry=c[4];end
        4'b1101:begin r=t13;carry=c[5];end
        default:$display("Unspecified control signals");
    endcase
    end
endmodule