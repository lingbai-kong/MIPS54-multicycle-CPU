`timescale 1ns / 1ns
module save(
    input w_ena,
    input [31:0] current,
    input [31:0] storage,
    output [31:0] out
);
    assign out = w_ena? current:storage;
endmodule
module save_flag(
    input w_ena,
    input current,
    input storage,
    output out
);
    assign out = w_ena? current:storage;
endmodule