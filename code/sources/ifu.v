module ifu(
    input clk, // 时钟信号
    input rst, // 复位信号
    input [2:0] PCSrc,
    input [31:0] branch_Addr_JR, // JR指令对应的分支地址，直接来源于R[rs]
    output wire [31:0] inst
);
    reg [31:0] pc_next;
    wire [31:0] pc_new;
    wire [31:0] pc_newAdd4;
    // BEQ和BNE指令对应的分支地址，由指令低16位有符号扩展为32位并左移两位加上PC+4得到
    wire [31:0] branch_Addr_BEQ_BNE;
    // J指令对应的分支地址，由指令低26位左移两位后作为低26位与PC+4后的高4位拼接得到
    wire [31:0] branch_Addr_J;
    wire [31:0] extimm16;
    wire [31:0] leftShift_extimm16,leftShift_imm26;
    pc pc_inst(clk,rst_PC,pc_next,pc_new);
    assign pc_newAdd4 = pc_new + 4;
    ext16to32 ext16to32_inst(1'b1,inst[15:0],extimm16); // 有符号扩展成32位
    assign leftShift_extimm16 = extimm16<<2;
    assign leftShift_imm26 = inst[25:0]<<2;
    assign branch_Addr_BEQ_BNE = leftShift_extimm16 + pc_newAdd4;
    assign branch_Addr_J = {pc_newAdd4[31:28],leftShift_imm26};

    parameter PCAdd4 = 3'b000;
    parameter JR     = 3'b001;
    parameter BEQ    = 3'b010;
    parameter BNE    = 3'b011;
    parameter J      = 3'b100;

    always @(*) begin
        case (PCSrc)
            PCAdd4: begin
                pc_next <= pc_newAdd4;
            end
            JR: begin
                pc_next <= branch_Addr_JR; 
            end
            BEQ: begin
                pc_next <= branch_Addr_BEQ_BNE;
            end
            BNE: begin
                pc_next <= branch_Addr_BEQ_BNE;
            end
            J: begin
                pc_next <= branch_Addr_J;
            end
            default: begin
                pc_next <= pc_new;
            end
        endcase
    end
    // 从指令寄存器读取指令
    inst_mem inst_mem_inst(pc_new,inst);
endmodule