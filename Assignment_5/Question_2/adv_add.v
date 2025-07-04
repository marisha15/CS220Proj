module fpga_adder_adv (
    A,B,Cin, Sum, Cout       
);
    parameter W = 64;
    input [W-1:0] A;
    input [W-1:0] B;  
    input Cin;             
    output [W-1:0] Sum;  
    output Cout;  
    wire [W/2 - 1:0] G, P, S;
 
    wire [W/2 - 1:0] C;       
 
    genvar i;
    generate
 
        for (i = 0; i < W/2; i = i + 1) begin : lut_gp
 
            LUT6_2 #(
                .INIT(64'h06600660f880f880) 
            ) lut_inst1 (
                .O6(P[i]), 
                .O5(G[i]),
                .I0(B[2*i]),     
                .I1(A[2*i]),     
                .I2(B[2*i+1]),   
                .I3(A[2*i+1]),   
                .I4(1'b0),      
                .I5(1'b1)   
            );
        end
    endgenerate
 
    generate
 
        for (i = 0; i < W/2; i = i + 1) begin : lut_sum
 
            LUT6_2 #(
                .INIT(64'he81717e896969696) 
            ) lut_inst2 (
                .O6(Sum[2*i+1]), 
                .O5(Sum[2*i]),
                .I0((i == 0) ? Cin : C[i-1]), 
                .I1(B[2*i]),     
                .I2(A[2*i]),   
                .I3(B[2*i+1]),   
                .I4(A[2*i+1]),      
                .I5(1'b1)      
            );
        end
    endgenerate

    CARRY4 carry_inst0 (
        .CI(1'b0),               
        .CO(C[3:0]),            
        .O(S[3:0]),             
        .CYINIT(Cin),           
        .DI(G[3:0]),            
        .S(P[3:0])              
    );
 
    generate
        for (i = 4; i < W/2; i = i + 4) begin : carry_chain
            CARRY4 carry_inst (
                .CI(C[i-1]),           
                .CO(C[i+3:i]),      
                .O(S[i+3:i]),       
                .CYINIT(C[i-1]),      
                .DI(G[i+3:i]),      
                .S(P[i+3:i])        
            );
        end
    endgenerate
 
    assign Cout = C[W/2 - 1];
endmodule

module mux2to1(A,B,S,Y);
    input A,B,S;
    output Y;
    assign Y = (S==1'b0)?A:B;
endmodule

module mux #(parameter W=64) (A,B,S,Y);
    input [W-1:0] A,B;
    input S;
    output [W-1:0] Y;
    assign Y = (S==1'b0)?A:B;
endmodule
 

module mjolnir #(parameter k=128) (A,B,Cin, Sum, Cout);
    input [k-1:0] A;
    input [k-1:0] B;
    input Cin;
    output [k-1:0] Sum;
    output Cout;

    wire [(k/2)-1:0]S0;
    wire [(k/2)-1:0]S1;
    wire c,c1,c0;
    fpga_adder_adv #(.W(k/2)) f0(A[k/2-1:0],B[k/2-1:0],Cin,Sum[k/2-1:0],c);
    fpga_adder_adv #(.W(k/2)) f1(A[k-1:(k/2)],B[k-1:(k/2)],1'b0,S0,c0);
    fpga_adder_adv #(.W(k/2)) f2(A[k-1:(k/2)],B[k-1:(k/2)],1'b1,S1,c1);
    mux2to1 m0(c0,c1,c,Cout);
    mux #(.W(k/2)) m1(S0,S1,c,Sum[k-1:(k/2)]);

endmodule