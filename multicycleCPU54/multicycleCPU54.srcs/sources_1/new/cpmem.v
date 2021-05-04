`timescale 1ns / 1ns
module cpmem(
    input [1:0] data_type,
    input [31:0] exact_addr,
    output [31:0] appr_addr,
    output reg [31:0] rdata32,
    output reg [15:0] rdata16,
    output reg [7:0] rdata8,
    input [31:0] rdata,
    input [31:0] wdata32,
    input [15:0] wdata16,
    input [7:0] wdata8,
    output reg [31:0] wdata
);
    wire [1:0] offset;
    assign offset = exact_addr[1:0];
    assign appr_addr = exact_addr & 32'hfffffffc;
    parameter Wdata=2'b00,Hdata=2'b01,Bdata=2'b10;
    always@(*)
    begin
        case(data_type)
        Wdata:begin
            rdata32<=rdata;
            wdata<=wdata32;
        end
        Hdata:begin
            case(offset)
            2'b00:begin
                rdata16<=rdata[31:16];
                wdata<={wdata16,rdata[15:0]};
            end
            2'b10:begin
                rdata16<=rdata[15:0];
                wdata<={rdata[31:16],wdata16};
            end
            endcase
        end
        Bdata:begin
            case(offset)
            2'b00:begin
                rdata8<=rdata[31:24];
                wdata<={wdata8,rdata[23:0]};
            end
            2'b01:begin
                rdata8<=rdata[23:16];
                wdata<={rdata[31:24],wdata8,rdata[15:0]};
            end
            2'b10:begin
                rdata8<=rdata[15:8];
                wdata<={rdata[31:16],wdata8,rdata[7:0]};
            end
            2'b11:begin
                rdata8<=rdata[7:0];
                wdata<={rdata[31:8],wdata8};
            end
            endcase
        end
        endcase
    end
endmodule