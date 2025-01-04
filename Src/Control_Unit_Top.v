`include "main_dec.v"
`include "ALU_dec.v"

module control_unit_top (input [6:0] op,
                         input [2:0] funct3,
                         input [6:0] funct7,
                         output ALUSrc,
                         output RegWrite,
                         output MemRead,
                         output MemWrite,
                         output Branch,
                         output Jump,
                         output [1:0] Mem_to_Reg,
						 output [2:0] ImmSrc,
						 output [3:0] ALU_Control);
    
    wire [1:0] ALUOp;
    
    main_dec main_dec (
    .op(op),
    .ALUSrc(ALUSrc),
    .Mem_to_Reg(Mem_to_Reg),
    .RegWrite(RegWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .Branch(Branch),
    .Jump(Jump),
	.ImmSrc(ImmSrc),
    .ALUOp(ALUOp)
    );
    
    ALU_dec ALU_dec (
    .ALUOp(ALUOp),
    .funct3(funct3),
    .funct7(funct7),
    .ALU_Control(ALU_Control)
    );
    
endmodule
