module iiitb_icg (in,clk,d0,d1,q0,q1,cgclk,q_l);
input in,d0,d1;
input clk;
output q0,q1,cgclk, q_l;

reg q0=0;
reg q1=0;

wire cgclk;
wire n1,n2,n3,n4,n5,clk_n,q_l;
wire en;

dff dff1 (clk,in,n1);
not g1 (n2,n1);
not g2 (n3,n2);
nand g3 (n4,n1,n3);
and g4 (n5,n3,n2);
or g5 (en,n4,n5);
not (clk_n, clk);
dff dff2 (clk_n,en,q_l);
and (cgclk,clk,q_l);

always@(posedge cgclk)
begin
q0 <= d0;
q1 <=d1;
end

endmodule

