module TOP_MODULE #(
    parameter IMG_WIDTH = 256,
    parameter IMG_HEIGHT = 256
)(
    input wire CLK, RESET, START, SEL_3x5,
    input wire [7:0] PIXEL_IN,
    output wire [7:0] PIXEL_OUT,
    output wire STATE_OUT,
    output wire DONE
);

    wire w_en, w_flag;
    wire [15:0] w_b_addr;

    CONTROL_MODULE #(
        .IMG_WIDTH(IMG_WIDTH), .IMG_HEIGHT(IMG_HEIGHT)
    ) ctrl_unit (
        .CLK(CLK), .RESET(RESET), .START(START),
        .FLAG(w_flag),
        .EN(w_en), .B_ADDR(w_b_addr),
        .DONE(DONE), .STATE_OUT(STATE_OUT)
    );

    DATAPATH_MODULE #(
        .IMG_WIDTH(IMG_WIDTH), .IMG_HEIGHT(IMG_HEIGHT)
    ) data_path_unit (
        .CLK(CLK), .RESET(RESET), .PIXEL_IN(PIXEL_IN),
        .SEL_3x5(SEL_3x5), .EN(w_en),
        .B_ADDR(w_b_addr), .FLAG(w_flag),
        .PIXEL_OUT(PIXEL_OUT)
    );
endmodule