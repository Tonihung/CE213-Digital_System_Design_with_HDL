`timescale 1ns/1ps
module tb;
    reg CLK;
    reg [2:0] PRE;
    reg [2:0] CLR;
    wire [2:0] Q;

    counter uut (
        .CLK(CLK),
        .PRESET(PRE),
        .CLEAR(CLR),
        .count(Q)
    );

    task load_value;
        input [2:0] value;
        begin
            PRE = value;
            CLR = ~value;

            #5;

            PRE = 3'b000;
            CLR = 3'b000;
        end
    endtask
    
    always #5 CLK = ~CLK;
    
    initial begin
        CLK = 1'b0;
        PRE = 3'b000;
        CLR = 3'b000;

        $monitor(
            "Time = %0t | CLK = %b | PRE = %b | CLR = %b | Q = %b",
            $time, CLK, PRE, CLR, Q
        );

        #2;
        load_value(3'b101);
        repeat (6) begin
            @(posedge CLK);
            #1;
        end

        load_value(3'b001);
        repeat (6) begin
            @(posedge CLK);
            #1;
        end

        load_value(3'b010);
        repeat (8) begin
            @(posedge CLK);
            #1;
        end

        load_value(3'b011);
        repeat (6) begin
            @(posedge CLK);
            #1;
        end

        $finish;
    end
endmodule
