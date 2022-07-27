# iiitb-cg - Clock Gating
This project simulates the designed Bandgap Reference circuit to determine its performance characterisitics pre-simulation and post-simulation.

Note: The circuit Design yet to be modified to improve the performance.

{: .gitlab-orange}
## Icarus Verilog (iverilog) Installation on Ubuntu
  //_Icarus Verilog is an open-source EDA tool for implementing verilog hardware description language_//
  
 In the context menu, right click on an empty space, you’ll see the option of ‘Open in Terminal’
 
  * Type the following command
 ```html
sudo add-apt-repository ppa:team-electronics/ppa

sudo apt-get update

sudo apt-get install iverilog gtkwave
 ```
## Pre-Simulation
To clone the Repository, type the following commands in your terminal.
```html
$ git clone https://github.com/drvasanthi/iiitb_cg

$ cd /home/vasanthidr11/Desktop/iiitb_cg/

$ iverilog iiitb_cg.v iiitb_cg_tb.v
```
Run the file using the following commands
```html

$ ./a.out
$VCD info: dumpfile test.vcd opened for output.

$ gtkwave test.vcd
```


