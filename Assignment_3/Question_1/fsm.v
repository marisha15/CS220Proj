module  fsm(clk,reset,out,ps,ns);

input clk,reset;
output reg[2:0] ps,ns;
output reg out;

parameter s0 = 3'b000;
parameter s1 = 3'b001;
parameter s2 = 3'b011;
parameter s3 = 3'b010;
parameter s4 = 3'b110;
parameter s5 = 3'b111;
parameter s6 = 3'b101;
parameter s7 = 3'b100;


always @(posedge clk)begin
    if(reset)ps<=s0;
    else ps<=ns;
end

always @(ps)begin
    case(ps)

    s0 : ns<=s1;
    s1 : ns<=s2;
    s2 : ns<=s3;
    s3 : ns<=s4;
    s4 : ns<=s5;
    s5 : ns<=s6;
    s6 : ns<=s7;
    s7 : ns<=s0;
    default : ns<=s0;

    endcase

end

always @(ps)begin
    if(ps == s0 && (reset == 1'b0) )out<=1;
    else out<=0;

end

endmodule 


















//input clk,reset;
// output reg out;
// output reg [2:0] ps,ns;

// parameter s0 = 3'b000;
// parameter s1 = 3'b001;
// parameter s2 = 3'b011;
// parameter s3 = 3'b010;
// parameter s4 = 3'b110;
// parameter s5 = 3'b111;
// parameter s6 = 3'b101;
// parameter s7 = 3'b100;

// always @(posedge clk) begin
//     if(reset)ps<=3'b000;
//     else ps<=ns;
// end

// always @(ps)begin
//     case(ps)
//     s0 : ns<=s1;
//     s1 : ns<=s2;
//     s2 : ns<=s3;
//     s3 : ns<=s4;
//     s4 : ns<=s5;
//     s5 : ns<=s6;
//     s6 : ns<=s7;
//     s7 : ns<=s0;
//     default : ns<=s0;
//     endcase
// end

// always @(ps)begin
//     case(ps)
//     s0: out<=1;
//     default: out<=0;
//     endcase
// end