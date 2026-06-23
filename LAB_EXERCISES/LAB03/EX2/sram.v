module SRAM (
    input CLK, WriteEn, ReadEn, RST,
    input [9:0] Address,
    input [31:0] WriteData,
    output reg [31:0] ReadData
);
    reg [31:0] memory [0:1023];
    integer i;

    always @(posedge CLK) begin
        if (RST) begin
            for (i = 0; i < 1024; i = i + 1)
                memory[i] <= 32'b0;
            ReadData <= 32'b0;
        end
        else begin
            if (WriteEn) begin
            memory[Address] <= WriteData;
            end
            if (ReadEn) begin
            ReadData <= memory[Address];
            end
        end
    end
endmodule
