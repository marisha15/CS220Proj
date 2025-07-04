module column_decoder( input [5:0] address_col, output reg [63:0] decoded_col );
    always@(*)begin
        decoded_col=64'b0;
        decoded_col[address_col]=1'b1;
    end   
endmodule
 
module row_decoder( input [3:0] address_row, output reg [15:0]  decoded_row );
    always@(*)begin
        decoded_row=16'b0;
        decoded_row[address_row]=1'b1;
    end
endmodule
 
module D_latche(input D, input clk, output reg Q);
    always @(*) begin
        if(clk) begin
            Q <= D;
        end
        else begin
            Q <= Q;
        end
    end
endmodule
 
 
 
module array_16x64(input [17:0] address,input we, input din, output dout );
    wire [63:0] decoded_col;
    wire [15:0] decoded_row;
    wire [3:0] row_address;
    wire [5:0] col_address;
    assign row_address = address[17:14];
    assign col_address = {address[13:11],address[6:4]};
    column_decoder col(col_address,decoded_col);
    row_decoder row(row_address,decoded_row);
    genvar i,j;
    wire [63:0]clk[15:0];
    wire [63:0]temp[15:0];
    wire [63:0] dout_temp[15:0];
    generate
        for(i=0;i<16;i=i+1)begin
            for(j=0;j<64;j=j+1)begin
                and(temp[i][j],decoded_col[j],decoded_row[i]);
                and(clk[i][j],temp[i][j],we);
                D_latche dl(din, clk[i][j], dout_temp[i][j]);
            end
        end    
    endgenerate
    wire [63:0]col_out;
    row_mux row_mux1(dout_temp[0],dout_temp[1],dout_temp[2],dout_temp[3],dout_temp[4],dout_temp[5],dout_temp[6],dout_temp[7],dout_temp[8],dout_temp[9],dout_temp[10],dout_temp[11],dout_temp[12],dout_temp[13],dout_temp[14],dout_temp[15],row_address,col_out);
    col_mux col_mux1(col_out,col_address,dout);   
endmodule
 
module DRAM_bank( input [17:0] address,input we, input [3:0] din, output [3:0] dout );
    array_16x64 array1(address,we,din[0],dout[0]); 
    array_16x64 array2(address,we,din[1],dout[1]);
    array_16x64 array3(address,we,din[2],dout[2]);
    array_16x64 array4(address,we,din[3],dout[3]); 
endmodule
 
module chip(input [17:0] address,input we,input [3:0] din, output [3:0]dout);
    genvar i;
    wire [3:0] dout_temp[15:0];
    wire [15:0] bank_select;
    row_decoder row(address[10:7],bank_select);
    wire temp[15:0];
    generate
        for(i=0;i<16;i=i+1)begin
            and(temp[i],bank_select[i],we);
            DRAM_bank dram_bank(address,temp[i],din,dout_temp[i]);
        end
    endgenerate  
    //write mux 
    mux mux1(dout_temp[0],dout_temp[1],dout_temp[2],dout_temp[3],dout_temp[4],dout_temp[5],dout_temp[6],dout_temp[7],dout_temp[8],dout_temp[9],dout_temp[10],dout_temp[11],dout_temp[12],dout_temp[13],dout_temp[14],dout_temp[15],address[10:7],dout);
 
endmodule
 
module DIMM(input[17:0] address,input we, input [63:0] busin, output [63:0] busout);
    genvar i;
    generate
    for(i=0;i<16;i=i+1) begin
        chip chip1(address,we,busin[4*i+3:4*i],busout[4*i+3:4*i]);
    end
    endgenerate
endmodule
 
module week4_1(input [17:0] address,input clk ,input we, input [63:0]din, output [63:0] busout);
        DIMM dimm1(address,we,din,busout);
endmodule  
 
 
 
module mux(input [3:0] muxin0,input [3:0] muxin1,input [3:0] muxin2,input [3:0] muxin3,input [3:0] muxin4,input [3:0] muxin5,input [3:0] muxin6,input [3:0] muxin7,input [3:0] muxin8,input [3:0] muxin9,input [3:0] muxin10,input [3:0] muxin11,input [3:0] muxin12,input [3:0] muxin13,input [3:0] muxin14,input [3:0] muxin15, input [3:0] address, output reg [3:0] muxout);
    always@(*)begin
        case(address)
        4'b0000: muxout = muxin0;
        4'b0001: muxout = muxin1;
        4'b0010: muxout = muxin2;
        4'b0011: muxout = muxin3;
        4'b0100: muxout = muxin4;
        4'b0101: muxout = muxin5;
        4'b0110: muxout = muxin6;
        4'b0111: muxout = muxin7;
        4'b1000: muxout = muxin8;
        4'b1001: muxout = muxin9;
        4'b1010: muxout = muxin10;
        4'b1011: muxout = muxin11;
        4'b1100: muxout = muxin12;
        4'b1101: muxout = muxin13;
        4'b1110: muxout = muxin14;
        4'b1111: muxout = muxin15;
        default: muxout = 4'b0;
    endcase
    end    
