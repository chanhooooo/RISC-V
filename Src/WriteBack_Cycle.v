// `include "Mux.v"

module WriteBack_Cycle (input clk,
                        input rst,
                        input [1:0] Mem_to_RegW,
                        input [31:0] ALUOutW,
                        input [31:0] ReadDataW,
                        input [31:0] PCPlus4W,
                        output [31:0] ResultW);
    
	Mux_3_by_1 result_mux (
    .a(ALUOutW),
    .b(ReadDataW),
    .c(PCPlus4W),
    .s(Mem_to_RegW),
    .d(ResultW)
    );
endmodule
