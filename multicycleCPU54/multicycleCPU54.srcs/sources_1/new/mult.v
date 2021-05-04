`timescale 1ns / 1ns
module mult(
    input reset,
    input [31:0] s_a,
    input [31:0] s_b,
    output [63:0] s_z
);
    wire [31:0] u_a;
    wire [31:0] u_b;
    wire z_sign;
    wire [63:0] u_z;
    
    complement32 c_a(s_a[31],s_a,u_a);
    complement32 c_b(s_b[31],s_b,u_b);
    multu multiplying_unit(reset,u_a,u_b,u_z);
    assign z_sign = s_a[31]^s_b[31];
    complement64 c_z(z_sign,u_z,s_z);  
endmodule