/* Generated by Yosys 0.19+42 (git sha1 7d4f87d69f0, clang  -fPIC -Os) */

module iiitb_icg(in, clk, d0, d1, q0, q1);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire cgclk;
  input clk;
  wire clk;
  wire clk_n;
  input d0;
  wire d0;
  input d1;
  wire d1;
  wire \dff1.clock ;
  wire \dff1.d ;
  wire \dff1.q ;
  wire \dff2.clock ;
  wire \dff2.d ;
  wire \dff2.q ;
  wire en;
  input in;
  wire in;
  wire n1;
  wire n3;
  wire n4;
  wire n5;
  output q0;
  wire q0;
  output q1;
  wire q1;
  wire q_l;
  sky130_fd_sc_hd__clkinv_1 _06_ (
    .A(_01_),
    .Y(_02_)
  );
  sky130_fd_sc_hd__clkinv_1 _07_ (
    .A(_04_),
    .Y(_03_)
  );
  sky130_fd_sc_hd__and2_0 _08_ (
    .A(_01_),
    .B(_05_),
    .X(_00_)
  );
  sky130_fd_sc_hd__dfxtp_1 _09_ (
    .CLK(cgclk),
    .D(d1),
    .Q(q1)
  );
  sky130_fd_sc_hd__dfxtp_1 _10_ (
    .CLK(cgclk),
    .D(d0),
    .Q(q0)
  );
  sky130_fd_sc_hd__dfxtp_1 _11_ (
    .CLK(\dff1.clock ),
    .D(\dff1.d ),
    .Q(\dff1.q )
  );
  sky130_fd_sc_hd__dfxtp_1 _12_ (
    .CLK(\dff2.clock ),
    .D(\dff2.d ),
    .Q(\dff2.q )
  );
  assign n3 = n1;
  assign n4 = en;
  assign n5 = 1'h0;
  assign _01_ = clk;
  assign clk_n = _02_;
  assign _05_ = q_l;
  assign cgclk = _00_;
  assign _04_ = n1;
  assign en = _03_;
  assign \dff2.clock  = clk_n;
  assign \dff2.d  = en;
  assign q_l = \dff2.q ;
  assign \dff1.clock  = clk;
  assign \dff1.d  = in;
  assign n1 = \dff1.q ;
endmodule
