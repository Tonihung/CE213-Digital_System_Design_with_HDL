module CONVOLUTION_MODULE (
    input CLK, RESET, VALID, SEL_3x5,
    
    input wire [7:0] p11, p12, p13, p14, p15,
    input wire [7:0] p21, p22, p23, p24, p25,
    input wire [7:0] p31, p32, p33, p34, p35,
    input wire [7:0] p41, p42, p43, p44, p45,
    input wire [7:0] p51, p52, p53, p54, p55,
    
    output reg FLAG,       
    output reg [7:0] PIXEL_OUT 
);

    reg [15:0] SUM;
    reg FLAG_TMP;

    always @(posedge CLK) begin
        if (RESET) begin 
            SUM <= 0;
            FLAG_TMP <= 0;
            PIXEL_OUT <= 0;
            FLAG <= 0;
        end
        else begin
            if (VALID) begin
                if (SEL_3x5 == 1'b0)
                    SUM <= (p22) + (p23<<1) + (p24) +
                           (p32<<1) + (p33<<2) + (p34<<1) +
                           (p42) + (p43<<1) + (p44);
                else
                    SUM <= p11 + (p12<<2) + ((p13<<2) + (p13<<1)) + (p14<<2) + p15 +
                           (p21<<2) + (p22<<4) + ((p23<<4) + (p23<<3)) + (p24<<4) + (p25<<2) +
                           ((p31<<2) + (p31<<1)) + ((p32<<4) + (p32<<3)) + ((p33<<5) + (p33<<2)) + ((p34<<4) + (p34<<3)) + ((p35<<2) + (p35<<1)) +
                           (p41<<2) + (p42<<4) + ((p43<<4) + (p43<<3)) + (p44<<4) + (p45<<2) +
                           p51 + (p52<<2) + ((p53<<2) + (p53<<1)) + (p54<<2) + p55;
            end
            FLAG_TMP <= VALID; 
            if (FLAG_TMP) begin
                if (SEL_3x5 == 1'b0) begin
                    PIXEL_OUT <= (((SUM + 8) >> 4) > 255) ? 8'd255 : ((SUM + 8) >> 4); 
                end
                else begin
                    PIXEL_OUT <= (((SUM + 128) >> 8) > 255) ? 8'd255 : ((SUM + 128) >> 8); 
                end
            end
            FLAG <= FLAG_TMP; 
        end
    end
endmodule