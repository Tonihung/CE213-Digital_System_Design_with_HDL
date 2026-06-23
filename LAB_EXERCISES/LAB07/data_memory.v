module DataMemory(
    input CLK, WriteEn, ReadEn,
    input [9:0] Address,
    input [31:0] WriteData,
    output [31:0] ReadData
);
    reg [31:0] memory [0:1023];
    assign ReadData = (ReadEn) ? memory[Address] : 32'b0;
    always @(posedge CLK) begin
        if (WriteEn) begin
            memory[Address] <= WriteData;
        end
    end
endmodule

