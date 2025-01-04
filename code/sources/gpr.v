module gpr (
    input clk,rst,
    input WrEn,  // 写入控制信号，RegWr=1时允许写入
    input [31:0] busW,
    input [4:0] ra,rb,rw,shamtIn,
    output [4:0] shamtOut,
    output [31:0] busA,busB,Data_in
);
    assign shamtOut = shamtIn;
    reg [31:0] regi [31:0]; // 32个寄存器，对应5位

    // 复位
    integer i;
    always @(negedge rst) begin
        if (!rst) begin
            for (i=0;i<32;i=i+1)
                regi[i]=0;
        end
    end

    // 设置 busA 和 busB
    assign busA = regi[ra];
    assign busB = regi[rb];
    assign Data_in = busB;

    // 写入控制
    always @(posedge clk) begin
        if (WrEn) begin
            regi[rw] <= busW;
            regi[0]<=0; // 保持寄存器0始终为0
        end
    end
endmodule