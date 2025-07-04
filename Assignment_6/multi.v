module multi (a,b,out,overflow);

input [31:0] a,b;
output reg overflow;
output  [31:0] out;
reg [7:0] expo;

wire signa,signb;
wire [7:0] expoa,expob;
wire [22:0] fraca,fracb;

assign {signa,expoa,fraca} = a;
assign {signb,expob,fracb} = b;

reg sign;

reg [22:0] frac;

wire [23:0] signia = {1'b1,fraca};
wire [23:0] signib = {1'b1,fracb};

reg [47:0] mul;

always @(*) begin
   sign = signa^signb;
   expo = expoa + expob - 8'd254;

   mul = signia* signib;

   if(mul[47])begin
    expo = expo + 1;
    frac = mul[46:24];
   end
   else begin
    frac = mul[45:23];
   end

   if(expo >= 8'd128)overflow = 1'b1;
   else overflow = 1'b0;

    expo = expo + 7'd127;

end

assign out = {sign,expo,frac};

endmodule