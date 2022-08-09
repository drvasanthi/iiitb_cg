# iiitb-cg - Integrated Clock Gating (ICG)
  The project design is based on Integrated Clock Gating using SKY 130nm technology node. 
  
## **Description**

  In current VLSI design, the power dissipation is the most important parameter that signifies the need of low power circuits. In most of the ICs clock consumes 30-40 % of total power. So the integrated clock gating logic is used in many synchronous circuits for reducing dynamic power dissipation, by removing the clock signal when the circuit is not in use. 

**Block Diagram**

![blockdiagram](https://user-images.githubusercontent.com/67214592/183288720-9af6827a-cbfa-4f47-8b24-2172c4f7ea01.PNG)

**Circuit Diagram**

![circuitdiagram](https://user-images.githubusercontent.com/67214592/183288729-cf1af368-8624-45e7-b864-e66ad3e6ef99.PNG)

## Icarus Verilog (iverilog) & Yosys Installation on Ubuntu
  //_Icarus Verilog is an open-source EDA tool for implementing verilog hardware description language_//
  
 In the context menu, right click on an empty space, you’ll see the option of ‘Open in Terminal’
 
  * Type the following command to install `iverilog & gtkwave`
 ```
$ sudo apt-get update

$ sudo apt-get install iverilog gtkwave
 ```
 
  * Type the following command to install `yosys`
 ```
 $ git clone https://github.com/YosysHQ/yosys.git
 
 $ sudo apt install make
 
 $ sudo apt-get install build-essential clang bison flex \
	libreadline-dev gawk tcl-dev libffi-dev git \
	graphviz xdot pkg-config python3 libboost-system-dev \
	libboost-python-dev libboost-filesystem-dev zlib1g-dev
  
 $ sudo make install

 ```
 
## ICG - RTL-Simulation 
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

## Synthesis

Invoke the yosys using following commands

![image](https://user-images.githubusercontent.com/67214592/183289143-1ecf0702-ef0a-4187-8c6d-531cb8866ba7.png)

```
yosys> read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib

yosys> read_verilog iiitb_icg.v dff.v

yosys> synth -top iiitb_icg

yosys> dfflibmap -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib

yosys> abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib

yosys> flatten

yosys> show

```

![icg_synth](https://user-images.githubusercontent.com/67214592/183289303-634f1746-c0d0-4cef-a0e3-b7407b738eda.PNG)

## GLS - Gate Level Simulation

## Contributors

  * Vasanthi D R
  * Dantu Nandini Devi
  * Kunal Ghosh
  * Madhav Rao
  * Nanditha Rao

## Acknowledgement
  
  * Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.
  * Madhav Rao, Professor, IIIT-Bangalore.
  * Nanditha Rao, Professor, IIIT-Bangalore.

## Contact Information

  * Vasanthi D R, PhD Scholar, International Institute of Information Technology, Bangalore vasanthidr11@gmail.com
  * Dantu Nandini Devi, MS Student, International Institute of Information Technology, Bangalore nandini.dantu@gmail.com
  * Kunal Ghosh, Director, VSD Corp. Pvt. Ltd. kunalghosh@gmail.com
  * Madhav Rao, Professor, IIIT-Bangalore. mr@iiitb.ac.in
  * Nanditha Rao, Professor, IIIT-Bangalore. nanditha.rao@iiitb.ac.in
  
 ## References
 
 [1] VLSI System Design: https://www.vlsisystemdesign.com/
 
 [2] SkyWater SKY130 PDK: https://skywater-pdk.readthedocs.io/en/main/contents/libraries/foundry-provided.html
 
 [3] RTL Design using Verilog with Sky130 Technology: https://www.vsdiat.com/dashboard
 
 [4] Saurabh Kshirsagar, Dr. M B Mali, “A Review of Clock Gating Techniques in Low Power Applications”, International Journal of Innovative Research in Science, Engineering and Technology (An ISO 3297: 2007 Certified Organization) Vol. 4, Issue 6, June 2015, ISSN (Online): 2319-8753, ISSN (Print): 2347-6710.
