module CONTROL_MODULE #(
    parameter IMG_WIDTH = 256,
    parameter IMG_HEIGHT = 256
)(
    input CLK, RESET, START, FLAG,
    output wire EN, DONE, STATE_OUT,
    output wire [15:0] B_ADDR
);

    parameter TOTAL_PIXELS = IMG_WIDTH * IMG_HEIGHT;
    parameter IDLE = 1'd0;
    parameter RUN = 1'd1;

    reg State, Next_State;
    reg [15:0] PIXEL_CNT;

    always @(posedge CLK) begin
        if (RESET) State <= IDLE;
        else State <= Next_State;
    end

    always @(State or START or DONE) begin
        Next_State = State;
        case (State)
            IDLE: if (START) Next_State = RUN;
            RUN:  if (DONE)  Next_State = IDLE;
            default: Next_State = IDLE;
        endcase
    end

    always @(posedge CLK) begin
        if (RESET || State == IDLE) begin
            PIXEL_CNT <= 0;
        end
        else if (State == RUN && FLAG) begin
            PIXEL_CNT <= PIXEL_CNT + 1;
        end
    end

    assign STATE_OUT = State;
    assign B_ADDR = PIXEL_CNT;
    assign EN   = (State == RUN) ? 1'b1  : 1'b0;
    assign DONE = (State == RUN && PIXEL_CNT == TOTAL_PIXELS - 1 && FLAG) ? 1'b1 : 1'b0;

endmodule