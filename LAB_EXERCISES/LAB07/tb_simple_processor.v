`timescale 1ns/1ps
module tb;
    reg CLK;
    reg [31:0] Inst;
    
    Simple_Processor dut (
        .CLK(CLK),
        .Inst(Inst)
    );
    
    wire [5:0] wave_Opcode     = Inst[31:26];
    wire       wave_RegDst     = dut.control_block.RegDst;
    wire       wave_MemRead    = dut.control_block.MemRead;
    wire       wave_MemWrite   = dut.control_block.MemWrite;
    wire       wave_MemToReg   = dut.control_block.MemToReg;
    wire [1:0] wave_ALUOp      = dut.control_block.ALUOp;
    wire       wave_ALUSrc     = dut.control_block.ALUSrc;
    wire       wave_RegWrite   = dut.control_block.RegWrite;
    wire [3:0] wave_ALUControl = dut.control_block.ALUControl;
    wire [31:0] wave_ALUResult = dut.datapath_block.ALU_Result;
    always #5 CLK = ~CLK;
    
    initial begin
        CLK = 0;
        Inst = 32'b0;
        
        dut.datapath_block.reg_file_inst.registers[0] = 32'd0;
        dut.datapath_block.reg_file_inst.registers[2] = 32'd2; 
        dut.datapath_block.reg_file_inst.registers[3] = 32'd3;
        
        dut.datapath_block.data_memory_inst.memory[4] = 32'd888; 
        dut.datapath_block.data_memory_inst.memory[5] = 32'd999; 
        
        $display("===================================================================================================");
        $display("Time | $1(rd) | $2(rs) | $3(rt) | $4(rd) | $5(rd) | SRAM[4] | SRAM[5] | SRAM[7] |");
        $display("===================================================================================================");
        
        $monitor("%4t | %6d | %6d | %6d | %6d | %6d | %7d | %7d | %7d | \n", 
                 $time, 
                 dut.datapath_block.reg_file_inst.registers[1], 
                 dut.datapath_block.reg_file_inst.registers[2], 
                 dut.datapath_block.reg_file_inst.registers[3], 
                 dut.datapath_block.reg_file_inst.registers[4],
                 dut.datapath_block.reg_file_inst.registers[5],
                 dut.datapath_block.data_memory_inst.memory[4],
                 dut.datapath_block.data_memory_inst.memory[5],
                 dut.datapath_block.data_memory_inst.memory[7]
        );
                 
        #10;
        $display("add $1, $2, $3 ($1 = 2 + 3 = 5)");
        Inst = 32'h0443_0820; 
        
        #10; 
        $display("lw $4, 3($2) (Doc SRAM[2+3] bo vao $4. $4 = 999)");
        Inst = 32'h1044_0003;
        
        #10;
        $display("sw $4, 2($2) (Ghi $4=999 de vao SRAM[2+2]. SRAM[4] doi thanh 999)");
        Inst = 32'h0844_0002;
        
        #10;
        $display("add $5, $1, $4 ($5 = 5 + 999 = 1004)");
        Inst = 32'h0424_2800;
        
        #10;
        $display("sw $5, 7($0) (Ghi $5=1004 vao SRAM[0+7]. SRAM[7] doi thanh 1004)");
        Inst = 32'h0805_0007;

        #10;
        $display("==================== KET THUC MO PHONG ====================");
        #20;
        $stop;
    end
endmodule