`timescale 1ns / 1ps

module dff(clock,d,q);
input clock, d;
output q;
reg q=0;
always @(posedge clock)
begin
q<=d;
end
endmodule
