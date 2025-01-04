// `include "Data_Mem.v"

module Memory_Cylce (input clk,
                     input rst,
                     input RegWriteM,
                     input MemReadM,
                     input MemWriteM,
                     input [1:0] Mem_to_RegM,
                     input [31:0] ALUOutM,
                     input [31:0] PCPlus4M,
                     input [4:0] RDM,
                     input [31:0] WriteDataM,
                     output reg RegWriteW,
                     output reg [1:0] Mem_to_RegW,
                     output reg [4:0] RDW,
                     output reg [31:0] ALUOutW,
                     output reg [31:0] ReadDataW,
                     output reg [31:0] PCPlus4W);
    
    wire [31:0] ReadDataM;
    
    Data_Mem Data_Mem (
    .clk(clk),
    .rst(rst),
    .MemWrite(MemWriteM),
    .MemRead(MemReadM),
    .Data_Addr(ALUOutM),
    .WD(WriteDataM),
    .RD(ReadDataM)
    );
    
    always @(posedge clk, negedge rst) begin
        if (!rst) begin
            RegWriteW   <= 1'b0;
            Mem_to_RegW <= 2'b00;
            RDW         <= 5'h00;
            ALUOutW     <= 32'h00000000;
            ReadDataW   <= 32'h00000000;
            PCPlus4W    <= 32'h00000000;
        end
        else begin
            RegWriteW   <= RegWriteM;
            Mem_to_RegW <= Mem_to_RegM;
            RDW         <= RDM;
            ALUOutW     <= ALUOutM;
            ReadDataW   <= ReadDataM;
            PCPlus4W    <= PCPlus4M;
        end
    end
endmodule
