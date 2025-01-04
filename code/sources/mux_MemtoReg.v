module mux_MemtoReg (
    input MemtoReg,
    input [31:0] ALU_out,Data_out,
    output reg [31:0] busW
);
    always @(*) begin
        if (MemtoReg) begin
            busW <= Data_out;
        end else begin
            busW <= ALU_out;
        end
    end
endmodule