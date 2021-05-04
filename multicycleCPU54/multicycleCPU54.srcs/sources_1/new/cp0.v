`timescale 1ns/1ns
module cp0(
    input clk,
    input rst,
    input mfc0,
    input mtc0,
    input [31:0] pc,
    input [4:0] Rd,
    input [31:0] wdata,
    input exception,
    input eret,
    input [4:0] cause,
    //input intr,
    output [31:0] rdata,
    output [31:0] status,
    //output reg timer_int,
    output reg [31:0] exc_addr
);
    parameter EXC_syscall=5'b01000,EXC_break=5'b01001,EXC_teq=5'b01101;
    parameter reg_status=5'd12,reg_cause=5'd13,reg_epc=5'd14;
    parameter IE=5'd0,IM_syscall=5'd8,IM_break=5'd9,IM_teq=5'd10;
    reg [31:0] regfiles [0:31];
    
    assign rdata = mfc0? regfiles[Rd]:32'hxxxxxxxx;
    assign status = regfiles[reg_status];
    always@(negedge clk or posedge rst)
    begin
        if(rst)
        begin
            regfiles[reg_status]<=32'h00000701;
            regfiles[reg_cause]<=32'h0;
            regfiles[reg_epc]<=32'h0;
            exc_addr<=32'h0;
        end
        else if(mtc0)
        begin
            regfiles[Rd]<=wdata;
        end  
        else if(exception)
        begin
            if(eret)
            begin
                regfiles[reg_status]<=regfiles[reg_status]>>5;
                exc_addr<=regfiles[reg_epc];
            end
            else 
            begin
                case(cause)
                    EXC_syscall:
                    begin
                        if(regfiles[reg_status][IE]&regfiles[reg_status][IM_syscall])
                        begin
                            exc_addr<=32'h00400004;
                            regfiles[reg_status]<=regfiles[reg_status]<<5;
                            regfiles[reg_epc]<=pc;
                            regfiles[reg_cause][6:2]<=EXC_syscall;
                        end
                        else
                        begin
                            exc_addr<=pc+4;
                        end
                    end
                    EXC_break:
                    begin
                        if(regfiles[reg_status][IE]&regfiles[reg_status][IM_break])
                        begin
                            exc_addr<=32'h00400004;
                            regfiles[reg_status]<=regfiles[reg_status]<<5;
                            regfiles[reg_epc]<=pc;
                            regfiles[reg_cause][6:2]<=EXC_break;
                        end
                        else
                        begin
                            exc_addr<=pc+4;
                        end
                    end
                    EXC_teq:
                    begin
                        if(regfiles[reg_status][IE]&regfiles[reg_status][IM_teq])
                        begin
                            exc_addr<=32'h00400004;
                            regfiles[reg_status]<=regfiles[reg_status]<<5;
                            regfiles[reg_epc]<=pc;
                            regfiles[reg_cause][6:2]<=EXC_teq;
                        end
                        else
                        begin
                            exc_addr<=pc+4;
                        end
                    end
                    default:;
                endcase
            end
        end
    end
endmodule