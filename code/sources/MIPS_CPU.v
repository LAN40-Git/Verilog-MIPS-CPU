`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/02 02:26:51
// Design Name: 
// Module Name: MIPS_CPU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module MIPS_CPU ();
    reg clk,rst;

    initial begin
        clk = 0;
        rst = 1;
        #100;
        rst = 0;
        forever
            #100
            clk = ~clk;
    end

    wire [2:0] PCSrc;
    wire RegDst, RegWr;
    wire ExtOp;
    wire ALUSrc;
    wire [5:0] ALUCtr;
    wire MemWr,MemtoReg;

    wire [31:0] inst; // 指令字
    wire equal; // BEQ,BNE比较结果
    wire [4:0] shamt;
    wire [4:0] rw;
    wire [31:0] busA,busB,busW,Data_in;
    wire [31:0] src2;
    wire [31:0] extOutI;
    wire [31:0] ALU_out;
    wire [31:0] Data_out;

    assign Data_in = busB;

    ctrl ctrl_inst(
        .op(inst[31:26]),
        .funct(inst[5:0]),
        .equal(equal),
        .PCSrc(PCSrc),
        .RegDst(RegDst),
        .RegWr(RegWr),
        .ExtOp(ExtOp),
        .ALUSrc(ALUSrc),
        .ALUCtr(ALUCtr),
        .MemWr(MemWr),
        .MemtoReg(MemtoReg)
    );

    mux_RegDst mux_RegDst_inst(
        .RegDst(RegDst),
        .rt(inst[20:16]),
        .rd(inst[15:11]),
        .rw(rw)
    );

    gpr gpr_inst(
        .clk(clk),
        .rst(rst),
        .WrEn(RegWr),
        .busW(busW),
        .ra(inst[25:21]),
        .rb(inst[20:16]),
        .rw(rw),
        .shamtIn(inst[10:6]),
        .shamtOut(shamt),
        .busA(busA),
        .busB(busB),
        .Data_in(Data_in)
    );

    ext16to32 ext16to32_inst_ALUSrc(
        .ExtOp(ExtOp),
        .in(inst[15:0]),
        .out(extOutI)
    );

    mux_ALUSrc mux_ALUSrc_inst(
        .ALUSrc(ALUSrc),
        .busB(busB),
        .extOut(extOutI),
        .out(src2)
    );

    alu alu_inst(
        .ALUCtr(ALUCtr),
        .shamt(shamt),
        .src1(busA),
        .src2(src2),
        .equal(equal),
        .ALU_out(ALU_out)
    );

    data_mem data_mem_inst(
        .clk(clk),
        .WrEn(MemWr),
        .Data_in(Data_in),
        .Addr(ALU_out[9:0]),
        .Data_out(Data_out)
    );

    mux_MemtoReg mux_MemtoReg_inst(
        .MemtoReg(MemtoReg),
        .ALU_out(ALU_out),
        .Data_out(Data_out),
        .busW(busW)
    );

    ifu ifu_inst(
        .clk(clk),
        .rst(rst),
        .PCSrc(PCSrc),
        .branch_Addr_JR(busA),
        .inst(inst)
    );

endmodule
