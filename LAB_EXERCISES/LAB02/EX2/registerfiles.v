module register_files(
    input CLK, RST, WriteEn, ReadEn,
    input [4:0] RA1, RA2,
    input [4:0] WA,
    input [31:0] WD,
    output reg [31:0] RD1, RD2
);
    reg [31:0] registers [31:0];
    integer i;

    always @(posedge CLK) begin
        if (RST) begin
            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 32'b0;
            RD1 <= 32'b0;
            RD2 <= 32'b0;
        end
        else begin
            if (WriteEn) begin
                registers[WA] <= WD;
            end
            if (ReadEn) begin
                RD1 <= registers[RA1];
                RD2 <= registers[RA2];
            end
        end
    end
endmodule