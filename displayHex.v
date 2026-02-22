module displayHex(
    input  [3:0] Data,     // hex digit
    output reg [6:0] seg0  // output on display
);

always @(*) begin
    case (Data)
        4'h0: seg0 = 7'b1000000;
        4'h1: seg0 = 7'b1111001;
        4'h2: seg0 = 7'b0100100;
        4'h3: seg0 = 7'b0110000;
        4'h4: seg0 = 7'b0011001;
        4'h5: seg0 = 7'b0010010;
        4'h6: seg0 = 7'b0000010;
        4'h7: seg0 = 7'b1111000;
        4'h8: seg0 = 7'b0000000;
        4'h9: seg0 = 7'b0010000;
        4'hA: seg0 = 7'b0001000;
        4'hB: seg0 = 7'b0000011;
        4'hC: seg0 = 7'b1000110;
        4'hD: seg0 = 7'b0100001;
        4'hE: seg0 = 7'b0000110;
        4'hF: seg0 = 7'b0001110;
        default: seg0 = 7'b1111111;  // blank
    endcase
end

endmodule
