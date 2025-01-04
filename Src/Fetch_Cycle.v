//  `include "PC.v"
//  `include "Mux.v"
//  `include "Adder.v"
//  `include "Instruction_Mem.v"

module Fetch_Cycle (input clk,
                    input rst,
                    input clr,
                    input en,
                    input PCWrite,
                    input PCSrcE,
                    input PCJalSrcE,
                    input [31:0] PCTargetE,
                    input [31:0] ALUOutE,
                    output reg [31:0] PCD,
                    output reg [31:0] InstrD,
                    output reg [31:0] PCPlus4D);
    
    wire [31:0] PC_next, PCF, InstrF, PCPlus4F, BranJumpTargetE;
    
    PC_module PC_module (
    .clk(clk),
    .rst(rst),
    .en(PCWrite),
    .PC_next(PC_next),
    .PC(PCF)
    );
    
    Adder PC_Adder (
    .A(PCF),
    .B(32'd4),
    .C(PCPlus4F)
    );
    
    Mux Mux_Branch_Jump (
    .a(PCTargetE),          
    .b(ALUOutE),            
    .s(PCJalSrcE),       
    .c(BranJumpTargetE)     
    );
    
    
    Mux Mux_PC(
    .a(PCPlus4F),
    .b(BranJumpTargetE),
    .s(PCSrcE),
    .c(PC_next)
    );
    
    Instr_Mem Instr_Mem (
    .rst(rst),
    .Instr_Addr(PCF),
    .RD(InstrF)
    );
    
    
    
    always @(posedge clk, negedge rst) begin
        if (!rst) begin
            PCD      <= 32'h00000000;
            InstrD   <= 32'h00000000;
            PCPlus4D <= 32'h00000000;
        end
        else if (en) begin
            if (clr) begin
                PCD      <= 32'h00000000;
                InstrD   <= 32'h00000000;
                PCPlus4D <= 32'h00000000;
            end
            else begin
                PCD      <= PCF;
                InstrD   <= InstrF;
                PCPlus4D <= PCPlus4F;
            end
        end
    end
endmodule
