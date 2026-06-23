`timescale 1ns/1ps
module tb;

    reg CLK;
    reg [31:0] Inst;

    reg RegDst;
    reg RegWrite;
    reg ALUSrc;
    reg [2:0] ALUControl;
    reg MemWrite;
    reg MemRead;
    reg MemToReg;

    Datapath uut (
        .CLK        (CLK),
        .Inst       (Inst),
        .RegDst     (RegDst),
        .RegWrite   (RegWrite),
        .ALUSrc     (ALUSrc),
        .ALUControl (ALUControl),
        .MemWrite   (MemWrite),
        .MemRead    (MemRead),
        .MemToReg   (MemToReg)
    );

    always #5 CLK = ~CLK;

    //====================================================
    // ADD rd, rs, rt
    //
    // R[rd] = R[rs] + R[rt]
    //====================================================
    task execute_add;
        input [4:0] rd;
        input [4:0] rs;
        input [4:0] rt;

        begin
            @(negedge CLK);

            Inst = {
                6'b000000, // opcode R-type
                rs,        // Inst[25:21]
                rt,        // Inst[20:16]
                rd,        // Inst[15:11]
                5'b00000,  // shamt
                6'b100000  // funct ADD
            };

            RegDst     = 1'b1;
            RegWrite   = 1'b1;
            ALUSrc     = 1'b0;
            ALUControl = 3'b101;
            MemWrite   = 1'b0;
            MemRead    = 1'b0;
            MemToReg   = 1'b0;

            @(posedge CLK);
            #1;

            RegWrite = 1'b0;
        end
    endtask

    task execute_lw;
        input [4:0] rt;
        input [15:0] immediate;
        input [4:0] rs;

        begin
            @(negedge CLK);

            Inst = {
                6'b100011, // opcode LW
                rs,
                rt,
                immediate
            };

            RegDst     = 1'b0;
            RegWrite   = 1'b1;
            ALUSrc     = 1'b1;
            ALUControl = 3'b101;
            MemWrite   = 1'b0;
            MemRead    = 1'b1;
            MemToReg   = 1'b1;

            @(posedge CLK);
            #1;

            RegWrite = 1'b0;
            MemRead  = 1'b0;
        end
    endtask

    //====================================================
    // SW rt, immediate(rs)
    //
    // Memory[R[rs] + immediate] = R[rt]
    //====================================================
    task execute_sw;
        input [4:0] rt;
        input [15:0] immediate;
        input [4:0] rs;

        begin
            @(negedge CLK);

            Inst = {
                6'b101011, // opcode SW
                rs,
                rt,
                immediate
            };

            RegDst     = 1'b0;
            RegWrite   = 1'b0;
            ALUSrc     = 1'b1;
            ALUControl = 3'b101;
            MemWrite   = 1'b1;
            MemRead    = 1'b0;
            MemToReg   = 1'b0;

            @(posedge CLK);
            #1;

            MemWrite = 1'b0;
        end
    endtask


    initial begin
        CLK = 1'b0;
        Inst = 32'b0;

        RegDst     = 1'b0;
        RegWrite   = 1'b0;
        ALUSrc     = 1'b0;
        ALUControl = 3'b000;
        MemWrite   = 1'b0;
        MemRead    = 1'b0;
        MemToReg   = 1'b0;

        uut.reg_file_inst.registers[1] = 32'd0;
        uut.reg_file_inst.registers[2] = 32'd2;
        uut.reg_file_inst.registers[3] = 32'd3;
        uut.reg_file_inst.registers[4] = 32'd0;
        uut.reg_file_inst.registers[5] = 32'd0;

        uut.data_memory_inst.memory[4] = 32'd888;
        uut.data_memory_inst.memory[5] = 32'd999;
        uut.data_memory_inst.memory[7] = 32'd0;

        $display("");
        $display("==========================================================================");
        $display(" Time |  $1  |  $2  |  $3  |  $4  |  $5  | SRAM[4] | SRAM[5] | SRAM[7]");
        $display("==========================================================================");

        $monitor(
            "%5t | %4d | %4d | %4d | %4d | %4d | %7d | %7d | %7d",
            $time,
            uut.reg_file_inst.registers[1],
            uut.reg_file_inst.registers[2],
            uut.reg_file_inst.registers[3],
            uut.reg_file_inst.registers[4],
            uut.reg_file_inst.registers[5],
            uut.data_memory_inst.memory[4],
            uut.data_memory_inst.memory[5],
            uut.data_memory_inst.memory[7]
        );

        #1;
        // ADD $1, $2, $3
        // $1 = $2 + $3 = 2 + 3 = 5
        execute_add(5'd1, 5'd2, 5'd3);
        // LW $4, 3($2)
        // Địa chỉ = $2 + 3 = 2 + 3 = 5
        // $4 = SRAM[5] = 999
        execute_lw(5'd4, 16'd3, 5'd2);
        // SW $4, 2($2)
        // Địa chỉ = $2 + 2 = 2 + 2 = 4
        // SRAM[4] = $4 = 999
        execute_sw(5'd4, 16'd2, 5'd2);
        #100 $finish;
    end
endmodule