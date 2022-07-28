# iiitb-cg - Clock Gating
  The project design of an Clock Gating using SKY 130nm technology node. 
  
## Description
  In current VLSI design, the power dissipation is the most important parameter that signifies the need of low power circuits. The clock gating logic is used in many synchronous circuits for reducing dynamic power dissipation, by removing the clock signal when the circuit is not in use. 

Note: The circuit Design yet to be modified to improve the performance.

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
![image](https://user-images.githubusercontent.com/67214592/181414148-5b581b51-5165-4e3f-99f7-00138c69e804.png)


