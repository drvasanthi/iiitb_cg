<h1 align="center">RTL to GDSII using SKY130nm Technology node</h1>

<h1 align="center">Integrated Clock Gating (ICG) Design</h1>

## TABLE OF CONTENT

I. [**Introduction to Integrated Clock Gating**](https://github.com/drvasanthi/iiitb_cg/blob/main/README.md#introduction)    

II. [**RTL Design and Synthesis**](https://github.com/drvasanthi/iiitb_cg#ii-rtl-design-and-synthesis)  
  1. [Icarus Verilog (iverilog) & Yosys Installation on Ubuntu](https://github.com/drvasanthi/iiitb_cg#1-icarus-verilog-iverilog--yosys-installation-on-ubuntu)  
  2. [RTL Pre-Simulation](https://github.com/drvasanthi/iiitb_cg#rtl-pre-simulation)  
  3. [Synthesis](https://github.com/drvasanthi/iiitb_cg#icg---synthesis)  
  4. [GLS Post-simulation](https://github.com/drvasanthi/iiitb_cg#gls-post-simulation)  

III. [**Physical Design from Netlist to GDSII**](https://github.com/drvasanthi/iiitb_cg#iii-physical-design-from-netlist-to-gdsii)  
  1. [Invoke OpenLane](https://github.com/drvasanthi/iiitb_cg#1-invoke-openlane)  
  2. [Synthesis](https://github.com/drvasanthi/iiitb_cg#2-synthesis)     
  3. [Floorplan](https://github.com/drvasanthi/iiitb_cg#2-floorplan)  
  4. [Placement](https://github.com/drvasanthi/iiitb_cg#3-placement)  
  5. [CTS](https://github.com/drvasanthi/iiitb_cg#4-clcok-tree-synthesis-cts)  
  6. [Routing](https://github.com/drvasanthi/iiitb_cg#4-routing)  
  7. [SignOff](https://github.com/drvasanthi/iiitb_cg#4-signoff)  

[**Contributers**](https://github.com/drvasanthi/iiitb_cg#contributors)  
[**Acknowledgment**](https://github.com/drvasanthi/iiitb_cg#acknowledgement)  
[**Contact Information**](https://github.com/drvasanthi/iiitb_cg#contact-information)  
[**Reference**](https://github.com/drvasanthi/iiitb_cg#references)  

  
## **I. Introduction**

The project design is based on Integrated Clock Gating using SKY 130nm technology node. 

  In current VLSI design, the power dissipation is the most important parameter that signifies the need of low power circuits. In most of the ICs clock consumes 30-40 % of total power. So the integrated clock gating logic is used in many synchronous circuits for reducing dynamic power dissipation, by removing the clock signal when the circuit is not in use. 

**Block Diagram and Circuit Diagram**

![blockdiagram](https://user-images.githubusercontent.com/67214592/183288720-9af6827a-cbfa-4f47-8b24-2172c4f7ea01.PNG)

Clock gating is a prevailing technique for lowering clock power is done with help of clock enable signal by powering off the module by a clock. Clock gating functionally requires only an AND gate. The former using of AND gate with clock, the high EN edge may arrive at any time and may not coincide with a clock edge. In that case the output of the AND gate will be a logic ‘1’ for less time than the clock’s duty cycle, in turn end up with a glitch in the clock signal.
To avoid this, a special kind of clock gating cells are used, that synchronizes the EN with a clock edge. These are called as integrated clock gating cells or ICG. In the design gclk is available only when the latch output is high and gclk is held low when en is low as shown in the circuit diagram. Therefore, target the design very close by meeting the PPA (Power, Performance, Area).

![circuitdiagram](https://user-images.githubusercontent.com/67214592/183288729-cf1af368-8624-45e7-b864-e66ad3e6ef99.PNG)

## **II. RTL Design and Synthesis**

### **1. Icarus Verilog (iverilog) & Yosys Installation on Ubuntu**
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
 
## RTL Pre-Simulation

1. To clone the Repository, type the following commands in your terminal.

```html
$ git clone https://github.com/drvasanthi/iiitb_cg

$ cd /home/vasanthidr11/Desktop/iiitb_cg/
```

2. Details information of files

![image](https://user-images.githubusercontent.com/67214592/183938100-3ac9896b-b7f5-49f5-8caf-f5d8e87e89e7.png)

![image](https://user-images.githubusercontent.com/67214592/183938162-c38446f1-5079-4915-91e1-ac469c89cc24.png)

![image](https://user-images.githubusercontent.com/67214592/183938219-de9c115a-8a6e-4159-acd7-12cfd6f6832c.png)

3. To Run the .v file, type the following commands

```html
$ iverilog iiitb_icg.v iiitb_icg_tb.v

$ ./a.out
$VCD info: dumpfile iiitb_icg_tb.vcd opened for output.

$ gtkwave iiitb_icg_tb
```
![RTLicg](https://user-images.githubusercontent.com/67214592/183932716-48dd485e-6e12-4bf6-a658-955cc8b094da.PNG)

## ICG - Synthesis

1. Invoke the yosys using following commands

![image](https://user-images.githubusercontent.com/67214592/183289143-1ecf0702-ef0a-4187-8c6d-531cb8866ba7.png)

```
// reads the library file from sky130//

yosys> read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```

```
// reads the verilog files//

yosys> read_verilog iiitb_icg.v dff.v
```

```
//synthesize the top module of verilog file//  

yosys> synth -top iiitb_icg
```

```
//map the FF library file//

yosys> dfflibmap -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib

```

```
//Generates netlist//

yosys> abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
yosys> stat
```

```
//Simplified netlist//

yosys> flatten
```

```
//Displays the Netlist circuit//

yosys> show
```

**Synthesized Circuit**

![icg_synth](https://user-images.githubusercontent.com/67214592/183945532-d69681e1-295b-4e35-b741-efc7123ddf2c.PNG)

```
//Writing Netlist//

yosys> write_verilog -noattr iiitb_icg_netlist.v
yosys> stat
```

```
//Simplified Netlist - As code dwells with additional switch//

yosys> !gvim iiitb_icg_netlist.v
```

## GLS Post-Simulation

Commands to Invoke GLS

```
$ iverilog -DFUNCTIONAL -DUNIT_DELAY=#1 ../verilog_model/primitives.v ../verilog_model/sky130_fd_sc_hd.v iiitb_icg_synth.v iiitb_icg_tb.v
$ ./a.out
$ gtkwave iiitb.icg_tb.v
```

**Gate Level Simulation**

![glsicg](https://user-images.githubusercontent.com/67214592/183949929-0713fee6-cd95-44b2-b029-dab0a2a2c498.PNG)

## **III. Physical Design from Netlist to GDSII**

### **1. Invoke Openlane**  

```
$ git clone https://github.com/The-OpenROAD-Project/OpenLane.git
```

Pre-request

* GNU Make  
```
$ sudo apt-get install build-essential
$ sudo apt-get install gcc
```

* Python 3.6+ with pip and virtualenv  
```
sudo apt install -y build-essential python3 python3-venv python3-pip
```

* Git 2.22+  
```
sudo apt-get install git
```

* Docker 19.03.12+  

[Docker Installlation Instruction](https://docs.docker.com/engine/install/ubuntu/)


* Setting up OpenLane
```
cd OpenLane/
    make
    make test
```

* Magic Installation
```
$ git clone https://github.com/RTimothyEdwards/magic

$ cd magic

$ ./configure

$ make

$ make install
```

### **2. Synthesis**

Synthesis is process of converting RTL (Synthesizable Verilog code) to technology specific gate level netlist (includes nets, sequential and combinational cells and their connectivity).

a) To start openlane, we open the shell in openLANE_flow(openlane) directory and run the command,

```
& make mount
```
b) Import openlane packages specifying its version and specify the design that we intend to work on, which is iiitb_icg

![pack and prep](https://user-images.githubusercontent.com/67214592/186325966-6d4f1763-9e81-469b-8054-e1b075e11b87.PNG)

This command merges two lefs and places it in a new folder which is named as date and time while running the command, inside directory designs/iiitb_icg/runs/.

c) To invoke synthesis

![run_synth](https://user-images.githubusercontent.com/67214592/186326556-ca78b091-f5c3-47f0-8974-57c7c96f7e03.PNG)

This runs the synthesis where yosys translates RTL into circuit using generic components and abc maps the circuit to Standard Cells.

**Physical Cells**  

![image](https://user-images.githubusercontent.com/67214592/186326669-dacc8deb-731c-4873-aa0d-8273371f07c1.png)

Here we define a term Flop Ratio.

Flop Ratio = Ratio of total number of flip flops  /  Total number of cells present in the design  = 4/8 = 0.5

**Power and Area Report**  

![image](https://user-images.githubusercontent.com/67214592/186327242-487d56e9-3457-4403-ae33-df936387f702.png)

### **2. Floorplan**

Physical design is process of transforming netlist into layout which is manufacture-able [GDS]. Physical design process is often referred as PnR (Place and Route) / APR (Automatic Place & Route). Main steps in physical design are placement of all logical cells, clock tree synthesis & routing. During this process of physical design timing, power, design & technology constraints have to be met. Further design might require being optimized w.r.t area, power and performance.

a) To invoke floorplan

![run_floorplan](https://user-images.githubusercontent.com/67214592/186327462-cf32d89a-a8bd-446b-a144-0432f295e503.PNG)

**Die Area**

![image](https://user-images.githubusercontent.com/67214592/186412089-45f78e52-38ed-4a80-9b31-ad4d2e801df7.png)

**Core Area**

![image](https://user-images.githubusercontent.com/67214592/186331168-59e4dc36-79a0-47c0-ac2d-34c7569f52f6.png)

** Endcap & Tap Cells**

![image](https://user-images.githubusercontent.com/67214592/186331493-b51faae4-7c6b-49e7-84c3-37846fbfd99e.png)

b) Opening Floorplan in MAGIC Tool

To view the floorplan created, we need to open it in magic as follows,

```
$ magic -T /home/vasanthi/Desktop/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.max.lef def read iiitb_icg.def &
```

The above commmand first reads the tech file which is sky130A.tech, reads lef file which is merged.max.lef and def file which is iiitb_icg.def.

![fp1](https://user-images.githubusercontent.com/67214592/186331827-135d234c-b06f-416d-9faf-68f731a5bd45.PNG)

* In the layout, many i/o pins can be seen at the border of the layout, which are equidistant from each other by default.
* Many tap cells can be seen all over the layout, whcih connect n-well to Vdd and substrate to ground to prevent latch-up. These tap cells are diagonllay equidistant from each other.

![fp2](https://user-images.githubusercontent.com/67214592/186331843-fd82da67-49ed-4cd6-96ca-a19ec629d370.PNG)

* A few standard cells can also been at the lower left corner of the layout.

![image](https://user-images.githubusercontent.com/67214592/186412961-0ff8aca9-dafc-4f5f-a3e3-9f5ca2d50b03.png)

### **3. Placement**

In this stage, all the standard cells are placed in the design (size, shape & macro-placement is done in floor-plan). Placement will be driven by different criteria like timing driven, congestion driven, power optimization etc. Timing & Routing convergence depends a lot on quality of placement. 

a) To invoke placement

![run_placeent](https://user-images.githubusercontent.com/67214592/186332290-166089dd-250b-4e0b-a84e-1f4bfd84df7e.PNG)

b) Opening floorplan in MAGIC

```
magic -T /home/vasanthi/Desktop/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech read ../../tmp/merged.max.lef def read iiitb_icg.def &
```

![pl1](https://user-images.githubusercontent.com/67214592/186332510-f4c55a6c-e1e7-4d1d-afbc-1b1bd7342a8a.PNG)

![pl2](https://user-images.githubusercontent.com/67214592/186332524-90356937-fdb8-4b0a-82c2-ba829412077b.PNG)

![image](https://user-images.githubusercontent.com/67214592/186431825-10082f77-f8f3-4008-8973-3a302bc26319.png)

c) Reports

**Area Report**

![image](https://user-images.githubusercontent.com/67214592/186414516-7e03381a-1f7d-4156-85ff-decc64a594a6.png)

**Power Report**

![image](https://user-images.githubusercontent.com/67214592/186414759-b8d07597-d786-4cd4-a263-722a22b11bf3.png)

**Setup and Hold Slack**

![image](https://user-images.githubusercontent.com/67214592/186415190-7eed8e2b-a4eb-4dfa-b59f-c5a4072b5994.png)

### **4. Clcok Tree Synthesis (CTS)**

Clock Tree Synthesis (CTS) is one of the most important stages in PnR. CTS QoR decides timing convergence & power. In most of the ICs clock consumes 30-40 % of total power. So efficient clock architecture, clock gating & clock tree implementation helps to reduce power.

a) To invoke CTS

![run_cts](https://user-images.githubusercontent.com/67214592/186332680-82acf1f8-95a6-4bb4-84a8-938a171d2eef.PNG)

b) Reports

![image](https://user-images.githubusercontent.com/67214592/186417408-773a431b-8237-4190-bffd-88f1b1338b4b.png)

**tns & wns report**

![image](https://user-images.githubusercontent.com/67214592/186417759-8ce45076-e08d-469e-98fb-34f3a4ba7303.png)

**Setup & Hold Report**

![image](https://user-images.githubusercontent.com/67214592/186417880-6d3f3ea5-0fa1-4c99-8627-0998971898d3.png)

**Power Report**

![image](https://user-images.githubusercontent.com/67214592/186418099-cd41488f-4bbe-45e8-b124-21a0e8b10613.png)

**Area Report**

![image](https://user-images.githubusercontent.com/67214592/186418198-efb7d3fd-d494-43ac-9955-16e3132f08fd.png)

### **4. Routing**

Routing is the stage after Clock Tree Synthesis and optimization where-

* Exact paths for the interconnection of standard cells and macros and I/O pins are determined.
* Electrical connections using metals and vias are created in the layout, defined by the logical connections present in the netlist.

After CTS, we have information of all the placed cells, blockages, clock tree buffers/inverters and I/O pins. The tool relies on this information to electrically complete all connections defined in the netlist such that-

* There are minimal DRC violations while routing.
* The design is 100% routed with minimal LVS violations.
* There are minimal SI related violations.
* There must be no or minimal congestion hot spots.
* The Timing DRCs are met.
* The Timing QoR is good.

Routing is performed in two stages:

Fast route - Implemented using FastROAD. It generates routing guides.  
Detailed route - Implemented using TritonRoute. It uses the routing guides generated in fast route to find the best route and makes connections.

a) To Invoke Routing

![run_routing](https://user-images.githubusercontent.com/67214592/186332797-9a888c52-e9f8-4739-b4bc-a248ec35d1bc.PNG)

b) Opening Routing in MAGIC Tool

![image](https://user-images.githubusercontent.com/67214592/186422839-89a1a0f6-bfb9-4670-be28-6ac4befb6269.png)

![image](https://user-images.githubusercontent.com/67214592/186422738-e176d4d1-d696-4f3e-866f-f4f2d81efd41.png)

c) Reports

**Congestion Report**

![image](https://user-images.githubusercontent.com/67214592/186421693-3387e433-7691-4c80-b4af-be8701896760.png)

**tns, wns, setup and hold reports**

![image](https://user-images.githubusercontent.com/67214592/186421908-cc2ebd42-5018-4eb8-82fd-535188d0f026.png)

**Power and Area Report**

![image](https://user-images.githubusercontent.com/67214592/186422008-cc991dd9-5984-4fa7-a17b-c569f0ae7bde.png)

### **4. Signoff**

a) Final GDSII 

![lay2](https://user-images.githubusercontent.com/67214592/186435891-3f149044-e418-438d-a46a-53666b2c7137.PNG)

![lay1](https://user-images.githubusercontent.com/67214592/186435929-8a31ce5c-9633-41c9-80a7-0c36fbd048f5.PNG)

![lay3](https://user-images.githubusercontent.com/67214592/186435950-c6f4a88a-972a-4711-a056-c4c7c0597047.PNG)

b) Report

**Power Report**

![image](https://user-images.githubusercontent.com/67214592/186425781-a12d106a-90e6-4663-9d0e-f3c0f2a75e1a.png)

![image](https://user-images.githubusercontent.com/67214592/186426070-629f8f0b-f323-4017-af1d-2c34ac178719.png)

**Area Report**

![image](https://user-images.githubusercontent.com/67214592/186426223-bda0b4cd-6462-4a4e-86d0-9f99804b0a6c.png)

## Contributors

  * Vasanthi D R
  * Dantu Nandini Devi
  * Kunal Ghosh
  * Madhav Rao
  * Nanditha Rao

## Acknowledgement
  
  * Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.
  * Nickson Jose, VLSI Engineer, VSD Corp. Pvt. Ltd.
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
 
 [4] Openlane - SKY130: https://github.com/The-OpenROAD-Project/OpenLane
 
 [5] Magic Installation: https://github.com/RTimothyEdwards/magic
 
