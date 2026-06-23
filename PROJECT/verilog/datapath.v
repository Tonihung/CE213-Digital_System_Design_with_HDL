module DATAPATH_MODULE #(
    parameter IMG_WIDTH = 256,
    parameter IMG_HEIGHT = 256
)(
    input wire CLK, RESET, SEL_3x5, EN,
    input wire [7:0] PIXEL_IN,
    input wire [15:0] B_ADDR,
    output wire FLAG,
    output wire [7:0] PIXEL_OUT
);

    wire [7:0] w_p11, w_p12, w_p13, w_p14, w_p15;
    wire [7:0] w_p21, w_p22, w_p23, w_p24, w_p25;
    wire [7:0] w_p31, w_p32, w_p33, w_p34, w_p35;
    wire [7:0] w_p41, w_p42, w_p43, w_p44, w_p45;
    wire [7:0] w_p51, w_p52, w_p53, w_p54, w_p55;

    wire w_valid;

    WINDOW_5x5 #(
        .IMG_WIDTH(IMG_WIDTH), .IMG_HEIGHT(IMG_HEIGHT)
    ) window_inst (
        .CLK(CLK), .RESET(RESET), .EN(EN), .DATA_IN(PIXEL_IN),
        .p11(w_p11), .p12(w_p12), .p13(w_p13), .p14(w_p14), .p15(w_p15),
        .p21(w_p21), .p22(w_p22), .p23(w_p23), .p24(w_p24), .p25(w_p25),
        .p31(w_p31), .p32(w_p32), .p33(w_p33), .p34(w_p34), .p35(w_p35),
        .p41(w_p41), .p42(w_p42), .p43(w_p43), .p44(w_p44), .p45(w_p45),
        .p51(w_p51), .p52(w_p52), .p53(w_p53), .p54(w_p54), .p55(w_p55),
        .VALID(w_valid)
    );

    CONVOLUTION_MODULE conv_inst (
        .CLK(CLK), .RESET(RESET),
        .VALID(w_valid), .SEL_3x5(SEL_3x5),
        .p11(w_p11), .p12(w_p12), .p13(w_p13), .p14(w_p14), .p15(w_p15),
        .p21(w_p21), .p22(w_p22), .p23(w_p23), .p24(w_p24), .p25(w_p25),
        .p31(w_p31), .p32(w_p32), .p33(w_p33), .p34(w_p34), .p35(w_p35),
        .p41(w_p41), .p42(w_p42), .p43(w_p43), .p44(w_p44), .p45(w_p45),
        .p51(w_p51), .p52(w_p52), .p53(w_p53), .p54(w_p54), .p55(w_p55),
        .FLAG(FLAG),
        .PIXEL_OUT(PIXEL_OUT)
    );

    BRAM #(
        .DATA_WIDTH(8), .ADDR_WIDTH(16), .RAM_DEPTH(65536)
    ) ram_inst (
        .CLK(CLK), .WE(FLAG), .RE(1'b0),
        .WA(B_ADDR), .RA(16'd0),
        .DATA_IN(PIXEL_OUT),
        .DATA_OUT()
    );

endmodule