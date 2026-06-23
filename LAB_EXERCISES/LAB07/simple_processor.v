module Simple_Processor(
    input CLK,
    input [31:0] Inst
);
    wire RegDst;
    wire MemRead;
    wire MemWrite;
    wire MemToReg;
    wire [1:0] ALUOp;
    wire ALUSrc;
    wire RegWrite;
    wire [3:0] ALUControl;

    Control_Unit control_block (
        .Opcode(Inst[31:26]),
        .RegDst(RegDst),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemToReg(MemToReg),
        .ALUOp(ALUOp),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .ALUControl(ALUControl)
    );

    Datapath datapath_block (
        .CLK(CLK),
        .Inst(Inst),
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .ALUControl(ALUControl[3:0]),    
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .MemToReg(MemToReg)
    );

endmodule