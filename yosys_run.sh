# read design
  
read_verilog /home/vasanthi/Desktop/iiitb_cg/verilog/iiitb_icg.v
read_verilog /home/vasanthi/Desktop/iiitb_cg/verilog/dff.v


# generic synthesis
synth -top iiitb_icg

# mapping to mycells.lib
dfflibmap -liberty /home/vasanthi/Desktop/iiitb_cg/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/vasanthi/Desktop/iiitb_cg/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
# opt
clean
flatten
# write synthesized design
write_verilog -noattr iiitb_icg_synth.v

stat
