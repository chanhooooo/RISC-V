module Hazard_Detection_Unit (input MemReadE,
                              input PCSrcE,
                              input [4:0] Rs1D,
                              input [4:0] Rs2D,
                              input [4:0] RDE,
                              output stallF,
                              output stallD,
                              output FlushE,
                              output FlushD);
    
    wire lwstall;
    
    assign lwstall = MemReadE && ((RDE == Rs1D) || (RDE == Rs2D));
    assign stallF  = lwstall;
    assign stallD  = lwstall;
    assign FlushE  = lwstall | PCSrcE;
    assign FlushD  = PCSrcE;
    
endmodule
