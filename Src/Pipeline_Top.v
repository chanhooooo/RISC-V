`include "PC.v"
`include "Instruction_Mem.v"
`include "control_unit_top.v"
`include "Register_Files.v"
`include "Sign_Extend.v"
`include "ALU.v"
`include "Mux.v"
`include "Adder.v"
`include "Data_Mem.v"
`include "Fetch_Cycle.v"
`include "Decode_Cycle.v"
`include "Execute_Cycle.v"
`include "Memory_Cycle.v"
`include "WriteBack_Cycle.v"
`include "Hazard_Unit.v"
`include "Hazard_Detection_Unit.v"

module Pipeline_Top (input clk,
                     input rst);
    
    wire [31:0] InstrD, PCD, PCPlus4D, PCE, Imm_Ext_E, PCPlus4E, PCTargetE, RD1E, RD2E;
    wire [31:0] ALUOutM, PCPlus4M, WriteDataM, ALUOutW, ReadDataW, PCPlus4W, ResultW, ALUOutE;
    wire [6:0] opE;
    wire [4:0] RDE, RDM, RDW, Rs1E, Rs2E, Rs1D, Rs2D;
    wire [3:0] ALU_ControlE;
    wire [2:0] funct3E;
    wire [1:0] Mem_to_RegE, Mem_to_RegM, Mem_to_RegW, ForwardAE, ForwardBE;
    wire RegWriteE, MemReadE, MemWriteE, BranchE, ALUSrcE, PCSrcE, RegWriteM, MemReadM, MemWriteM, RegWriteW, FlushD, stallF,stallD, FlushE, PCJalSrcE, JumpE;
    
    Fetch_Cycle Fetch_Cycle (
    .clk(clk),
    .rst(rst),
    .clr(FlushD),
    .en(!stallD),
    .PCWrite(!stallF),
    .PCJalSrcE(PCJalSrcE),
    .PCSrcE(PCSrcE),
    .PCTargetE(PCTargetE),
    .ALUOutE(ALUOutE),
    .PCD(PCD),
    .InstrD(InstrD),
    .PCPlus4D(PCPlus4D)
    );
    
    Decode_Cycle Decode_Cycle (
    .clk(clk),
    .rst(rst),
    .clr(FlushE),
    .RDW(RDW),
    .PCD(PCD),
    .InstrD(InstrD),
    .PCPlus4D(PCPlus4D),
    .RegWriteW(RegWriteW),
    .ResultW(ResultW),
    .RegWriteE(RegWriteE),
    .Mem_to_RegE(Mem_to_RegE),
    .MemReadE(MemReadE),
    .MemWriteE(MemWriteE),
    .BranchE(BranchE),
    .JumpE(JumpE),
    .ALUSrcE(ALUSrcE),
    .ALU_ControlE(ALU_ControlE),
    .RD1E(RD1E),
    .RD2E(RD2E),
    .Rs1E(Rs1E),
    .Rs2E(Rs2E),
    .PCE(PCE),
    .Imm_Ext_E(Imm_Ext_E),
    .PCPlus4E(PCPlus4E),
    .RDE(RDE),
    .Rs1D(Rs1D),
    .Rs2D(Rs2D),
    .funct3E(funct3E),  
    .opE(opE)
    );
    
    Execute_Cycle Execute_Cycle (
    .clk(clk),
    .rst(rst),
    .RegWriteE(RegWriteE),
    .MemReadE(MemReadE),
    .MemWriteE(MemWriteE),
    .BranchE(BranchE),
    .JumpE(JumpE),
    .ALUSrcE(ALUSrcE),
    .Mem_to_RegE(Mem_to_RegE),
    .funct3E(funct3E),   
    .opE(opE),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE),
    .ALU_ControlE(ALU_ControlE),
    .RD1E(RD1E),
    .RD2E(RD2E),
    .PCE(PCE),
    .Imm_Ext_E(Imm_Ext_E),
    .PCPlus4E(PCPlus4E),
    .ResultW(ResultW),
    .RDE(RDE),
    .PCSrcE(PCSrcE),
    .PCJalSrcE(PCJalSrcE),
    .PCTargetE(PCTargetE),
    .ALUOutE(ALUOutE),
    .RegWriteM(RegWriteM),
    .MemReadM(MemReadM),
    .MemWriteM(MemWriteM),
    .Mem_to_RegM(Mem_to_RegM),
    .RDM(RDM),
    .ALUOutM(ALUOutM),
    .PCPlus4M(PCPlus4M),
    .WriteDataM(WriteDataM)
    );
    
    Memory_Cylce Memory_Cylce (
    .clk(clk),
    .rst(rst),
    .RegWriteM(RegWriteM),
    .MemReadM(MemReadM),
    .MemWriteM(MemWriteM),
    .Mem_to_RegM(Mem_to_RegM),
    .ALUOutM(ALUOutM),
    .PCPlus4M(PCPlus4M),
    .RDM(RDM),
    .WriteDataM(WriteDataM),
    .RegWriteW(RegWriteW),
    .Mem_to_RegW(Mem_to_RegW),
    .RDW(RDW),
    .ALUOutW(ALUOutW),
    .ReadDataW(ReadDataW),
    .PCPlus4W(PCPlus4W)
    );
    
    WriteBack_Cycle WriteBack_Cycle (
    .clk(clk),
    .rst(rst),
    .Mem_to_RegW(Mem_to_RegW),
    .ALUOutW(ALUOutW),
    .ReadDataW(ReadDataW),
    .PCPlus4W(PCPlus4W),
    .ResultW(ResultW)
    );
    
    Hazard_Unit Hazard_Unit (
    .rst(rst),
    .RegWriteM(RegWriteM),
    .RegWriteW(RegWriteW),
    .Rs1E(Rs1E),
    .Rs2E(Rs2E),
    .RDM(RDM),
    .RDW(RDW),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE)
    );
    
    Hazard_Detection_Unit Hazard_Detection_Unit (
    .MemReadE(MemReadE),
    .PCSrcE(PCSrcE),
    .Rs1D(Rs1D),
    .Rs2D(Rs2D),
    .RDE(RDE),
    .stallF(stallF),
    .stallD(stallD),
    .FlushE(FlushE),
    .FlushD(FlushD)
    );
    
endmodule
