module mux #(
    parameter WIDTH = 32
)(
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    input Sel,
    output [WIDTH-1:0] Y
);
    assign Y = Sel ? B : A;
endmodule
