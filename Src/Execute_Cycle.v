// `include "ALU.v"
// `include "Mux.v"
// `include "Adder.v"

module Execute_Cycle (input clk,
                      input rst,
                      input RegWriteE,
                      input MemReadE,
                      input MemWriteE,
                      input BranchE,
                      input JumpE,
                      input ALUSrcE,
                      input [1:0] Mem_to_RegE,
                      input [1:0] ForwardAE,
                      input [1:0] ForwardBE,
                      input [2:0] funct3E,
                      input [3:0] ALU_ControlE,
                      input [6:0] opE,
                      input [31:0] RD1E,
                      input [31:0] RD2E,
                      input [31:0] PCE,
                      input [31:0] Imm_Ext_E,
                      input [31:0] PCPlus4E,
                      input [31:0] ResultW,
                      input [4:0] RDE,
                      output PCSrcE,
                      output PCJalSrcE,
					  output [31:0] PCTargetE,
                      output [31:0] ALUOutE,
                      output reg RegWriteM,
                      output reg MemReadM,
                      output reg MemWriteM,
                      output reg [1:0] Mem_to_RegM,
                      output reg [4:0] RDM,
                      output reg [31:0] ALUOutM,
                      output reg [31:0] PCPlus4M,
                      output reg [31:0] WriteDataM);
    
    wire ZeroE, SignE, ZeroOp, SignOp, BranchOp;
    wire [31:0] SrcBE, WriteDataE, SrcB_interim, SrcAE;
    
    assign WriteDataE = SrcB_interim;



    assign ZeroOp = ZeroE ^ funct3E[0];
    assign SignOp = SignE;
    assign BranchOp = (funct3E == 3'b000) ? ZeroE :  // beq
                      (funct3E == 3'b001) ? ~ZeroE : // bne
                      (funct3E == 3'b100) ? SignOp : // blt
                      (funct3E == 3'b101) ? (~SignOp | ZeroE) : // bge
                      1'b0; // 기본값
    assign PCSrcE = (BranchE & BranchOp) | JumpE;
    assign PCJalSrcE = (opE == 7'b1100111) ? 1 : 0;

    ALU ALU (
    .ALU_Control(ALU_ControlE),
    .SrcA(SrcAE),
    .SrcB(SrcBE),
    .Zero(ZeroE),
    .Sign(SignE),
    .ALUOut(ALUOutE)
    );
    
    Mux_3_by_1 SrcA_Mux (
    .a(RD1E),
    .b(ResultW),
    .c(ALUOutM),
    .s(ForwardAE),
    .d(SrcAE)
    );

    Mux_3_by_1 SrcB_Mux (
    .a(RD2E),
    .b(ResultW),
    .c(ALUOutM),
    .s(ForwardBE),
    .d(SrcB_interim)
    );

    Mux alu_src_mux (
    .a(SrcB_interim),
    .b(Imm_Ext_E),
    .s(ALUSrcE),
    .c(SrcBE)
    );
    
    Adder PC_Adder (
    .A(PCE),
    .B(Imm_Ext_E),
    .C(PCTargetE)
    );
    
    always @(posedge clk, negedge rst) begin
        if (!rst) begin
            RegWriteM   <= 1'b0;
            MemReadM    <= 1'b0;
            MemWriteM   <= 1'b0;
			Mem_to_RegM <= 2'b00;
            RDM         <= 5'h00;
            ALUOutM     <= 32'h00000000;
            PCPlus4M    <= 32'h00000000;
            WriteDataM  <= 32'h00000000;
        end
        else begin
            RegWriteM   <= RegWriteE;
            MemReadM    <= MemReadE;
            Mem_to_RegM <= Mem_to_RegE;
            MemWriteM   <= MemWriteE;
            ALUOutM     <= ALUOutE;
            PCPlus4M    <= PCPlus4E;
            RDM         <= RDE;
            WriteDataM  <= WriteDataE;
        end
    end
endmodule
