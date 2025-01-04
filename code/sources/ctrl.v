module ctrl (
    input [5:0] op,
    input [5:0] funct,
    input equal,
    output reg [2:0] PCSrc,
    output reg RegDst,  // 寄存器堆写入端控制信号
    output reg RegWr,   // 寄存器堆写使能信号
    output reg ExtOp,   // 无符号和有符号扩展信号
    output reg ALUSrc,
    output reg [5:0] ALUCtr,
    output reg MemWr,   // 数据存储器写使能端
    output reg MemtoReg // 写回来源控制信号
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
    parameter JR  = 6'b001000; // `PC=R[rs]`
    /* @I型指令*/
    parameter ADDI  = 6'b001000; // `R[rt]=R[rs]+SignExt[im]`
    parameter ADDIU = 6'b001001; // `R[rt]=R[rs]+ZeroExt[im]`(无符号数)
    parameter SLTI  = 6'b001010; // `R[rt]=(R[rs]<SignExt[im])?1:0`
    parameter SLTIU = 6'b001011; // `R[rt]=(R[rs]<ZeroExt[im])?1:0`(无符号数)
    parameter ANDI  = 6'b001100; // `R[rt]=R[rs]&ZeroExt[im]`
    parameter ORI   = 6'b001101; // `R[rt]=R[rs]|ZeroExt[im]`
    parameter XORI  = 6'b001110; // `R[rt]=R[rs]^ZeroExt[im]`
    parameter LW    = 6'b100011; // `R[rt]=Mem[R[rs]+SignExt[im]]`
    parameter SW    = 6'b101011; // `Mem[R[rs]+SignExt[im]]=R[rt]`
    parameter BEQ   = 6'b000100; // `PC=(rs==rt)?PC+4+im<<2:PC`
    parameter BNE   = 6'b000101; // `PC=(rs!=rt)?PC+4+im<<2:PC`
    /* @J型指令*/
    parameter J   = 6'b000010; // `PC={(PC+4)[31:28],address<<2}`

    always @(*) begin
        // 默认赋值
        PCSrc = 3'b000;     // PC默认自增4
        RegDst = 1;         // 默认写入R[rd]
        RegWr = 0;          // 寄存器堆默认不可写入
        ExtOp = 0;          // 默认进行无符号扩展
        ALUSrc = 0;         // ALU的第二个操作数默认来源于寄存器堆
        ALUCtr = 6'b111111; // ALU操作默认未知
        MemWr = 0;          // 数据存储器默认不写入
        MemtoReg = 0;       // 默认选择ALU_out
        if (op == 6'b0) begin // R型指令
            /* @R型指令*/
            RegWr=1;  // 除了JR都需要写入
            ALUCtr = funct; // 设置对应的ALU控制信号
            case (funct)
                ADD: begin
                    
                end
                ADDU: begin
                    
                end
                SUB: begin
                    
                end
                SUBU: begin
                    
                end
                SLT: begin
                    
                end
                SLTU: begin
                    
                end
                AND: begin
                    
                end
                OR: begin
                    
                end
                XOR: begin
                    
                end
                NOR: begin
                    
                end
                SLL: begin
                    
                end
                SRL: begin
                    
                end
                SRA: begin
                    
                end
                SLLV: begin
                    
                end
                SRLV: begin
                    
                end
                SRAV: begin
                    
                end
                JR: begin
                    PCSrc = 3'b001;
                    RegWr = 0;
                end
            endcase
        end else begin // I型和J型指令
            RegDst = 0;  // 默认写入R[rt]
            RegWr = 1;   // 除了SW,BEQ,BNE和J指令，其它指令都需要写入寄存器堆
            ALUSrc = 1;
            case (op)
                /* @I型指令*/
                ADDI: begin
                    ExtOp = 1;
                    ALUCtr = ADDI;
                end
                ADDIU: begin
                    ALUCtr = ADDIU;
                end
                SLTI: begin
                    ALUCtr = SLTI;
                    ExtOp = 1;
                end
                SLTIU: begin
                    ALUCtr = SLTIU;
                end
                ANDI: begin
                    ALUCtr = ANDI;
                end
                ORI: begin
                    ALUCtr = ORI;
                end
                XORI: begin
                    ALUCtr = XORI;
                end
                LW: begin
                    ExtOp = 1;
                    MemtoReg = 1;
                    ALUCtr = ADD;
                end
                SW: begin
                    RegWr = 0;
                    ExtOp = 1;
                    MemWr = 1;
                    ALUCtr = ADD;
                end
                BEQ: begin
                    RegWr = 0;
                    ALUCtr = SUB;
                    ExtOp = 1;
                    ALUSrc = 0;
                    if (equal) begin
                        PCSrc = 3'b010;
                    end
                end
                BNE: begin
                    RegWr = 0;
                    ExtOp = 1;
                    ALUCtr = SUB;
                    ALUSrc = 0;
                    if (!equal) begin
                        PCSrc = 3'b011;
                    end
                end
                /* @J型指令*/
                J: begin
                    RegWr = 0;
                    ALUCtr = ADD;
                    PCSrc = 3'b100;
                end
            endcase
        end
    end
endmodule