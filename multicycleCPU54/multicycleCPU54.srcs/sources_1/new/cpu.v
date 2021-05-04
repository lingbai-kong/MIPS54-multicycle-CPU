`timescale 1ns / 1ns
module cpu(
    input         clk,                  //����ʱ���ź�
    input         rst,                  //��λ�ź�
    //----------------------------------//ָ��洢���ӿ�
    output        IM_ena,               //ָ��洢��ʹ���ź�
    output        IM_w,                 //ָ��洢����д�źţ��ߵ�ƽΪд���͵�ƽΪ��
    output [31:0] pc,                   //ָ��洢����ַ��
    input  [31:0] inst,                 //����ָ�������
    //----------------------------------//���ݴ洢���ӿ�    
    output        DM_ena,               //���ݴ洢��ʹ���ź�
    output        DM_w,                 //���ݴ洢����д�źţ��ߵ�ƽΪд���͵�ƽΪ��
    output [31:0] addr,                 //���ݴ洢����ַ��
    input  [31:0] rdata,                //���ݴ洢����������
    output [31:0] wdata,                //���ݴ洢��д������   
    output        finish                //��������ź�
    );  
    //----------------------------------//�����ź�
    wire PC_ena;                       //���������ʹ���ź�
    wire Z_ena;                        //zʹ���ź�
    wire HI_ena;
    wire LO_ena;
    wire RF_w;                         //�Ĵ����ļ���д�źţ��ߵ�ƽΪд�͵�ƽΪ��
    wire [4:0] RF_waddr;
    wire [3:0] aluc;                   //�����߼���Ԫ�����ź�                    
    wire DIV_start;
    wire DIVU_start;
    wire EXT1_n_c;
    wire EXT16_sign;                   //16λ��չ����λ�����źţ�1Ϊ�з��ţ�0Ϊ�޷���   
    wire CBW_sign;
    wire CHW_sign;
    wire [7:0] M_PC;
    wire [7:0] M_RF;   
    wire [7:0] M_ALU;
    wire [7:0] M_HI;
    wire [7:0] M_LO;
    wire mfc0;
    wire mtc0;
    wire exception;
    wire eret;
    wire [4:0] cause;
    //----------------------------------//��������־λ
    wire zero;                         //ALU���־λ
    wire carry;                        //ALU��λ��־λ
    wire negative;                     //ALU����־λ
    wire overflow;                     //ALU�����־λ
    wire D_zero;        
    wire D_carry;    
    wire D_negative; 
    wire D_overflow;
    wire Now_zero;        
    wire Now_carry;    
    wire Now_negative; 
    wire Now_overflow;
    wire DIV_busy;
    wire DIVU_busy;
    //----------------------------------//ָ��������
    wire [31:0] D_inst;
    wire [31:0] Now_inst;
    wire [5:0] INST;                   //�����ָ���
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] shamt;
    wire [15:0] immediate;
    wire [25:0] address;
    //----------------------------------//����ź�
    wire [31:0] D_ALU;                 //ALU���
    wire [31:0] D_Z;
    wire [31:0] Now_ALU;
    wire [31:0] D_PC;                  //������������
    wire [31:0] D_Rs;                  //�Ĵ����ļ�Rs�����
    wire [31:0] D_Rt;                  //�Ĵ����ļ�Rt�����
    wire [31:0] D_HI;
    wire [31:0] D_LO;
    wire [31:0] D_DIV_q;
    wire [31:0] D_DIV_r;
    wire [31:0] D_DIVU_q;
    wire [31:0] D_DIVU_r;
    wire [63:0] D_MULT;
    wire [63:0] D_MULTU;
    wire [31:0] D_Mux_PC;
    wire [31:0] D_Mux_RF;
    wire [31:0] D_Mux_ALU_a;
    wire [31:0] D_Mux_ALU_b;
    wire [31:0] D_Mux_HI;
    wire [31:0] D_Mux_LO;
    wire [31:0] D_EXT1;                //1λ��չ�����
    wire [31:0] D_EXT1_n;              //1λ��չ���������չNegative�źţ�
    wire [31:0] D_EXT1_c;              //1λ��չ���������չCarry�źţ�
    wire [31:0] D_EXT5;                //5λ��չ�����
    wire [31:0] D_EXT16;               //16λ��չ�����
    wire [31:0] D_EXT18;               //18λ��չ�����
    wire [31:0] D_NPC;                 //�����������4�ۼ������
    wire [31:0] D_II;                  //II���
    wire [31:0] D_CLZ;
    wire [31:0] D_CBW;
    wire [31:0] D_CHW;
    wire [31:0] status;
    wire [31:0] exc_addr;
    wire [31:0] CP0_rdata;
    //----------------------------------//�洢��Э������CPMEM��·
    wire [31:0] exact_addr;
    wire [1:0] data_type;
    wire [31:0] rdata32;
    wire [15:0] rdata16;
    wire [7:0] rdata8;
    wire [31:0] wdata32;
    wire [15:0] wdata16;
    wire [7:0] wdata8;
    //----------------------------------//�ⲿͨ·����
    assign pc = D_PC;
    assign exact_addr = Now_ALU;
    assign wdata32 = D_Rt;
    assign wdata16 = D_Rt[15:0];
    assign wdata8 = D_Rt[7:0];
    //----------------------------------//���������������ź�
    cu          CU          (clk,           rst,            Now_zero,       Now_negative,   DIV_start,      DIVU_start,     DIV_busy,       DIVU_busy,  
                            rs,             rt,             rd,             shamt,          immediate,      address,        INST,            
                            PC_ena,         IM_ena,         IM_w,           IR_ENA,
                            DM_ena,         DM_w,           data_type,
                            RF_w,           RF_waddr,       Z_ena,          aluc,
                            HI_ena,         LO_ena,    
                            M_PC,           M_RF,           M_ALU,          M_HI,           M_LO,           EXT16_sign,     EXT1_n_c,       CBW_sign,       CHW_sign,
                            mfc0,           mtc0,           exception,      eret,           cause,
                            finish);
    //----------------------------------//ָ������
    decoder     ID          (Now_inst,      rs,             rt,             rd,             shamt,          immediate,      address,        INST);
    //----------------------------------//���������
    pcreg_i     PC          (clk,           rst,            PC_ena,         D_Mux_PC,       D_PC);
    pcreg       IR          (clk,           rst,            IR_ENA,         inst,           D_inst);
    save        INST_save   (IR_ENA,        inst,           D_inst,         Now_inst);
    //----------------------------------//�����߼���ԪALU
    alu         ALU         (D_Mux_ALU_a,   D_Mux_ALU_b,    aluc,           D_ALU,          zero,           carry,          negative,       overflow);
    z           Z           (clk,           rst,            Z_ena,          D_ALU,          zero,           carry,          negative,       overflow,
                                                                            D_Z,            D_zero,         D_carry,        D_negative,     D_overflow);
    save        ALU_save    (Z_ena,         D_ALU,          D_Z,            Now_ALU);
    save_flag   zero_save   (Z_ena,         zero,           D_zero,         Now_zero);
    save_flag   carry_save  (Z_ena,         carry,          D_carry,        Now_carry);
    save_flag   negative_save(Z_ena,        negative,       D_negative,     Now_negative);
    save_flag   overflow_save(Z_ena,        overflow,       D_overflow,     Now_overflow);
    //----------------------------------//�Ĵ�����
    regfile     cpu_ref     (clk,           rst,            RF_w,           rs,             rt,             RF_waddr,       D_Mux_RF  ,     D_Rs,           D_Rt);
    //----------------------------------//�˳�����
    div         DIV         (D_Rs,          D_Rt,           DIV_start,      clk,            rst,            D_DIV_q,        D_DIV_r,        DIV_busy);
    divu        DIVU        (D_Rs,          D_Rt,           DIVU_start,     clk,            rst,            D_DIVU_q,       D_DIVU_r,       DIVU_busy);
    mult        MULT        (rst,           D_Rs,           D_Rt,           D_MULT);
    multu       MULTU       (rst,           D_Rs,           D_Rt,           D_MULTU);
    //----------------------------------//����Ĵ���
    pcreg       HI          (clk,           rst,            HI_ena,         D_Mux_HI,       D_HI);
    pcreg       LO          (clk,           rst,            LO_ena,         D_Mux_LO,       D_LO);
    //----------------------------------//ѡ����
    mux_pc      Mux_PC      (D_NPC,         D_Rs,           Now_ALU,        D_II,           exc_addr,       M_PC,           D_Mux_PC);
    mux_rf      Mux_RF      (Now_ALU,       D_EXT1,         rdata32,        D_PC,           D_CLZ,          D_HI,           D_LO,           D_CBW,          D_CHW,          CP0_rdata,          M_RF,           D_Mux_RF);
    mux_alu     Mux_ALU     (D_Rs,          D_Rt,           D_EXT5,         D_EXT16,        D_EXT18,        D_PC,           M_ALU,          D_Mux_ALU_a,    D_Mux_ALU_b);
    mux_hi      Mux_HI      (D_Rs,          D_DIV_r,        D_DIVU_r,       D_MULT[63:32],  D_MULTU[63:32], M_HI,           D_Mux_HI);
    mux_lo      Mux_LO      (D_Rs,          D_DIV_q,        D_DIVU_q,       D_MULT[31:0],   D_MULTU[31:0],  M_LO,           D_Mux_LO);
    //----------------------------------//��չ����
    //һλ��չ������Ҫѡ��carry�źŻ�negative�źŽ�����չ
    extend1     EXT1_n      (Now_negative,  D_EXT1_n);
    extend1     EXT1_c      (Now_carry,     D_EXT1_c);
    mux2_32     EXT1        (D_EXT1_n,      D_EXT1_c,       EXT1_n_c,       D_EXT1);
    extend5     EXT5        (shamt,         D_EXT5);
    extend16    EXT16       (immediate,     EXT16_sign,     D_EXT16);
    extend18    EXT18       (immediate,     D_EXT18);
    //----------------------------------//��������
    npc         NPC         (D_PC,          rst,            D_NPC);
    ii          II          (D_PC[31:28],   address,        D_II);
    clz         CLZ         (D_Rs,          D_CLZ);
    extend8     CBW         (rdata8,        CBW_sign,       D_CBW);
    extend16    CHW         (rdata16,       CHW_sign,       D_CHW);
    //----------------------------------//Э������
    cp0         CP0         (clk,           rst,            mfc0,           mtc0,           (D_PC-32'd4),   rd,             D_Rt,           exception,      eret,           cause,          
                            CP0_rdata,      status,         exc_addr);
    cpmem       CPMEM       (data_type,     exact_addr,     addr,           rdata32,        rdata16,        rdata8,         rdata,          wdata32,        wdata16,        wdata8,         wdata);
endmodule