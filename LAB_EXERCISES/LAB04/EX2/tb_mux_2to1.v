`timescale 1ns/1ps
module tb;
    reg [31:0] A, B;
    reg Sel;
    wire [31:0] Y;
    
    mux_32bit uut (
        .A(A),
        .B(B),
        .Sel(Sel),
        .Y(Y)
    );

    initial begin
        $monitor("Time: %0t | A: %h | B: %h | Sel: %b | Y: %h",
                 $time, A, B, Sel, Y);
        // Test case 1: Sel = 0
        A = 32'h12345678; B = 32'h87654321; Sel = 0; #10;
        // Test case 2: Sel = 1
        A = 32'h12345678; B = 32'h87654321; Sel = 1; #10;
        // Test case 3: Sel = 0
        A = 32'hFFFFFFFF; B = 32'h00000000; Sel = 0; #10;
        // Test case 4: Sel = 1
        A = 32'hFFFFFFFF; B = 32'h00000000; Sel = 1; #10;
        #100 $finish;
    end
endmodule
