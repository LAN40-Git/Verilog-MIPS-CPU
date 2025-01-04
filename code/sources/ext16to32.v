module ext16to32(
    input ExtOp,
    input [15:0] in,
    output reg [31:0] out
);
    parameter Zero = 1'b0; // 无符号扩展
    parameter Sign = 1'b1; // 有符号扩展
    always @(*) begin
        case (ExtOp)
            Zero: begin
                out <= {{16{1'b0}}, in};
            end 
            Sign: begin
                out <= {{16{in[15]}}, in};
            end
            default: begin
                out <= 32'b0;
            end
        endcase
    end
endmodule
