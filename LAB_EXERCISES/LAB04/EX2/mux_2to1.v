module mux_32bit(
    input [31:0] A,
    input [31:0] B,
    input Sel,
    output [31:0] Y
);
    assign Y = Sel ? B : A;
endmodule
