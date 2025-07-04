module mux(din_a,din_b,din_c,din_d,select,out);

input [31:0] din_a,din_b,din_c,din_d;
input [3:0] select;

output reg [31:0] out;

always @(*)begin
    if(select[0] == 1)out <= din_a;
    else if(select[1] == 1)out <= din_b;
    else if(select[2] == 1)out <= din_c;
    else if(select[3] == 1)out <= din_d;
    else out<=32'b0;
end

endmodule 