module counter (
    input CLK,
    input [2:0] PRESET, 
    input [2:0] CLEAR,
    output reg [2:0] count
);
    reg [2:0] next_count;
    always @(*) begin
        case (count)
            3'b000: next_count <= 3'b110;
            3'b110: next_count <= 3'b100;
            3'b100: next_count <= 3'b111;
            3'b111: next_count <= 3'b011;
            3'b011: next_count <= 3'b000;
            3'b101: next_count <= 3'b010;
            3'b010: next_count <= 3'b111;
            3'b001: next_count <= 3'b110;
            default: next_count <= 3'b000;
        endcase
    end

    always @(posedge CLK or posedge PRESET[0] or posedge CLEAR[0]) begin
        if (CLEAR[0])
            count[0] <= 1'b0;
        else if (PRESET[0])
            count[0] <= 1'b1;
        else
            count[0] <= next_count[0];
    end

    always @(posedge CLK or posedge PRESET[1] or posedge CLEAR[1]) begin
        if (CLEAR[1])
            count[1] <= 1'b0;
        else if (PRESET[1])
            count[1] <= 1'b1;
        else
            count[1] <= next_count[1];
    end

    always @(posedge CLK or posedge PRESET[2] or posedge CLEAR[2]) begin
        if (CLEAR[2])
            count[2] <= 1'b0;
        else if (PRESET[2])
            count[2] <= 1'b1;
        else
            count[2] <= next_count[2];
    end
endmodule