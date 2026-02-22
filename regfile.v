module regfile (input clk, input we3,
                input [1:0] rs1, rs2, rd,
                input [15:0] wd3,
                output [15:0] rd1, rd2);

reg [15:0] rf[3:0];

// three ported register file
// read two ports combinationally
// write third port on rising edge of clock
// register 0 hardwired to 0
always @ (posedge clk)
if (we3 && (rd!=0)) rf[rd] <= wd3;

assign rd1 = (rs1 != 0) ? rf[rs1] : 0;
assign rd2 = (rs2 != 0) ? rf[rs2] : 0;
endmodule