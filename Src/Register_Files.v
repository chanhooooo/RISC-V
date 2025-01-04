module Register_Files (input clk,
                       input rst,
                       input RegWrite,
                       input [4:0] Addr1,
                       input [4:0] Addr2,
                       input [4:0] Addr3,
                       input [31:0] WD3,
                       output [31:0] RD1,
                       output [31:0] RD2);
    
    reg [31:0] Register [31:0];
    
    assign RD1 = (~rst)? 32'b0:Register[Addr1];
    assign RD2 = (~rst)? 32'b0:Register[Addr2];
    
    always @(posedge clk) begin
        if (RegWrite)
            Register[Addr3] <= WD3;
    end
    initial begin
        Register[0] = 32'h00000000;
        Register[1] = 32'h00000001;
        Register[2] = 32'h00000002;
        Register[3] = 32'h00000000;
        Register[4] = 32'h00000003;
        Register[5] = 32'h00000001;
        Register[6] = 32'h00000000;
        Register[7] = 32'h00000001;
        Register[8] = 32'h00000000;
        Register[9] = 32'h00000000;
        Register[10] = 32'h00000000;
    end
endmodule
