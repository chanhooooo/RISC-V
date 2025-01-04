module Data_Mem (input clk,
                 input rst,
                 input MemWrite,
                 input MemRead,
                 input [31:0] Data_Addr,
                 input [31:0] WD,
                 output [31:0] RD);
    
  reg [31:0] Mem [1023:0];
    
  assign RD = (~rst) ? 32'b0 : (MemRead ? Mem[Data_Addr] : 32'b0);
    
  always @(posedge clk) begin
    if (MemWrite)
      Mem[Data_Addr] <= WD;
  end
        
  initial begin
    Mem[0]     = 32'h00000000;
    Mem[1]     = 32'h00000002;
    Mem[9]     = 32'h00000004;
    // Mem[40] = 32'h00000002;
  end
        
endmodule
