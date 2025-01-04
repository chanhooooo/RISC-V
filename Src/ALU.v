module ALU (input [3:0] ALU_Control,
            input [31:0] SrcA,
            input [31:0] SrcB,
            output Zero,
            output Sign,
            output reg [31:0] ALUOut);
    
    wire [31:0] Sum;
    
    assign Zero = ~(|ALUOut);
    assign Sign = ALUOut[31];
    assign Sum  = SrcA + (ALU_Control[0] ? ~SrcB : SrcB) + ALU_Control[0];
    
    always @(*) begin
        case (ALU_Control)
            4'b0000: ALUOut = Sum;						//sum
            4'b0001: ALUOut = Sum;						//diff
            4'b0010: ALUOut = SrcA&SrcB;				//and
            4'b0011: ALUOut = SrcA|SrcB;				//or
            4'b0100: ALUOut	= SrcA<<SrcB;				//sll
            4'b0101: ALUOut = SrcA^SrcB;				//xor
            4'b0110: ALUOut = SrcA<SrcB? 1'b1 :1'b0;	//slt
            4'b0111: ALUOut	= SrcA>>SrcB;				//srl
            4'b1000: ALUOut	= $signed(SrcA) >>> SrcB;	//sra
            default : ALUOut = 32'h00000000;
        endcase
    end
endmodule
