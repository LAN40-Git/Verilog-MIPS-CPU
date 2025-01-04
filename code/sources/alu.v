module alu (
    input [5:0] ALUCtr,
    input [4:0] shamt,
    input [31:0] src1,src2,
    output reg equal,
    output reg [31:0] ALU_out
);

    // 初始化指令
    /* @R型指令*/
    parameter ADD  = 6'b100000; // `R[rd]=R[rs]+R[rt]`
    parameter ADDU = 6'b100001; // `R[rd]=R[rs]+R[rt]`(无符号数)
    parameter SUB  = 6'b100010; // `R[rd]=R[rs]-R[rt]`
    parameter SUBU = 6'b100011; // `R[rd]=R[rs]-R[rt]`(无符号数)
    parameter SLT  = 6'b101010; // `R[rd]=(R[rs]<R[rt])?1:0`
    parameter SLTU = 6'b101011; // `R[rd]=(R[rs]<R[rt])?1:0`(无符号数)
    parameter AND  = 6'b100100; // `R[rd]=R[rs]&R[rt]`
    parameter OR   = 6'b100101; // `R[rd]=R[rs]|R[rt]`
    parameter XOR  = 6'b100110; // `R[rd]=R[rs]^R[rt]`
    parameter NOR  = 6'b100111; // `R[rd]=~(R[rs]|R[rt])`
    parameter SLL  = 6'b000000; // `R[rd]=R[rt]<<shamt`
    parameter SRL  = 6'b000010; // `R[rd]=R[rt]>>shamt`
    parameter SRA  = 6'b000011; // `R[rd]=R[rt]>>shamt`(符号位保留)
    parameter SLLV = 6'b000100; // `R[rd]=R[rt]<<R[rs]`
    parameter SRLV = 6'b000110; // `R[rd]=R[rt]>>R[rs]`
    parameter SRAV = 6'b000111; // `R[rd]=R[rt]>>R[rs]`(符号位保留)
    /* @I型指令*/
    parameter ADDI  = 6'b001000; // `R[rt]=R[rs]+SignExt[im]`
    parameter ADDIU = 6'b001001; // `R[rt]=R[rs]+ZeroExt[im]`(无符号数)
    parameter SLTI  = 6'b001010; // `R[rt]=(R[rs]<SignExt[im])?1:0`
    parameter SLTIU = 6'b001011; // `R[rt]=(R[rs]<ZeroExt[im])?1:0`(无符号数)
    parameter ANDI  = 6'b001100; // `R[rt]=R[rs]&ZeroExt[im]`
    parameter ORI   = 6'b001101; // `R[rt]=R[rs]|ZeroExt[im]`
    parameter XORI  = 6'b001110; // `R[rt]=R[rs]^ZeroExt[im]`



    always @(*) begin
        case (ALUCtr)
            /* @R型指令*/
            ADD: begin
                ALU_out = src1 + src2;
            end
            ADDU: begin
                ALU_out = src1 + src2;
            end
            SUB: begin
                ALU_out = src1 - src2;
            end
            SUBU: begin
                ALU_out = src1 - src2;
            end
            SLT: begin
                ALU_out = (src1<src2)?32'b1:32'b0;
            end
            SLTU: begin
                ALU_out = (src1<src2)?32'b1:32'b0;
            end
            AND: begin
                ALU_out = src1 & src2;
            end
            OR: begin
                ALU_out = src1 | src2;
            end
            XOR: begin
                ALU_out = src1 ^ src2;
            end
            NOR: begin
                ALU_out = ~(src1 | src2);
            end
            SLL: begin
                ALU_out = src2 << shamt;
            end
            SRL: begin
                ALU_out = src2 >> shamt;
            end
            SRA: begin
                ALU_out = src2 >>> shamt;
            end
            SLLV: begin
                ALU_out = src2 << src1[4:0];
            end
            SRLV: begin
                ALU_out = src2 >> src1[4:0];
            end
            SRAV: begin
                ALU_out = src2 >>> src1[4:0];
            end
            /* @I型指令*/
            ADDI: begin
                ALU_out = src1 + src2;
            end
            ADDIU: begin
                ALU_out = src1 + src2;
            end
            SLTI: begin
                ALU_out = (src1<src2)?32'b1:32'b0;
            end
            SLTIU: begin
                ALU_out = (src1<src2)?32'b1:32'b0;
            end
            ANDI: begin
                ALU_out = src1 & src2;
            end
            ORI: begin
                ALU_out = src1 | src2;
            end
            XORI: begin
                ALU_out = src1 ^ src2;
            end
            default: begin
                ALU_out = 32'b0;
            end
        endcase
    end
    
    always @(*) begin
            if (ALU_out == 0) begin
                equal = 1;
            end else begin
                equal = 0;
            end
        end
endmodule