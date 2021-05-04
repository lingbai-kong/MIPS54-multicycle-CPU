`timescale 1ns / 1ns
module alu(
    input[31:0] a,
    input[31:0] b,
    input[3:0] aluc,
    output[31:0] r,
    output zero,
    output carry,
    output negative,
    output overflow
    );
    reg [31:0] s;
    reg z,n;
    wire [0:5] c;
    wire [0:1] o;
    wire[31:0] t0;
    wire[31:0] t1;
    wire[31:0] t2;
    wire[31:0] t3;
    wire[31:0] t4;
    wire[31:0] t5;
    wire[31:0] t6;
    wire[31:0] t7;
    wire[31:0] t8;
    wire[31:0] t9;
    wire[31:0] t10;
    wire[31:0] t11;
    wire[31:0] t12;
    wire[31:0] t13;
    ADDU m0 (a,b,t0,c[0]);
    ADD m1 (a,b,t1,o[0]);
    SUBU m2 (a,b,t2,c[1]);
    SUB m3 (a,b,t3,o[1]);
    AND m4 (a,b,t4);
    OR m5 (a,b,t5);
    XOR m6 (a,b,t6);
    NOR m7 (a,b,t7);
    LUI m8 (a,b,t8);
    SLT m9 (a,b,t9);
    SLTU m10 (a,b,t10,c[2]);
    SRA m11 (a,b,t11,c[3]);
    SLLSLR m12 (a,b,t12,c[4]);
    SRL m13 (a,b,t13,c[5]);
    alu_selector m14(t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,aluc,c,o,r,carry,overflow);
    always@(*)
    begin
        s=r;
        if(((s==0)&&(aluc!=4'b101x))||((a==b)&&(aluc==4'b101x)))
            z=1;
        else
            z=0;
    end
    assign zero=z;
    always@(*)
    begin
        s=r;
        if(s[31]==1)
            n=1;
        else
        begin
            if((aluc==4'b1011)&&(s[0]==1))
                n=1;
            else
                n=0;
        end
    end
    assign negative=n;
endmodule