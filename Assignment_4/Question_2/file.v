`include "d_ff32.v"
`include "decoder.v"
`include "mux.v"
module file(add_a,add_b,add_c,add_d,din_a,din_b,din_c,din_d,we,clk,reset,dout_a,dout_b);

input we,clk,reset;
input [4:0] add_a,add_b,add_c,add_d;
input [31:0] din_a,din_b,din_c,din_d;
output [31:0] dout_a,dout_b;

wire [31:0] dec_a,dec_b,dec_c,dec_d;

wire [31:0] mem[31:0];

decoder ss1(add_a,dec_a);
decoder ss2(add_b,dec_b);
decoder ss3(add_c,dec_c);
decoder ss4(add_d,dec_d);



genvar i;
generate
    for(i = 0;i<32;i= i + 1)begin
        wire [31:0] data;
        mux ss(din_a,din_b,din_c,din_d,{dec_d[i],dec_c[i],dec_b[i],dec_a[i]},data);
        d_ff32 sss(mem[i],data,clk,reset,we & (dec_a[i] | dec_b[i] | dec_c[i] | dec_d[i]));
    end

endgenerate

assign dout_a = mem[add_a];
assign dout_b = mem[add_b];

endmodule 






















// input [4:0] add_a,add_b,add_c,add_d;
// input [31:0] din_a,din_b,din_c,din_d;
// input clk,reset,we;

// output [31:0] dout_a,dout_b;

// reg [31:0] mem[31:0];
// wire [31:0] mem_wire[31:0];

// wire [31:0] dec_a;
// wire [31:0] dec_b;
// wire [31:0] dec_c;
// wire [31:0] dec_d;

// decoder ss1(add_a,dec_a);
// decoder ss2(add_b,dec_b);
// decoder ss3(add_c,dec_c);
// decoder ss4(add_d,dec_d);

// genvar i;
// generate
//     for(i = 0;i<32;i = i + 1)begin
//         wire [31:0] data;
//         mux ss(din_a,din_b,din_c,din_d,{dec_d[i],dec_c[i],dec_b[i],dec_a[i]},data);
//         d_ff32 sss(mem_wire[i],data,clk,reset,we&(dec_a[i] | dec_b[i] | dec_c[i] | dec_d[i]));
//     end
// endgenerate

// integer j;
// always @(*)begin
//     for(j = 0;j<32;j = j + 1)begin
//         mem[j]<=mem_wire[j];
//     end
// end

// assign dout_a = mem[add_a];
// assign dout_b = mem[add_b];
