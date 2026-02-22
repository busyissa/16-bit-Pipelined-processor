module immExt(input [5:0] immIn, output [15:0] immOut);

//check machine code for reference: 
assign immOut = {{10{immIn[5]}}, immIn[5:0]};

endmodule