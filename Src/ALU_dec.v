module ALU_dec (input [1:0] ALUOp,
                input [2:0] funct3,
                input [6:0] funct7,
                output reg [3:0] ALU_Control);
    
    always @(*) begin
        ALU_Control = 4'b0000; // 초기값 설정
        case (ALUOp)
            2'b00: ALU_Control = 4'b0000; //add
            2'b01: ALU_Control = 4'b0001; //sub
            2'b10: begin
                casex (funct3)
                    3'b000: ALU_Control = (funct7[5] ? 4'b0001 : 4'b0000); // - : +
                    3'b001: ALU_Control = 4'b0100; // sll
                    3'b010: ALU_Control = 4'b0110; //slt
                    3'b100: ALU_Control = 4'b0101; //xor
                    3'b110: ALU_Control = 4'b0011; //or
                    3'b101: ALU_Control = (funct7[5] ? 4'b1000 : 4'b0111); // sra : srl
                    3'b111: ALU_Control = 4'b0010; //and
                    default: ALU_Control = 4'b0000;
                endcase
            end
            default: ALU_Control = 4'b0000;
        endcase
    end
    
endmodule
