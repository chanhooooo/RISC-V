module Instr_Mem (input rst,
                  input [31:0] Instr_Addr,
                  output [31:0] RD);
    
    reg [31:0] mem [0:1023];
    
    assign RD = (~rst)?31'b0:mem[Instr_Addr[31:2]];

    initial begin
        $readmemh("memfile.hex",mem);
    end
    
endmodule
