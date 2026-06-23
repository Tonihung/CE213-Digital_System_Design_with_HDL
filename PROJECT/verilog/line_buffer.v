module LINE_BUFFER #(
    parameter IMG_WIDTH = 256
)(
    input CLK,
    input RESET,
    input EN,
    input [7:0] DATA_IN,
    output reg [7:0] DATA_OUT
);
    reg [7:0] line [0:IMG_WIDTH-1];
    reg [7:0] ptr;
    always @(posedge CLK) begin
        if (RESET) begin 
            ptr <= 0;
            DATA_OUT <= 0;
        end
        else if (EN) begin
            DATA_OUT <= line[ptr];
            line[ptr] <= DATA_IN;
            ptr <= (ptr == IMG_WIDTH-2) ? 0 : ptr + 1;
        end
    end
endmodule