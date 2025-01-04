module data_mem (
    input clk,
    input WrEn,
    input [31:0] Data_in,
    input [9:0] Addr,
    output [31:0] Data_out
);

    reg [31:0] mem [0:1023];
    
    // 初始化数据存储器
    initial begin
        $readmemh("C:/Users/LAN/Desktop/Practice/code/test/bubbleSort_Instruction/data.hex", mem);
    end

    assign Data_out = mem[Addr];

    always @(posedge clk) begin
        if (WrEn) begin // 执行SW指令时进行写入
            mem[Addr] <= Data_in;
        end
    end
endmodule