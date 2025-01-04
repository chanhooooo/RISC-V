module Sign_Extend (input [31:0] in,
                    input [2:0] ImmSrc,
                    output reg [31:0] Imm_Ext);
    
    always @(*) begin
        case (ImmSrc)
            3'b000: Imm_Ext  = {{20{in[31]}}, in[31:20]};  // I-type (e.g., lw, addi)
            3'b001: Imm_Ext  = {{20{in[31]}}, in[31:25], in[11:7]};  // S-type (e.g., sw)
            3'b010: Imm_Ext  = {{20{in[31]}}, in[7], in[30:25], in[11:8], 1'b0};  // SB-type (beq)
            3'b011: Imm_Ext  = {in[31:12],  12'b0}; //lui
            3'b100: Imm_Ext  = {{12{in[31]}}, in[19:12], in[20], in[30:21], 1'b0}; //jal
            default: Imm_Ext = 32'h00000000;
        endcase
    end
endmodule
    
