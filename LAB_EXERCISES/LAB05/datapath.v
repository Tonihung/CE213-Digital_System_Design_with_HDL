module Datapath(
    input CLK,
    input [31:0] Inst,
    input RegDst,
    input RegWrite,
    input ALUSrc,
    input [2:0] ALUControl,
    input MemWrite,
    input MemRead,
    input MemToReg
);
    wire [4:0]  WriteReg_Addr;       
    wire [31:0] ReadData1, ReadData2;  
    wire [31:0] SignExt_Out;
    wire [31:0] ALU_In_B;
    wire [31:0] ALU_Result;
    wire ALU_Overflow;
    wire [31:0] Mem_ReadData;
    wire [31:0] Reg_WriteData;

    mux #(
        .WIDTH(5)
    ) mux_reg_dst (
        .A   (Inst[20:16]),
        .B   (Inst[15:11]),
        .Sel (RegDst),
        .Y   (WriteReg_Addr)
    );

    registers reg_file_inst (
        .CLK(CLK),
        .WriteEn(RegWrite),
        .RA1(Inst[25:21]),
        .RA2(Inst[20:16]),
        .WA(WriteReg_Addr),
        .WD(Reg_WriteData),
        .RD1(ReadData1),
        .RD2(ReadData2)
    );

    SignExtend sign_ext_inst (
        .In(Inst[15:0]),
        .Out(SignExt_Out)
    );

    mux  #(
        .WIDTH(32)
    ) mux_alu_src (
        .A(ReadData2),
        .B(SignExt_Out),
        .Sel(ALUSrc),
        .Y(ALU_In_B)
    );

    ALU alu_inst (
        .A(ReadData1),
        .B(ALU_In_B),
        .M(ALUControl[2]),
        .S1(ALUControl[1]),
        .S0(ALUControl[0]),
        .ALUResult(ALU_Result),
        .OF(ALU_Overflow)
    );

    DataMemory data_memory_inst (
        .CLK(CLK),
        .WriteEn(MemWrite),
        .ReadEn(MemRead),
        .Address(ALU_Result[9:0]),
        .WriteData(ReadData2),     
        .ReadData(Mem_ReadData)
    );

    mux  #(
        .WIDTH(32)
    ) mux_mem_to_reg (
        .A(ALU_Result),
        .B(Mem_ReadData),
        .Sel(MemToReg),
        .Y(Reg_WriteData)
    );
endmodule