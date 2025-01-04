module Hazard_Unit ( input rst,
                     input RegWriteM,
                     input RegWriteW,
                     input [4:0] Rs1E,
                     input [4:0] Rs2E,
                     input [4:0] RDM,
                     input [4:0] RDW,
                     output reg [1:0] ForwardAE,
                     output reg [1:0] ForwardBE);
    
    always @(*) begin
        if (!rst) begin
            ForwardAE = 2'b00;
            ForwardBE = 2'b00;
            end else begin
            // ForwardAE
            if (RegWriteM && (RDM != 0) && (RDM == Rs1E))
                ForwardAE = 2'b10;
            else if (RegWriteW && (RDW != 0) && (RDW == Rs1E))
                ForwardAE = 2'b01;
            else
                ForwardAE = 2'b00;
            
            // ForwardBE
            if (RegWriteM && (RDM != 0) && (RDM == Rs2E))
                ForwardBE = 2'b10;
            else if (RegWriteW && (RDW != 0) && (RDW == Rs2E))
                ForwardBE = 2'b01;
            else
                ForwardBE = 2'b00;
        end
    end
    
endmodule
