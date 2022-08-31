###############################################################################
# Created by write_sdc
# Mon Aug 29 09:17:43 2022
###############################################################################
current_design iiitb_icg
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 10.0000 [get_ports {clk}]
set_clock_transition 0.1500 [get_clocks {clk}]
set_clock_uncertainty 0.2500 clk
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {d0}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {d1}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {in}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {q0}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {q1}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {q0}]
set_load -pin_load 0.0334 [get_ports {q1}]
set_driving_cell -lib_cell sky130_vsdinv -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {clk}]
set_driving_cell -lib_cell sky130_vsdinv -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {d0}]
set_driving_cell -lib_cell sky130_vsdinv -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {d1}]
set_driving_cell -lib_cell sky130_vsdinv -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {in}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_fanout 10.0000 [current_design]
