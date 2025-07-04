module IITK_MIPS(clk,reset,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11);

input clk;
input reset;
reg [31:0] PC;

reg [1:0] R_type;
reg [1:0] I_type;
reg [1:0] J_type;

reg [31:0] rt;
reg [31:0] rs;
reg [31:0] rd;

reg [5:0]ins_op_code;

reg [5:0]ins_func;
reg [4:0]ins_rs;
reg [4:0]ins_rt;
reg [4:0]ins_rd;
reg [4:0]ins_shamt;

reg [25:0] address;

reg [15:0] imm;


reg [31:0] Memory[31:0];
reg [31:0] instruction;
reg [31:0]R[31:0];
reg [31:0]Data[31:0];
  
output [31:0] a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11;

initial begin
  //Instructions
  Memory[0] = 32'b100011_01010_00000_0000000000000000;     //load array size in R[0]
  Memory[1] = 32'b100011_01011_00001_0000000000000000;     //load 0 in R[1]	
  Memory[2] = 32'b100011_01011_00010_0000000000000000;     //load i=0 in R[2]
  //loop i starts
  Memory[3] = 32'b101011_00001_01101_0000000000000000;
  Memory[4] = 32'b100011_01101_00011_0000000000000000;     //load address $a in R[3]		
  Memory[5] = 32'b100011_01011_01001_0000000000000000;     //load j=0 in R[9]
  Memory[6] = 32'b100011_01100_00100_0000000000000000;     //load arry size-1=9 in R[4]
  Memory[7] = 32'b000000_00100_00010_00100_00000_100010;   //sub for n-1-i in R[4]
  //start of loopj
  Memory[8] = 32'b100100_00011_00101_0000000000000001;	//lw 4($a0) in R[5]	
  Memory[9] = 32'b100100_00011_00110_0000000000000000;	//lw 0($a0) in R[6]			
  Memory[10] = 32'b000000_00101_00110_00111_00000_101010; //slt in R[7] if R[5]>R[6]	then R[7]=1
  Memory[11] = 32'b000100_00111_00001_0000000000000100; //beq address not set		
  Memory[12] = 32'b100100_00011_01000_0000000000000001;	//lw 4($a0) in R[8]=R[5]
  Memory[13] = 32'b100100_00011_01001_0000000000000000;	//lw 0($a0) in R[9]=R[6]		
  Memory[14] = 32'b101100_01000_00011_0000000000000000;	//sw R[6] in R[5]
  Memory[15] = 32'b101100_01001_00011_0000000000000001;	//sw R[8] in R[6]
  Memory[16] = 32'b001000_01001_01001_0000000000000001;	//addi 1 in j
  Memory[17] = 32'b001000_00011_00011_0000000000000001;	//addi 1 in $a0
  Memory[18] = 32'b101011_00011_01101_0000000000000000; //for updating ss no.
  Memory[19] = 32'b000110_01001_00100_0000000000011100;//ble  loopj address not set		
  //end loopj
  Memory[20] = 32'b001000_00010_00010_0000000000000001;	//addi 1 in i
  Memory[21] = 32'b000110_00010_00000_0000000000001000;//ble loop i address not set		
end

integer i = 0;
always@(reset)
begin
  for(i = 0;i<32;i = i+1)
  begin
    R[i] = 32'b0;
    if(i>13)
      begin
    	Data[i] = 32'b0;
      end
  end
  //Data
  Data[0] = 32'b00000000000000000000000000001010;		//10
  Data[1] = 32'b00000000000000000000000000000101;		//5
  Data[2] = 32'b00000000000000000000000000000110;		//6
  Data[3] = 32'b00000000000000000000000000001000;		//8
  Data[4] = 32'b00000000000000000000000000001001;		//9
  Data[5] = 32'b00000000000000000000000000000010;		//2
  Data[6] = 32'b00000000000000000000000000000100;		//4
  Data[7] = 32'b00000000000000000000000000000001;	  //1
  Data[8] = 32'b00000000000000000000000000000011;		//3
  Data[9] = 32'b00000000000000000000000000000111;   //7
  Data[10] = 32'b00000000000000000000000000001010;	//array size=10
  Data[11] = 32'b0000000000000000000000000000000;		//0
  Data[12] = 32'b0000000000000000000000000001001;		//array size-1=9
  Data[13] = 32'b0000000000000000000000000000000;  //address of array

  PC = 0;
  I_type = 0;
  J_type = 0;
  R_type = 0;
