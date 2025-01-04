module mux_RegDst (
    input RegDst,
    input [4:0] rt,rd,
    output reg [4:0] rw
);
    always @(*) begin
        if (RegDst) begin
            rw <= rd;
        end else begin
            rw <= rt;
        end
    end
endmodule