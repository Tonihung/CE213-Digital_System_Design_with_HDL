module BRAM #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 16,
    parameter RAM_DEPTH  = 65536
)(
    input CLK,
    input WE,
    input RE,
    input [ADDR_WIDTH-1:0] WA,
    input [ADDR_WIDTH-1:0] RA,
    input [DATA_WIDTH-1:0] DATA_IN,
    output reg [DATA_WIDTH-1:0] DATA_OUT
);

    reg [DATA_WIDTH-1:0] bram [0:RAM_DEPTH-1];
    always @(posedge CLK) begin
        if (WE) begin
            bram[WA] <= DATA_IN;
        end
        if (RE) begin
            DATA_OUT <= bram[RA];
        end
    end
endmodule