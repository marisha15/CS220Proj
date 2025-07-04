`timescale 1ns / 1ps
module carry_chain_sum_old(a,b,c_in,sum,c_out);


parameter W=64;

input [W-1:0] a,b;
input c_in;
output [W-1:0] sum;
output c_out;

wire [W/2:0] c_temp;

assign c_temp[0]=c_in;

assign c_out=c_temp[W/2];

single_slice_carry_gen_old_init carry_init(a[7:0],b[7:0],c_in,c_temp[4:1]);

genvar i;

generate for(i=8;i<W;i=i+8)
begin: carry_gen
single_slice_carry_gen_old carry(a[i+7:i],b[i+7:i],c_temp[(i+8)/2-4],c_temp[(i+8)/2:(i+8)/2-3]);
end
endgenerate

genvar j;

generate for(j=0;j<W/2;j=j+1)
begin: sum_gen
single_LUT_sum_gen sum_mod(a[2*j+1:2*j],b[2*j+1:2*j],c_temp[j],sum[2*j+1:2*j]);
end
endgenerate




endmodule
