module inst_mem (
    input [31:0] Addr,
    output reg [31:0] inst
);
    reg [31:0] mem [0:1023]; // 存储1024条指令

    // 初始化指令存储器
    initial begin
        $readmemh("C:/Users/LAN/Desktop/Practice/code/test/bubbleSort_Instruction/instruction.hex", mem);
    end

    // 载入指令 
    always @(*) begin
        inst = mem[Addr[11:2]];
    end
endmodule