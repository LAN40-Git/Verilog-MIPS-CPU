module mux_ALUSrc (
    input ALUSrc, // ALUSrc=0时，选择busB，否则选择扩展后的32位数
    input [31:0] busB,extOut,
    output reg [31:0] out
);
    always @(*) begin
        if (ALUSrc) begin // 选择扩展后的32位数
            out <= extOut;
        end else begin // 选择busB
            out <= busB;
        end
    end
endmodule