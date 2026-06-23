`timescale 1ns/1ps
module tb;
    reg CLK, WriteEn, ReadEn, RST;
    reg [9:0] Address;
    reg [31:0] WriteData;
    wire [31:0] ReadData;

    SRAM uut (
        .CLK(CLK),
        .WriteEn(WriteEn),
        .ReadEn(ReadEn),
        .RST(RST),
        .Address(Address),
        .WriteData(WriteData),
        .ReadData(ReadData)
    );

    task write_value;
        input [9:0] addr;
        input [31:0] data;
        begin
            @(negedge CLK);
            Address = addr;
            WriteData = data;
            WriteEn = 1'b1;

            @(posedge CLK);
            #1;
            WriteEn = 1'b0;
        end
    endtask

    task read_value;
        input [9:0] addr;
        begin
            @(negedge CLK);
            Address = addr;
            ReadEn = 1'b1;

            @(posedge CLK);
            #1;
            ReadEn = 1'b0;
        end
    endtask

    always #5 CLK = ~CLK;
    initial begin
        $monitor(
            "Time = %0t | RST = %b | WE = %b | RE = %b | Addr = %0d | WD = %0d | RD = %0d",
            $time, RST, WriteEn, ReadEn, Address, WriteData, ReadData
        );
        CLK = 1'b0;
        RST = 1'b0;
        WriteEn = 1'b0;
        ReadEn = 1'b0;
        WriteData = 32'b0;
        Address = 10'b0;

        #10 RST = 1'b1;
        @(posedge CLK);
        #1;
        RST = 1'b0;

        write_value(10'd5, 32'd8911);
        read_value(10'd5);
        write_value(10'd10, 32'd22222);
        read_value(10'd10);
        write_value(10'd5, 32'd111);
        write_value(10'd19, 32'd100);
        write_value(10'd1, 32'd1342);
        write_value(10'd10, 32'd99);
        read_value(10'd5);
        read_value(10'd19);
        read_value(10'd1);
        read_value(10'd10);
        
        #100 $finish;
    end
endmodule