endmodule
 
module row_mux( input [63:0] mux_in0,input [63:0] mux_in1,input [63:0] mux_in2,input [63:0] mux_in3,input [63:0] mux_in4,input [63:0] mux_in5,input [63:0] mux_in6,input [63:0] mux_in7,input [63:0] mux_in8,input [63:0] mux_in9,input [63:0] mux_in10,input [63:0] mux_in11,input [63:0] mux_in12,input [63:0] mux_in13,input [63:0] mux_in14,input [63:0] mux_in15, input [3:0] address, output reg [63:0] mux_out );
    always@( * )begin
    case(address)
        4'b0000: mux_out = mux_in0;
        4'b0001: mux_out = mux_in1;
        4'b0010: mux_out = mux_in2;
        4'b0011: mux_out = mux_in3;
        4'b0100: mux_out = mux_in4;
        4'b0101: mux_out = mux_in5;
        4'b0110: mux_out = mux_in6;
        4'b0111: mux_out = mux_in7;
        4'b1000: mux_out = mux_in8;
        4'b1001: mux_out = mux_in9;
        4'b1010: mux_out = mux_in10;
        4'b1011: mux_out = mux_in11;
        4'b1100: mux_out = mux_in12;
        4'b1101: mux_out = mux_in13;
        4'b1110: mux_out = mux_in14;
        4'b1111: mux_out = mux_in15;
        default: mux_out = 16'b0;
    endcase 
    end
endmodule
 
 
module col_mux(input [63:0]mux_in,input [5:0] address, output reg mux_out);
    always@(*)begin
    case(address)
        6'b000000: mux_out = mux_in[0];
        6'b000001: mux_out = mux_in[1];
        6'b000010: mux_out = mux_in[2];
        6'b000011: mux_out = mux_in[3];
        6'b000100: mux_out = mux_in[4];
        6'b000101: mux_out = mux_in[5];
        6'b000110: mux_out = mux_in[6];
        6'b000111: mux_out = mux_in[7];
        6'b001000: mux_out = mux_in[8];
        6'b001001: mux_out = mux_in[9];
        6'b001010: mux_out = mux_in[10];
        6'b001011: mux_out = mux_in[11];
        6'b001100: mux_out = mux_in[12];
        6'b001101: mux_out = mux_in[13];
        6'b001110: mux_out = mux_in[14];
        6'b001111: mux_out = mux_in[15];
        6'b010000: mux_out = mux_in[16];
        6'b010001: mux_out = mux_in[17];
        6'b010010: mux_out = mux_in[18];
        6'b010011: mux_out = mux_in[19];
        6'b010100: mux_out = mux_in[20];
        6'b010101: mux_out = mux_in[21];
        6'b010110: mux_out = mux_in[22];
        6'b010111: mux_out = mux_in[23];
        6'b011000: mux_out = mux_in[24];
        6'b011001: mux_out = mux_in[25];
        6'b011010: mux_out = mux_in[26];
        6'b011011: mux_out = mux_in[27];
        6'b011100: mux_out = mux_in[28];
        6'b011101: mux_out = mux_in[29];
        6'b011110: mux_out = mux_in[30];
        6'b011111: mux_out = mux_in[31];
        6'b100000: mux_out = mux_in[32];
        6'b100001: mux_out = mux_in[33];
        6'b100010: mux_out = mux_in[34];
        6'b100011: mux_out = mux_in[35];
        6'b100100: mux_out = mux_in[36];
        6'b100101: mux_out = mux_in[37];
        6'b100110: mux_out = mux_in[38];
        6'b100111: mux_out = mux_in[39];
        6'b101000: mux_out = mux_in[40];
        6'b101001: mux_out = mux_in[41];
        6'b101010: mux_out = mux_in[42];
        6'b101011: mux_out = mux_in[43];
        6'b101100: mux_out = mux_in[44];
        6'b101101: mux_out = mux_in[45];
        6'b101110: mux_out = mux_in[46];
        6'b101111: mux_out = mux_in[47];
        6'b110000: mux_out = mux_in[48];
        6'b110001: mux_out = mux_in[49];
        6'b110010: mux_out = mux_in[50];
        6'b110011: mux_out = mux_in[51];
        6'b110100: mux_out = mux_in[52];
        6'b110101: mux_out = mux_in[53];
        6'b110110: mux_out = mux_in[54];
        6'b110111: mux_out = mux_in[55];
        6'b111000: mux_out = mux_in[56];
        6'b111001: mux_out = mux_in[57];
        6'b111010: mux_out = mux_in[58];
        6'b111011: mux_out = mux_in[59];
        6'b111100: mux_out = mux_in[60];
        6'b111101: mux_out = mux_in[61];
        6'b111110: mux_out = mux_in[62];
        6'b111111: mux_out = mux_in[63];
        default: mux_out = 64'b0;
 
    endcase
    end
endmodule
 