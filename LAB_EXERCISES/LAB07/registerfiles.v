module registers(
    input CLK, WriteEn,
    input [4:0] RA1, RA2,
    input [4:0] WA,
    input [31:0] WD,
    output [31:0] RD1, RD2
);
    reg [31:0] registers [0:31];

    always @(posedge CLK) begin
        if (WriteEn && WA != 5'b0) begin
            registers[WA] <= WD;
        end
    end
    assign RD1 = (RA1 != 5'b0) ? registers[RA1] : 32'b0;
    assign RD2 = (RA2 != 5'b0) ? registers[RA2] : 32'b0;
endmodule
