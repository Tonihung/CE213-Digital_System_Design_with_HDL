module WINDOW_5x5 #(
    parameter IMG_WIDTH = 256,
    parameter IMG_HEIGHT = 256
)(
    input CLK, RESET, EN,
    input [7:0] DATA_IN,
    output reg [7:0] p11, p12, p13, p14, p15,
    output reg [7:0] p21, p22, p23, p24, p25,
    output reg [7:0] p31, p32, p33, p34, p35,
    output reg [7:0] p41, p42, p43, p44, p45,
    output reg [7:0] p51, p52, p53, p54, p55,
    
    output reg VALID
);

    wire [7:0] ROW1, ROW2, ROW3, ROW4;
    
    reg [7:0] r11, r12, r13, r14, r15;
    reg [7:0] r21, r22, r23, r24, r25;
    reg [7:0] r31, r32, r33, r34, r35;
    reg [7:0] r41, r42, r43, r44, r45;
    reg [7:0] r51, r52, r53, r54, r55;
    
    reg [7:0] x, y; 
    reg [9:0] wait_cnt;

    always @(posedge CLK) begin
        if (RESET) begin
            wait_cnt <= (2 * IMG_WIDTH) + 2;
            VALID <= 0;
            x <= 0; y <= 0;
        end
        else if (EN) begin
            if (wait_cnt > 0) wait_cnt <= wait_cnt - 1;
            else begin
                VALID <= 1'b1;
                if (VALID == 1'b1) begin 
                    if (x == IMG_WIDTH - 1) begin
                        x <= 0;
                        y <= (y == IMG_HEIGHT - 1) ? 0 : y + 1;
                    end
                    else x <= x + 1;
                end
            end
        end
    end

    LINE_BUFFER #(IMG_WIDTH) LB1 (.CLK(CLK), .RESET(RESET), .EN(EN), .DATA_IN(DATA_IN), .DATA_OUT(ROW4));
    LINE_BUFFER #(IMG_WIDTH) LB2 (.CLK(CLK), .RESET(RESET), .EN(EN), .DATA_IN(ROW4),    .DATA_OUT(ROW3));
    LINE_BUFFER #(IMG_WIDTH) LB3 (.CLK(CLK), .RESET(RESET), .EN(EN), .DATA_IN(ROW3),    .DATA_OUT(ROW2));
    LINE_BUFFER #(IMG_WIDTH) LB4 (.CLK(CLK), .RESET(RESET), .EN(EN), .DATA_IN(ROW2),    .DATA_OUT(ROW1));

    always @(posedge CLK) begin
        if (RESET) begin
            {r11,r12,r13,r14,r15} <= 0;
            {r21,r22,r23,r24,r25} <= 0;
            {r31,r32,r33,r34,r35} <= 0;
            {r41,r42,r43,r44,r45} <= 0;
            {r51,r52,r53,r54,r55} <= 0;
        end
        else if (EN) begin
            r11<=r12; r12<=r13; r13<=r14; r14<=r15; r15<=ROW1;
            r21<=r22; r22<=r23; r23<=r24; r24<=r25; r25<=ROW2;
            r31<=r32; r32<=r33; r33<=r34; r34<=r35; r35<=ROW3;
            r41<=r42; r42<=r43; r43<=r44; r44<=r45; r45<=ROW4;
            r51<=r52; r52<=r53; r53<=r54; r54<=r55; r55<=DATA_IN;
        end
    end

    reg [7:0] t11, t12, t13, t14, t15;
    reg [7:0] t21, t22, t23, t24, t25;
    reg [7:0] t31, t32, t33, t34, t35;
    reg [7:0] t41, t42, t43, t44, t45;
    reg [7:0] t51, t52, t53, t54, t55;

    always @(*) begin
        {t31,t32,t33,t34,t35} = {r31,r32,r33,r34,r35};

        if (y == 0) begin
            {t11,t12,t13,t14,t15} = {r51,r52,r53,r54,r55};
            {t21,t22,t23,t24,t25} = {r41,r42,r43,r44,r45};
        end
        else if (y == 1) begin
            {t11,t12,t13,t14,t15} = {r31,r32,r33,r34,r35};
            {t21,t22,t23,t24,t25} = {r21,r22,r23,r24,r25};
        end
        else begin
            {t11,t12,t13,t14,t15} = {r11,r12,r13,r14,r15};
            {t21,t22,t23,t24,t25} = {r21,r22,r23,r24,r25};
        end

        if (y == IMG_HEIGHT - 1) begin
            {t41,t42,t43,t44,t45} = {r21,r22,r23,r24,r25};
            {t51,t52,t53,t54,t55} = {r11,r12,r13,r14,r15};
        end
        else if (y == IMG_HEIGHT - 2) begin
            {t41,t42,t43,t44,t45} = {r41,r42,r43,r44,r45};
            {t51,t52,t53,t54,t55} = {r31,r32,r33,r34,r35};
        end
        else begin
            {t41,t42,t43,t44,t45} = {r41,r42,r43,r44,r45};
            {t51,t52,t53,t54,t55} = {r51,r52,r53,r54,r55};
        end

        {p13,p23,p33,p43,p53} = {t13,t23,t33,t43,t53};

        if (x == 0) begin
            {p11, p21, p31, p41, p51} = {t15, t25, t35, t45, t55}; 
            {p12, p22, p32, p42, p52} = {t14, t24, t34, t44, t54}; 
        end
        else if (x == 1) begin
            {p11, p21, p31, p41, p51} = {t13, t23, t33, t43, t53}; 
            {p12, p22, p32, p42, p52} = {t12, t22, t32, t42, t52};
        end
        else begin
            {p11, p21, p31, p41, p51} = {t11, t21, t31, t41, t51}; 
            {p12, p22, p32, p42, p52} = {t12, t22, t32, t42, t52}; 
        end

        if (x == IMG_WIDTH - 1) begin
            {p14, p24, p34, p44, p54} = {t12, t22, t32, t42, t52}; 
            {p15, p25, p35, p45, p55} = {t11, t21, t31, t41, t51}; 
        end
        else if (x == IMG_WIDTH - 2) begin
            {p14, p24, p34, p44, p54} = {t14, t24, t34, t44, t54};
            {p15, p25, p35, p45, p55} = {t13, t23, t33, t43, t53}; 
        end
        else begin
            {p14, p24, p34, p44, p54} = {t14, t24, t34, t44, t54}; 
            {p15, p25, p35, p45, p55} = {t15, t25, t35, t45, t55}; 
        end
    end
endmodule