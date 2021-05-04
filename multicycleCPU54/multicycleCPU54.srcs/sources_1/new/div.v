`timescale 1ns/1ps
module div(
    input [31:0]s_dividend, //被除数
    input [31:0]s_divisor,  //除数
    input start,            //启动除法运算
    input clock,            
    input reset,            //高电平有效
    output [31:0]s_q,       //商
    output [31:0]s_r,       //余数
    output busy             //除法器忙标志位
);
    wire [31:0]u_dividend;
    wire [31:0]u_divisor;
    wire [31:0]u_q;
    wire [31:0]u_r;
    complement32 c_dividend(s_dividend[31],s_dividend,u_dividend);
    complement32 c_divisor(s_divisor[31],s_divisor,u_divisor);
    divu divison_unit(u_dividend,u_divisor,start,clock,reset,u_q,u_r,busy);
    wire s_same;
    assign s_same = ~(s_dividend[31] ^ s_divisor[31]);
    complement32 c_q(~s_same,u_q,s_q);
    complement32 c_r(s_dividend[31],u_r,s_r);
endmodule