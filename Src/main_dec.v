module main_dec (input [6:0] op,
                 output reg ALUSrc,
                 output reg RegWrite,
                 output reg MemRead,
                 output reg MemWrite,
                 output reg Branch,
				 output reg Jump,
                 output reg [1:0] Mem_to_Reg,
				 output reg [2:0] ImmSrc,
                 output reg [1:0] ALUOp);

	parameter R_type = 7'b0110011;
	parameter I_type = 7'b0010011;
	parameter B_type = 7'b1100011;
	parameter U_type = 7'b0110111;  //lui
	parameter S_type = 7'b0100011;  //sw
	parameter J_type = 7'b1101111;  //jal
	parameter lw     = 7'b0000011;
	

	always @(*) begin
    	case (op)
        	R_type: begin
            	ALUSrc     = 1'b0;
            	Mem_to_Reg = 2'b00;
            	RegWrite   = 1'b1;
            	MemRead    = 1'b0;
            	MemWrite   = 1'b0;
            	Branch     = 1'b0;
				Jump	   = 1'b0;
				ImmSrc 	   = 3'b000;
            	ALUOp      = 2'b10;
        	end

			I_type: begin
            	ALUSrc     = 1'b1;
            	Mem_to_Reg = 2'b00;
            	RegWrite   = 1'b1;
            	MemRead    = 1'b0;
            	MemWrite   = 1'b0;
            	Branch     = 1'b0;
				Jump	   = 1'b0;
				ImmSrc 	   = 3'b000;
            	ALUOp      = 2'b10;
        	end
		
			B_type: begin
            	ALUSrc     = 1'b0;
            	Mem_to_Reg = 2'b00;
            	RegWrite   = 1'b0;
            	MemRead    = 1'b0;
            	MemWrite   = 1'b0;
            	Branch     = 1'b1;
				Jump	   = 1'b0;
				ImmSrc 	   = 3'b010;
            	ALUOp      = 2'b01;
        	end

			S_type : begin
            	ALUSrc     = 1'b1;
            	Mem_to_Reg = 2'b00;
            	RegWrite   = 1'b0;
            	MemRead    = 1'b0;
            	MemWrite   = 1'b1;
            	Branch     = 1'b0;
				Jump	   = 1'b0;
				ImmSrc 	   = 3'b001;
            	ALUOp      = 2'b00;
        	end

			U_type : begin
            	ALUSrc     = 1'b1;
            	Mem_to_Reg = 2'b00;
            	RegWrite   = 1'b1;
            	MemRead    = 1'b0;
            	MemWrite   = 1'b0;
            	Branch     = 1'b0;
				Jump	   = 1'b0;
				ImmSrc 	   = 3'b011;
            	ALUOp      = 2'b00;
        	end
        
        	lw: begin
            	ALUSrc     = 1'b1;
            	Mem_to_Reg = 2'b01;
            	RegWrite   = 1'b1;
            	MemRead    = 1'b1;
            	MemWrite   = 1'b0;
            	Branch     = 1'b0;
				Jump	   = 1'b0;
				ImmSrc 	   = 3'b000;
            	ALUOp      = 2'b00;
        	end
        	
			J_type: begin  // jal
                ALUSrc     = 1'b0;      
                Mem_to_Reg = 2'b10;     
                RegWrite   = 1'b1;      
                MemRead    = 1'b0;      
                MemWrite   = 1'b0;      
                Branch     = 1'b0;      
                Jump       = 1'b1;      
                ImmSrc     = 3'b100;     
                ALUOp      = 2'b00;     
            end

        	default: begin
            	ALUSrc     = 1'b0;
            	Mem_to_Reg = 2'b00;
            	RegWrite   = 1'b1;
            	MemRead    = 1'b0;
            	MemWrite   = 1'b0;
            	Branch     = 1'b0;
				Jump	   = 1'b0;
				ImmSrc 	   = 3'b000;
            	ALUOp      = 2'b10;
        	end
    	endcase
	end
endmodule
