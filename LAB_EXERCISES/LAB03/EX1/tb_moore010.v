`timescale 1ns/1ps
module tb;
    reg CLK, RST, DataIn;
    wire Out;
    
    moore010 UUT(
        .CLK(CLK),
        .RST(RST),
        .DataIn(DataIn),
        .Out(Out)
    );
    
    reg input_data[0:15];
    integer i;

    task run;
        input [255:0] file_name;
        input integer data_length;

        begin
            $display("=====================");
            $display("FILE: %0s", file_name);
            $display("=====================");

            $readmemh(file_name, input_data, 0, data_length - 1);

            RST = 1'b1;
            DataIn = 1'b0;

            @(posedge CLK);
            #1;
            RST = 1'b0;

            for (i = 0; i < data_length; i = i + 1) begin
                @(negedge CLK);
                DataIn = input_data[i];

                @(posedge CLK);
                #1;

                $display(
                    "Index = %0d  | DataIn = %b | State = %b | Out = %b",
                    i, DataIn, UUT.State, Out
                );
            end
            DataIn = 1'b0;

            $display("\nKET THUC KIEM TRA FILE: %0s", file_name);
        end
    endtask

    always #5 CLK = ~CLK;
     
    initial begin
        CLK = 1'b0;
        RST = 1'b0;
        DataIn = 1'b0;

        run("input1.hex", 16);
        run("input2.hex", 16);
        run("input3.hex", 16);

        #10;
        $finish;
    end

endmodule