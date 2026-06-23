module tb;
    reg CLK, RESET, WriteEn, ReadEn;
    reg [4:0] ReadAddress1, ReadAddress2, WriteAddress;
    reg [31:0] WriteData;
    wire [31:0] ReadData1, ReadData2;

    register_files uut (
        .CLK(CLK),
        .RST(RESET),
        .WriteEn(WriteEn),
        .ReadEn(ReadEn),
        .RA1(ReadAddress1),
        .RA2(ReadAddress2),
        .WA(WriteAddress),
        .WD(WriteData),
        .RD1(ReadData1),
        .RD2(ReadData2)
    );

    task write_value;
        input [4:0] address;
        input [31:0] value;
        begin
            @(negedge CLK);
            WriteAddress = address;
            WriteData = value;
            WriteEn = 1'b1;

            @(posedge CLK);
            #1; 
            WriteEn = 1'b0; 
        end
    endtask

    task read_value;
        input [4:0] address1;
        input [4:0] address2;
        begin
            @(negedge CLK);
            ReadAddress1 = address1;
            ReadAddress2 = address2;
            ReadEn = 1'b1;

            @(posedge CLK);
            #1;
            ReadEn = 1'b0;
        end
    endtask

    always #5 CLK = ~CLK;
        
    initial begin
        $monitor(
        "Time = %0t | RESET = %b | WE = %b | WA = %0d | WD = %0d | RE = %b | R[%0d] = %0d | R[%0d] = %0d",
        $time, RESET, WriteEn, WriteAddress, WriteData, ReadEn, ReadAddress1, ReadData1, ReadAddress2, ReadData2
        );
        CLK = 1'b0;
        RESET  = 1'b0;
        WriteEn = 1'b0;
        ReadEn  = 1'b0;
        ReadAddress1 = 5'b0;
        ReadAddress2 = 5'b0;
        WriteAddress = 5'b0;
        WriteData    = 32'b0;

        #10 RESET = 1'b1;
        @(posedge CLK);
        #1;
        RESET = 1'b0;

        write_value(5'd1, 32'd1230);
        write_value(5'd2, 32'd44);
        write_value(5'd3, 32'd2321);
        write_value(5'd4, 32'd5678);

        read_value(5'd1, 5'd2);
        read_value(5'd3, 5'd4);

        write_value(5'd2, 32'd10000);
        write_value(5'd3, 32'd564);
        write_value(5'd20, 32'd22);
        write_value(5'd10, 32'd3111);

        read_value(5'd2, 5'd3);
        read_value(5'd10, 5'd20);

        #100 $finish;
    end
endmodule