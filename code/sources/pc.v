module pc (
    input clk,
    input rst,
    input [31:0] pc_next,
    output reg [31:0] pc // 程序计数器
);
    // 初始化PC的值
    initial begin
        pc = 32'h0000_0000;
    end

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            pc <= 32'h0000_0000;
        end else begin
            pc <= pc_next;
        end
    end
endmodule