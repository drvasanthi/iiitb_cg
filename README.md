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
![image](https://user-images.githubusercontent.com/67214592/181414773-8ba123ca-ea46-4fc7-97a2-5a7f168a69ee.png)

![image](https://user-images.githubusercontent.com/67214592/181414854-920be29d-4828-49d9-8f6a-2e256a4be945.png)

![image](https://user-images.githubusercontent.com/67214592/181414927-11260dd3-b2ab-4edf-88fc-3621c7e3ffe2.png)


##Contributors

  * Vasanthi D R
  * Dantu Nandini Devi
  * Kunal Ghosh
  * Madhav Rao
  * Nanditha Rao

##Acknowledgement
  
  * Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.
  * Madhav Rao, Professor, IIIT-Bangalore.
  * Nanditha Rao, Professor, IIIT-Bangalore.

##Contact Information

  * Vasanthi D R, PhD Scholar, International Institute of Information Technology, Bangalore vasanthidr11@gmail.com
  * Dantu Nandini Devi, MS Student, International Institute of Information Technology, Bangalore nandini.dantu@gmail.com
  * Kunal Ghosh, Director, VSD Corp. Pvt. Ltd. kunalghosh@gmail.com
  * Madhav Rao, Professor, IIIT-Bangalore. mr@iiitb.ac.in
  * Nanditha Rao, Professor, IIIT-Bangalore. nanditha.rao@iiitb.ac.in