end

always@(posedge clk)
begin
  instruction = Memory[PC>>2];
  ins_op_code = instruction[31:26];
  PC = PC + 4;

  if (ins_op_code == 0) 
  begin

    R_type = 1;
    I_type = 0;
    J_type = 0;

    ins_rs = instruction[25:21];
    ins_rt = instruction[20:16];
    ins_rd = instruction[15:11];
    ins_shamt = instruction[10:6];
    ins_func = instruction[5:0];

    rd = R[ins_rd];
    rs = R[ins_rs];
    rt = R[ins_rt];
 
    if (ins_func == 0)//sll
    begin
      R[ins_rt] = R[ins_rd]<<ins_shamt;
    end

    else if (ins_func == 2)//srl
    begin
      R[ins_rt] = R[ins_rd]>>ins_shamt;
    end
 
    else if (ins_func == 8)//jr
    begin
      PC = R[ins_rs];
    end

    else if (ins_func == 32)//add
    begin
      R[ins_rd] = R[ins_rs] + R[ins_rt];
    end
 
    else if (ins_func == 33)//addu
    begin
      R[ins_rd] = R[ins_rs] + R[ins_rt];
    end

    else if (ins_func == 34)//sub
    begin
      R[ins_rd] = R[ins_rs] - R[ins_rt];
    end

    else if (ins_func == 35)//subu
    begin
      R[ins_rd] = R[ins_rs] - R[ins_rt];
    end

    else if (ins_func == 36)//and
    begin
      R[ins_rd] = R[ins_rs] & R[ins_rt];
    end

    else if (ins_func == 37)//or
    begin
      R[ins_rd] = R[ins_rs] | R[ins_rt];
    end

    else if (ins_func == 42)//slt
    begin
      if(R[ins_rs] < R[ins_rt])
      begin
        R[ins_rd] = 32'd1;
      end
      else 
      begin
        R[ins_rd] = 32'd0;
      end
    end
  end

  else begin
    address = instruction[25:0];
    ins_rs = instruction[25:21];
    ins_rt = instruction[20:16];
    imm = instruction[15:0];

    rs = R[ins_rs];
    rt = R[ins_rt];

    if (ins_op_code == 2)//j
    begin
      R_type = 0;
      I_type = 0;
      J_type = 1;
      PC = {PC[31:28], address, 2'b00};
    end

    else if (ins_op_code == 3)//jal
    begin
      R[31] = PC + 4;
      R_type = 0;
      I_type = 0;
      J_type = 1;
      PC = {PC[31:28], address, 2'b00};
    end

    else if (ins_op_code == 4)//beq
    begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
      if (R[ins_rs] == R[ins_rt])
      begin
        PC = PC + {imm,2'b00};
      end
    end

    else if (ins_op_code == 5)//bne
    begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
      if (R[ins_rs] != R[ins_rt])
      begin
        PC = PC + {imm,2'b00};
      end
    end
    
    else if (ins_op_code == 6)//ble
    begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
      if (R[ins_rs] < R[ins_rt])
      begin
        PC = imm;
      end
    end

    else if (ins_op_code == 08)//addi
    begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
      R[ins_rt] = R[ins_rs] + imm; 
      
    end

    else if (ins_op_code == 09)//addui
    begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
      R[ins_rt] = R[ins_rs] + imm; 
      
    end

    else if (ins_op_code == 10)//slti
    begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
      R[ins_rt] = R[ins_rs] < imm; 
    end

    else if (ins_op_code == 12)//andi
    begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
      R[ins_rt] = R[ins_rs] & imm; 
      
    end

    else if (ins_op_code == 13)//ori
    begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
      R[ins_rt] = R[ins_rs] | imm; 
      
    end

    else if (ins_op_code == 35)//lw
    begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
      R[ins_rt] = Data[ins_rs + imm];
      
    end

    else if (ins_op_code == 43)//sw
    begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
      Data[ins_rt] = R[ins_rs+ imm];
    end
    
    else if (ins_op_code == 36)
    begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
      R[ins_rt] = Data[R[ins_rs]+imm];
    end
    
    else if (ins_op_code == 44)
    begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
      Data[R[ins_rt]+imm] = R[ins_rs];
    end
  end

end
  
  assign a1=Data[0];
  assign a2=Data[1];
  assign a3=Data[2];
  assign a4=Data[3];
  assign a5=Data[4];
  assign a6=Data[5];
  assign a7=Data[6];
  assign a8=Data[7];
  assign a9=Data[8];
  assign a10=Data[9];
  assign a11=Data[10];
endmodule



module veda(clk, rst, write_enable, address, datain, mode, dataout);
  parameter p=32;
  input [4:0] address;
  input [p-1:0] datain;
  input write_enable,clk,rst,mode;
  output [p-1:0] dataout;

  reg [p-1:0] RF [p-1:0]; 
  reg [p-1:0] why1,why2;
  reg psmode,smode;
  
  always@(posedge clk)
  begin
    psmode<=smode;
    smode<=mode;
    why1<=why2;
    if(rst)
      begin:bye
        integer i;
        for(i=0;i<p;i=i+1)
          begin
            RF[i]=32'b0;
          end
      end
    else
      begin
        if(write_enable)
          RF[address] <=datain;
        why2<=RF[address];
      end
  end
  assign dataout=(psmode? why1:why2);
endmodule

module CountorUnit(OUT1addr,OUT2addr,INaddr,func1,Select,imm_signal,comp_signal,instruction);

input [31:0] instruction;
output reg [5:0] func1;
output reg imm_signal;
output reg [4:0] Select;
output reg [4:0] OUT1addr;
output reg [4:0] OUT2addr;
output reg [4:0] INaddr;
output reg comp_signal;
always @(instruction) 
begin
	func1 = instruction[5:0];
	// opcode=instruction[31:26];
	Select = instruction[25:21];
	INaddr = instruction[20:16];
	OUT2addr = instruction[15:11];
	OUT1addr = instruction[10:6];
	imm_signal = 1'b0;
	comp_signal = 1'b0;
	case (instruction[31:24])
		8'b00001000:
			imm_signal = 1'b1;
		8'b00001001:						
			comp_signal = 1'b1;
		default:;
	endcase
end
endmodule

module ALU(A,B,ALU_Sel,ALU_Out,CarryOut);
input [31:0] A,B;  // ALU 8-bit Inputs                 
input [4:0] ALU_Sel;// ALU Selection
output [31:0] ALU_Out; // ALU 8-bit Output
output CarryOut; // Carry Out Flag

reg [31:0] ALU_Result;
wire [32:0] tmp;
assign ALU_Out = ALU_Result; // ALU out
assign tmp = {1'b0,A} + {1'b0,B};
assign CarryOut = tmp[32]; // Carryout flag
always @(*)
begin
    case(ALU_Sel)
    5'b00000: // Addition
        ALU_Result = A + B ; 
    5'b00001: // Subtraction
        ALU_Result = A - B ;
    5'b00010: // Multiplication
        ALU_Result = A * B;
    5'b00011: // Division
        ALU_Result = A/B;
    5'b00100: // Logical shift left
        ALU_Result = A<<1;
      5'b00101: // Logical shift right
        ALU_Result = A>>1;
      5'b00110: // Rotate left
        ALU_Result = {A[6:0],A[7]};
      5'b00111: // Rotate right
        ALU_Result = {A[0],A[7:1]};
      5'b01000: //  Logical and 
        ALU_Result = A & B;
      5'b01001: //  Logical or
        ALU_Result = A | B;
      5'b01010: //  Logical xor 
        ALU_Result = A ^ B;
      5'b01011: //  Logical nor
        ALU_Result = ~(A | B);
      5'b01100: // Logical nand 
        ALU_Result = ~(A & B);
      5'b01101: // Logical xnor
        ALU_Result = ~(A ^ B);
      5'b01110: // Greater comparison
        ALU_Result = (A>B)?32'd1:32'd0 ;
      5'b01111: // Equal comparison   
        ALU_Result = (A==B)?32'd1:32'd0 ;
      default: ALU_Result = A + B ; 
    endcase
end
endmodule

module Instruction_Fetch_Decoder(clk,reset,PC,R_type,I_type,J_type,rt,rs,rd,ins_op_code,ins_func,ins_rs,ins_rt,ins_rd,ins_shamt,address,imm);

input clk;
input reset;
output reg [31:0] PC;

output reg [1:0] R_type;
output reg [1:0] I_type;
output reg [1:0] J_type;

output reg [31:0] rt;
output reg [31:0] rs;
output reg [31:0] rd;

output reg [5:0]ins_op_code;

output reg [5:0]ins_func;
output reg [4:0]ins_rs;
output reg [4:0]ins_rt;
output reg [4:0]ins_rd;
output reg [4:0]ins_shamt;

output reg [25:0] address;

output reg [15:0] imm;


reg [31:0] instruction;
reg [31:0]R[31:0];

integer i = 0;
always@(reset)
begin
  for(i = 0;i<32;i = i+1)
  begin
    R[i] = 32'b0;
  end

  PC = 32'b0;
  I_type = 0;
  J_type = 0;
  R_type = 0;
end


always@(posedge clk)
begin
  
  ins_op_code = instruction[31:26];
  PC = PC + 4;

  if (ins_op_code == 0) 
  begin

    R_type = 1;
    I_type = 0;
    J_type = 0;

    ins_rs = instruction[25:21];
    ins_rt = instruction[20:16];
    ins_rd = instruction[15:11];
    ins_shamt = instruction[10:6];
    ins_func = instruction[5:0];

    rd = R[ins_rd];
    rs = R[ins_rs];
    rt = R[ins_rt];
 
  end

  else begin
    address = instruction[25:0];
    ins_rs = instruction[25:21];
    ins_rt = instruction[20:16];
    imm = instruction[15:0];

    rs = R[ins_rs];
    rt = R[ins_rt];

    if (ins_op_code == 2)//j
    begin
      R_type = 0;
      I_type = 0;
      J_type = 1;
      PC = {PC[31:28], address, 2'b00};
    end

    else if (ins_op_code == 3)//jal
    begin
      R[31] = PC + 4;
      R_type = 0;
      I_type = 0;
      J_type = 1;
      PC = {PC[31:28], address, 2'b00};
    end

    else if (ins_op_code == 4)//beq
    begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
      if (R[ins_rs] == R[ins_rt])
      begin
        PC = PC + {imm,2'b00};
      end
    end

    else if (ins_op_code == 5)//bne
    begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
      if (R[ins_rs] != R[ins_rt])
      begin
        PC = PC + {imm,2'b00};
      end
    end

    else if (ins_op_code == 08)//addi
    begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
      
    end

    else if (ins_op_code == 09)//addui
    begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
      
    end

    else if (ins_op_code == 10)//slti
    begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
    end

    else if (ins_op_code == 12)//andi
    begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
      
    end

    else if (ins_op_code == 13)//ori
    begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
      
    end

    else if (ins_op_code == 34)//lw
    begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
      
    end

    else if (ins_op_code == 43)//sw
    begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
    end
  end

end
endmodule