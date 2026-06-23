`timescale 1ns/1ps
module tb;
    reg [31:0] A, B;
    reg M, S0, S1;
    wire [31:0] ALUResult;
    wire OF;
    ALU_32bit uut (
        .A(A),
        .B(B),
        .M(M),
        .S0(S0),
        .S1(S1),
        .ALUResult(ALUResult),
        .OF(OF)
    );

    task run_test;
        input [31:0] a, b;
        input [2:0] sel; 
        begin
            A = a;
            B = b;
            M = sel[2];
            S1 = sel[1];
            S0 = sel[0];
            #10;
        end
    endtask

    initial begin
        $monitor("Time: %0t | A: %h | B: %h | Sel: %b | ALUResult: %h | OF: %b",
                 $time, A, B, {M, S1, S0}, ALUResult, OF);
        // Test NOT
        run_test(32'hFFFFFFFF, 0, 3'b000);
        // Test AND
        run_test(32'hF0F0F0F0, 32'h0F0F0F0F, 3'b001);
        // Test XOR
        run_test(32'hAAAA5555, 32'h5555AAAA, 3'b010);
        // Test OR
        run_test(32'h12345678, 32'h87654321, 3'b011);
        // Test Decrement
        run_test(32'h00000001, 0, 3'b100);
        // Test ADD
        run_test(32'h7FFFFFFF, 1, 3'b101);
        // Test SUB
        run_test(32'h80000000, 1, 3'b110);
        // Test Increment
        run_test(32'hFFFFFFFF, 0, 3'b111);

        #100 $finish;
    end
endmodule