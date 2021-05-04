`timescale 100ps / 1ps
module test;
    reg         clk;
    reg         reset;
    wire [31:0] inst;
    wire [31:0] pc;
    
    reg         ok;
    reg         dok;
    sccomp_dataflow uut (clk,reset,inst,pc);
  
    initial clk<=1;
    always #5 clk<=~clk;
    
    integer file_output;
    initial
    begin
        $readmemh("../../../../test/mips_54_mars_board_switch_student.hex.txt",test.uut.IMEM.regfiles);//输入文件路径
        $readmemh("../../../../test/DMEM.txt",test.uut.DMEM.regfiles);
        file_output=$fopen("../../../../result/result.out");//输出文件路径
        reset<=1;
        #27;
        reset<=0;
        ok<=1;
        dok<=0;
    end

    always@(posedge clk)
    begin
        if(ok&dok&test.uut.finish)
        begin
//            $fdisplay(file_output,"cpr12-status: %h",test.uut.sccpu.CP0.regfiles[12]);
//            $fdisplay(file_output,"cpr13-cause: %h",test.uut.sccpu.CP0.regfiles[13]);
//            $fdisplay(file_output,"cpr14-epc: %h",test.uut.sccpu.CP0.regfiles[14]);
            $fdisplay(file_output,"regfile0: %h",test.uut.sccpu.cpu_ref.array_reg[0]);
            $fdisplay(file_output,"regfile1: %h",test.uut.sccpu.cpu_ref.array_reg[1]);
            $fdisplay(file_output,"regfile2: %h",test.uut.sccpu.cpu_ref.array_reg[2]);
            $fdisplay(file_output,"regfile3: %h",test.uut.sccpu.cpu_ref.array_reg[3]);
            $fdisplay(file_output,"regfile4: %h",test.uut.sccpu.cpu_ref.array_reg[4]);
            $fdisplay(file_output,"regfile5: %h",test.uut.sccpu.cpu_ref.array_reg[5]);
            $fdisplay(file_output,"regfile6: %h",test.uut.sccpu.cpu_ref.array_reg[6]);
            $fdisplay(file_output,"regfile7: %h",test.uut.sccpu.cpu_ref.array_reg[7]);
            $fdisplay(file_output,"regfile8: %h",test.uut.sccpu.cpu_ref.array_reg[8]);
            $fdisplay(file_output,"regfile9: %h",test.uut.sccpu.cpu_ref.array_reg[9]);
            $fdisplay(file_output,"regfile10: %h",test.uut.sccpu.cpu_ref.array_reg[10]);
            $fdisplay(file_output,"regfile11: %h",test.uut.sccpu.cpu_ref.array_reg[11]);
            $fdisplay(file_output,"regfile12: %h",test.uut.sccpu.cpu_ref.array_reg[12]);
            $fdisplay(file_output,"regfile13: %h",test.uut.sccpu.cpu_ref.array_reg[13]);
            $fdisplay(file_output,"regfile14: %h",test.uut.sccpu.cpu_ref.array_reg[14]);
            $fdisplay(file_output,"regfile15: %h",test.uut.sccpu.cpu_ref.array_reg[15]);
            $fdisplay(file_output,"regfile16: %h",test.uut.sccpu.cpu_ref.array_reg[16]);
            $fdisplay(file_output,"regfile17: %h",test.uut.sccpu.cpu_ref.array_reg[17]);
            $fdisplay(file_output,"regfile18: %h",test.uut.sccpu.cpu_ref.array_reg[18]);
            $fdisplay(file_output,"regfile19: %h",test.uut.sccpu.cpu_ref.array_reg[19]);
            $fdisplay(file_output,"regfile20: %h",test.uut.sccpu.cpu_ref.array_reg[20]);
            $fdisplay(file_output,"regfile21: %h",test.uut.sccpu.cpu_ref.array_reg[21]);
            $fdisplay(file_output,"regfile22: %h",test.uut.sccpu.cpu_ref.array_reg[22]);
            $fdisplay(file_output,"regfile23: %h",test.uut.sccpu.cpu_ref.array_reg[23]);
            $fdisplay(file_output,"regfile24: %h",test.uut.sccpu.cpu_ref.array_reg[24]);
            $fdisplay(file_output,"regfile25: %h",test.uut.sccpu.cpu_ref.array_reg[25]);
            $fdisplay(file_output,"regfile26: %h",test.uut.sccpu.cpu_ref.array_reg[26]);
            $fdisplay(file_output,"regfile27: %h",test.uut.sccpu.cpu_ref.array_reg[27]);
            $fdisplay(file_output,"regfile28: %h",test.uut.sccpu.cpu_ref.array_reg[28]);
            $fdisplay(file_output,"regfile29: %h",test.uut.sccpu.cpu_ref.array_reg[29]);
            $fdisplay(file_output,"regfile30: %h",test.uut.sccpu.cpu_ref.array_reg[30]);
            $fdisplay(file_output,"regfile31: %h",test.uut.sccpu.cpu_ref.array_reg[31]);
        end
        if(ok&test.uut.finish)
        begin
            $fdisplay(file_output,"pc: %h",pc-32'h00400000);
            $fdisplay(file_output,"instr: %h",inst);
            dok<=1;
        end
    end
endmodule

module test_with_ipcore;
    reg         clk;
    reg         reset;
    wire [31:0] inst;
    wire [31:0] pc;
    
    reg         ok;
    reg         dok;
    sccomp_dataflow_with_ipcore uut (clk,reset,inst,pc);
  
    initial clk<=1;
    always #5 clk<=~clk;
    
    integer file_output;
    initial
    begin
        //$readmemh("../../../../test/40.41_lhsh.hex.txt",test.uut.IMEM.regfiles);//输入文件路径
        //$readmemh("../../../../test/DMEM.txt",test.uut.DMEM.regfiles);
        file_output=$fopen("../../../../result/result_coe.out");//输出文件路径
        reset<=1;
        #27;
        reset<=0;
        ok<=1;
        dok<=0;
    end

    always@(posedge clk)
    begin
        if(ok&dok&test_with_ipcore.uut.finish)
        begin
//            $fdisplay(file_output,"cpr12-status: %h",test_with_ipcore.uut.sccpu.CP0.regfiles[12]);
//            $fdisplay(file_output,"cpr13-cause: %h",test_with_ipcore.uut.sccpu.CP0.regfiles[13]);
//            $fdisplay(file_output,"cpr14-epc: %h",test_with_ipcore.uut.sccpu.CP0.regfiles[14]);
            $fdisplay(file_output,"regfile0: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[0]);
            $fdisplay(file_output,"regfile1: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[1]);
            $fdisplay(file_output,"regfile2: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[2]);
            $fdisplay(file_output,"regfile3: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[3]);
            $fdisplay(file_output,"regfile4: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[4]);
            $fdisplay(file_output,"regfile5: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[5]);
            $fdisplay(file_output,"regfile6: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[6]);
            $fdisplay(file_output,"regfile7: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[7]);
            $fdisplay(file_output,"regfile8: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[8]);
            $fdisplay(file_output,"regfile9: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[9]);
            $fdisplay(file_output,"regfile10: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[10]);
            $fdisplay(file_output,"regfile11: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[11]);
            $fdisplay(file_output,"regfile12: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[12]);
            $fdisplay(file_output,"regfile13: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[13]);
            $fdisplay(file_output,"regfile14: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[14]);
            $fdisplay(file_output,"regfile15: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[15]);
            $fdisplay(file_output,"regfile16: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[16]);
            $fdisplay(file_output,"regfile17: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[17]);
            $fdisplay(file_output,"regfile18: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[18]);
            $fdisplay(file_output,"regfile19: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[19]);
            $fdisplay(file_output,"regfile20: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[20]);
            $fdisplay(file_output,"regfile21: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[21]);
            $fdisplay(file_output,"regfile22: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[22]);
            $fdisplay(file_output,"regfile23: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[23]);
            $fdisplay(file_output,"regfile24: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[24]);
            $fdisplay(file_output,"regfile25: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[25]);
            $fdisplay(file_output,"regfile26: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[26]);
            $fdisplay(file_output,"regfile27: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[27]);
            $fdisplay(file_output,"regfile28: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[28]);
            $fdisplay(file_output,"regfile29: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[29]);
            $fdisplay(file_output,"regfile30: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[30]);
            $fdisplay(file_output,"regfile31: %h",test_with_ipcore.uut.sccpu.cpu_ref.array_reg[31]);
        end
        if(ok&test_with_ipcore.uut.finish)
        begin
            $fdisplay(file_output,"pc: %h",pc);
            $fdisplay(file_output,"instr: %h",inst);
            dok<=1;
        end
    end
endmodule