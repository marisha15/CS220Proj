`include "d_ff32.v"
`include "decoder.v"

module sram16_32(mem,din,we,add,clk,reset);

input [31:0] din;
input [3:0] add;
input we;
input clk,reset;
output [511:0] mem;



genvar i;
generate
    for(i = 0;i<16;i = i + 1)begin
        d_ff32 sss(mem[32*i + 31: 32*i],din,clk,reset,add == i ? we : 1'b0);
    end
endgenerate

// assign dout = mem[add];


endmodule






















// input we,reset,clk;
// input [31:0] din;
// input [3:0] add;
// output reg [511:0]mem;
// output [31:0] dout;

// wire [15:0] out;


// wire [31:0] mem_wire[15:0];

// decoder ss(add,out);

// reg [3:0] count;

// integer j;

// always @(*)begin
// for(j = 0;j<16;j= j + 1)begin
//     if(out[j] == 1'b1)count=j;
// end
// end

// genvar i;
// generate
//     for(i = 0;i<16;i = i + 1)begin
//         d_ff32 ss(mem_wire[i],din,clk,reset,i == count ? we : 1'b0);
//     end
// endgenerate

// always @(*) begin  
//     for(j = 0;j<16;j = j + 1)begin
//     case (j)
//         0:  mem[31:0] = mem_wire[0];
//         1:  mem[63:32] = mem_wire[1];
//         2:  mem[95:64] = mem_wire[2];
//         3:  mem[127:96] = mem_wire[3];
//         4:  mem[159:128] = mem_wire[4];
//         5:  mem[191:160] = mem_wire[5];
//         6:  mem[223:192] = mem_wire[6];
//         7:  mem[255:224] = mem_wire[7];
//         8:  mem[287:256] = mem_wire[8];
//         9:  mem[319:288] = mem_wire[9];
//         10: mem[351:320] = mem_wire[10];
//         11: mem[383:352] = mem_wire[11];
//         12: mem[415:384] = mem_wire[12];
//         13: mem[447:416] = mem_wire[13];
//         14: mem[479:448] = mem_wire[14];
//         15: mem[511:480] = mem_wire[15];
//     endcase
//     end
// end



// // assign dout = mem[count];