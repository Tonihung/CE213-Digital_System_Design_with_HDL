module ALU(
    input [31:0] A,
    input [31:0] B,
    input M, S0, S1,
    output reg [31:0] ALUResult,
    output reg OF
);  
    wire [2:0] sel = {M, S1, S0};
    always @(*) begin
        case (sel)
            3'b000: ALUResult = ~A; // NOT
            3'b001: ALUResult = A & B; // AND
            3'b010: ALUResult = A ^ B; // XOR
            3'b011: ALUResult = A | B; // OR
            3'b100: ALUResult = A - 1'b1; // Decrement
            3'b101: 
                begin
                    ALUResult = A + B; // ADD  
                    OF = (A[31] & B[31] & ~ALUResult [31])|(~A[31] & ~B[31] & ALUResult[31]);
                end 
            3'b110: 
                begin
                    ALUResult = A - B; // SUB
                    OF = (A[31] & ~B[31] & ~ALUResult [31])|(~A[31] & B[31] & ALUResult[31]);  
                end
            3'b111: ALUResult = A + 1'b1; // Increment
            default: ALUResult = 0;
        endcase
    end
endmodule