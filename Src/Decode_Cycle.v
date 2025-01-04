//  `include "Control_Unit_Top.v"
//  `include "Register_Files.v"
//  `include "Sign_Extend.v"

module Decode_Cycle (input clk,
                     input rst,
                     input clr,
                     input [4:0] RDW,
                     input [31:0] PCD,
                     input [31:0] InstrD,
                     input [31:0] PCPlus4D,
                     input RegWriteW,
                     input [31:0] ResultW,
                     output reg RegWriteE,
                     output reg [1:0] Mem_to_RegE,
                     output reg MemReadE,
                     output reg MemWriteE,
                     output reg BranchE,
                     output reg JumpE,
                     output reg ALUSrcE,
                     output reg [2:0] funct3E,
                     output reg [3:0] ALU_ControlE,
                     output reg [4:0] Rs1E,
                     output reg [4:0] Rs2E,
                     output reg [6:0] opE,
                     output reg [31:0] RD1E,
                     output reg [31:0] RD2E,
                     output reg [31:0] PCE,
                     output reg [31:0] Imm_Ext_E,
                     output reg [31:0] PCPlus4E,
                     output reg [4:0] RDE,
                     output [4:0] Rs1D,
                     output [4:0] Rs2D);
    
    wire [31:0] RD1D, RD2D, Imm_Ext_D;
    wire [4:0] RDD;
    wire [3:0] ALU_ControlD;
    wire [2:0] ImmSrcD;
    wire [1:0] Mem_to_RegD;
    wire ALUSrcD, RegWriteD, MemReadD, MemWriteD, BranchD, JumpD;
    
    assign RDD  = InstrD[11:7];
    assign Rs1D = InstrD[19:15];
    assign Rs2D = InstrD[24:20];
    
    control_unit_top control_unit_top (
    .op(InstrD[6:0]),
    .funct3(InstrD[14:12]),
    .funct7(InstrD[31:25]),
    .ALUSrc(ALUSrcD),
    .Mem_to_Reg(Mem_to_RegD),
    .RegWrite(RegWriteD),
    .MemRead(MemReadD),
    .MemWrite(MemWriteD),
    .Branch(BranchD),
    .Jump(JumpD),
    .ImmSrc(ImmSrcD),
    .ALU_Control(ALU_ControlD)
    );
    
    Register_Files Register_Files (
    .clk(clk),
    .rst(rst),
    .RegWrite(RegWriteW),
    .Addr1(InstrD[19:15]),
    .Addr2(InstrD[24:20]),
    .Addr3(RDW),
    .WD3(ResultW),
    .RD1(RD1D),
    .RD2(RD2D)
    );
    
    Sign_Extend Sign_Extend (
    .in(InstrD),
    .ImmSrc(ImmSrcD),
    .Imm_Ext(Imm_Ext_D)
    );
    
    always @(posedge clk, negedge rst) begin
        if (!rst) begin
            RegWriteE    <= 1'b0;
            MemReadE     <= 1'b0;
            MemWriteE    <= 1'b0;
            BranchE      <= 1'b0;
            JumpE        <= 1'b0;
            ALUSrcE      <= 1'b0;
            funct3E      <= 3'b000;
            Mem_to_RegE  <= 2'b00;
            ALU_ControlE <= 4'h0;
            RD1E         <= 32'h00000000;
            RD2E         <= 32'h00000000;
            Rs1E         <= 5'h00;
            Rs2E         <= 5'h00;
            opE          <= 7'b0000000;
            PCE          <= 32'h00000000;
            Imm_Ext_E    <= 32'h00000000;
            PCPlus4E     <= 32'h00000000;
            RDE          <= 5'h00;
        end
        else if (clr) begin
            RegWriteE    <= 1'b0;
            MemReadE     <= 1'b0;
            MemWriteE    <= 1'b0;
            BranchE      <= 1'b0;
            JumpE        <= 1'b0;
            ALUSrcE      <= 1'b0;
            Mem_to_RegE  <= 2'b00;
            funct3E      <= 3'b000;
            ALU_ControlE <= 4'h0;
            RD1E         <= 32'h00000000;
            RD2E         <= 32'h00000000;
            Rs1E         <= 5'h00;
            Rs2E         <= 5'h00;
            opE          <= 7'b0000000;
            PCE          <= 32'h00000000;
            Imm_Ext_E    <= 32'h00000000;
            PCPlus4E     <= 32'h00000000;
            RDE          <= 5'h00;
        end
        else begin
            RegWriteE    <= RegWriteD;
            MemReadE     <= MemReadD;
            MemWriteE    <= MemWriteD;
            BranchE      <= BranchD;
            JumpE        <= JumpD;
            ALUSrcE      <= ALUSrcD;
            Mem_to_RegE  <= Mem_to_RegD;
            funct3E      <= InstrD[14:12];
            ALU_ControlE <= ALU_ControlD;
            RD1E         <= RD1D;
            RD2E         <= RD2D;
            Rs1E         <= Rs1D;
            Rs2E         <= Rs2D;
            opE          <= InstrD[6:0];
            PCE          <= PCD;
            Imm_Ext_E    <= Imm_Ext_D;
            PCPlus4E     <= PCPlus4D;
            RDE          <= RDD;
        end
    end
endmodule
