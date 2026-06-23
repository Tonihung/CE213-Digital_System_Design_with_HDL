module tb;
    parameter WIDTH = 256;
    parameter HEIGHT = 256;
    parameter TOTAL = WIDTH * HEIGHT;

    reg CLK, RESET, START;
    reg [7:0] PIXEL_IN;
    reg SEL_IN;

    wire DONE;
    wire [7:0] PIXEL_OUT;
    wire STATE_OUT;

    reg [7:0] img_data [0:TOTAL-1];
    integer i, j, fd;

    TOP_MODULE #(
        .IMG_WIDTH(WIDTH), .IMG_HEIGHT(HEIGHT)
    ) uut (
        .CLK(CLK), .RESET(RESET), .START(START),
        .SEL_3x5(SEL_IN),
        .PIXEL_IN(PIXEL_IN), .PIXEL_OUT(PIXEL_OUT),
        .STATE_OUT(STATE_OUT), .DONE(DONE)
    );

    always #5 CLK = ~CLK;

    initial begin
        $readmemh("C:/Users/Toni Hung/Documents/UIT/HK2_2025-2026/HDL/PROJECT/hex_input/lena1.hex", img_data);
        CLK = 0; RESET = 1; START = 0; PIXEL_IN = 0; i = 0;
        PIXEL_IN = img_data[0];
        SEL_IN = 0;

        #10 RESET = 0;
        #10 START = 1;
        #10 START = 0;

        while (i < TOTAL) begin
            @(posedge CLK);
            if (uut.w_en) begin 
                i = i + 1;
                if (i < TOTAL) #1 PIXEL_IN = img_data[i];
            end
        end

        $display("==================================================");
        if (SEL_IN == 0) $display("Da nap xong %0d pixel (Che do 3x3). Dang xu ly...", TOTAL);
        else $display("Da nap xong %0d pixel (Che do 5x5). Dang xu ly...", TOTAL);
        
        wait(DONE);
        @(posedge CLK);
        @(posedge CLK);
        
        $display("--------------------------------------------------");
        $display("XU LY HOAN TAT THANH CONG! THOI GIAN: %0t", $time);
        
        if (SEL_IN == 0) begin
            fd = $fopen("C:/Users/Toni Hung/Documents/UIT/HK2_2025-2026/HDL/PROJECT/hex_output/lena1_3x3.hex", "w");
        end else begin
            fd = $fopen("C:/Users/Toni Hung/Documents/UIT/HK2_2025-2026/HDL/PROJECT/hex_output/lena1_5x5.hex", "w");
        end
        for (j = 0; j < TOTAL; j = j + 1) begin
            $fdisplay(fd, "%02h", uut.data_path_unit.ram_inst.bram[j]);
        end
        $fclose(fd);

        $display("TONG THOI GIAN CHAY: %f s", $realtime / 1000000000.0);
        $display("Da ghi ket qua ra file hex thanh cong!");
        $display("==================================================");
        #100 $stop;
    end
endmodule