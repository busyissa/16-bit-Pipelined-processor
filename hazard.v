module hazard(input branchE, regWriteM, regWriteW, resultMuxE,
              input [1:0] rs1D, rs2D, rs1E, rs2E, rdE, rdM, rdW,
              output reg stallF, stallD, flushD, flushE, 
              output reg [1:0] forwardAE, forwardBE);

    always @(*) begin
        forwardAE = 2'b00;
        forwardBE = 2'b00;

        // forward for ALU srcA (rs1E)
        if (regWriteM && (rdM != 0) && (rdM == rs1E))
            forwardAE = 2'b10;     // from MEM
        else if (regWriteW && (rdW != 0) && (rdW == rs1E))
            forwardAE = 2'b01;     // from WB

        // forward for ALU srcB (rs2E)
        if (regWriteM && (rdM != 0) && (rdM == rs2E))
            forwardBE = 2'b10;     // from MEM
        else if (regWriteW && (rdW != 0) && (rdW == rs2E))
            forwardBE = 2'b01;     // from WB
    end

    wire lwStall;
    assign lwStall = (resultMuxE & ((rs1D == rdE) | (rs2D == rdE)));

    always @(*) begin
        // Defaults
        stallF = 0;
        stallD = 0;
        flushD = 0;
        flushE = 0;

        if (lwStall) 
        begin
            stallF = 1;
            stallD = 1;
            flushE = 1;
        end

        if (branchE)
         begin
            flushD = 1;
            flushE = 1;
        end
    end
endmodule