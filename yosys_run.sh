# read design
  
read_verilog /home/vasanthidr11/Desktop/iiitb_cg/verilog/iiitb_cg.v

# generic synthesis
synth -top iiitb_cg

# mapping to mycells.lib
dfflibmap -liberty /home/vasanthidr11/Desktop/iiitb_cg/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/vasanthidr11/Desktop/iiitb_cg/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
clean
flatten
# write synthesized design
write_verilog iiitb_cg_synth.v
