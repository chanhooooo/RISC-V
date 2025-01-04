module PC_module (input clk,
                  input rst,
                  input en,
                  input [31:0] PC_next,
                  output reg [31:0] PC);
    
    always @(posedge clk) begin
        if (!rst)
            PC <= 0;
        else if(en)
            PC <= PC_next;
    end
    
endmodule
