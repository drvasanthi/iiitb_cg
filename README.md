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
  2. [To Build Inverter Standard Cell Design](https://github.com/drvasanthi/iiitb_cg#2-to-build-inverter-standard-cell-design)  
  3. [Synthesis](https://github.com/drvasanthi/iiitb_cg#3-synthesis)      
  4. [Floorplan](https://github.com/drvasanthi/iiitb_cg#4-floorplan)  
  5. [Placement](https://github.com/drvasanthi/iiitb_cg#5-placement)  
  6. [CTS](https://github.com/drvasanthi/iiitb_cg#6-clcok-tree-synthesis-cts)  
  7. [Routing](https://github.com/drvasanthi/iiitb_cg#7-routing)  
    
[**Author**](https://github.com/drvasanthi/iiitb_cg#author)  
[**Reference**](https://github.com/drvasanthi/iiitb_cg#references)  
[**Contributers**](https://github.com/drvasanthi/iiitb_cg#contributors)  
[**Acknowledgment**](https://github.com/drvasanthi/iiitb_cg#acknowledgement)  
[**Contact Information**](https://github.com/drvasanthi/iiitb_cg#contact-information)  


  
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

Physical design is process of transforming netlist into layout which is manufacture-able [GDS]. Physical design process is often referred as PnR (Place and Route). Main steps in physical design are placement of all logical cells, clock tree synthesis & routing. During this process of physical design timing, power, design & technology constraints have to be met. Further design might require being optimized w.r.t power, performance and area.

General Physical Design Flow:

![image](https://user-images.githubusercontent.com/67214592/187185624-7162a2b4-18f8-4bb6-bf8c-d30a1c554cf6.png)

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
$ sudo apt-get install m4  
$ sudo apt-get install tcl-dev  
$ sudo apt-get install tk-dev  
$ sudo apt-get install blt  
$ sudo apt-get install freeglut3  
$ sudo apt-get install libglut3  
$ sudo apt-get install libglu1-mesa-dev  
$ sudo apt-get install libgl1-mesa-dev  
$ sudo apt-get install csh  
$ ./configure  
$ make  
$ make install  
```

### **2. To Build Inverter Standard Cell Design**

  > Step 1: Invoke vsdstdcelldesign  
   
  ![image](https://user-images.githubusercontent.com/67214592/187136304-46165f15-f911-4c1f-b886-108bb54ab371.png)

  > Step 2: 
  
  ![Capture](https://user-images.githubusercontent.com/67214592/187136598-8b29f43f-45ed-4c4b-b6f9-249d102c34c6.PNG)
  
  ![image](https://user-images.githubusercontent.com/67214592/187137154-e7eecd44-1a01-4cc9-bd31-1ea6f47c94e1.png)

  > Step 3:
  
  To simulate the inverter, we need a .spice file corresponding to the .mag file. We first extract the .mag file, whcih creates a .ext file in the same directory.
  
  ![extarct](https://user-images.githubusercontent.com/67214592/187137243-328e405b-7c1e-485a-b88d-e2af45ded44e.PNG)
  
  ![ext file](https://user-images.githubusercontent.com/67214592/187137318-d8c2d52e-216c-418a-95fe-eac47c71342e.PNG)

  > Step 4:
  
  Then we convert the .ext into .spice including all the parasitics.
  
  ![spice](https://user-images.githubusercontent.com/67214592/187137402-3edffa84-1a1b-4a55-a8c4-2667925e6a7c.PNG)
  
  ![spice 1](https://user-images.githubusercontent.com/67214592/187137467-05361008-df4f-4339-bba9-e91026425bc9.PNG)
  
  > Step 5:
    
  Edit the .spice file to include model files, define power supply nodes and parasitics
  
  ![image](https://user-images.githubusercontent.com/67214592/187138406-b5e480c8-dc2d-492d-ad5c-0af76f0827f3.png)
  
  > Step 6:
  
  Runing the simulation in ngspice
  
  ```  
  ngspice sky130_inv.spice  
  
  plot y vs time a
  
  ```  
  ![waveform1](https://user-images.githubusercontent.com/67214592/187140137-3411fa26-ca97-4265-b53d-f879c2b30445.PNG)

  ![waveform](https://user-images.githubusercontent.com/67214592/187139544-73b2f369-bd1b-4c47-a363-93d4ffd9c164.PNG)
  
  > Step 7: 
  
  To check whether the first guideline is followed by our inverter, we identify the input and output ports and check if they lie on the intersection of tracks of the corresponding metal by aligning the grids in MAGIC layout to that of the tracks using the grid command in tkcon window. In our case, the porst lie on licon metal, so we align the `grid` corresponding to those values,
  
  ![grid initial](https://user-images.githubusercontent.com/67214592/187139784-c0cf1a4d-85f2-431f-ab3c-fbab65545fce.PNG)
  
  ![grid1](https://user-images.githubusercontent.com/67214592/187139833-456630f3-9e74-42d5-92f4-3a5833603322.PNG)
  
  > Step 8:
  
  Extract the lef file by typing the command in tkcon window
  
  ![lef write](https://user-images.githubusercontent.com/67214592/187140038-fc6ab403-094b-4673-808f-16ab33139040.PNG)
  
  ![lef file](https://user-images.githubusercontent.com/67214592/187140064-e04a8851-93a8-43ab-8da4-eeb12f42ca17.PNG)
  
  Save the file
  
  ![same mag](https://user-images.githubusercontent.com/67214592/187140281-5f8ffa09-9fd9-42e5-a3b6-7418b8fa6c8c.PNG)
  
  > Step 9:
  
  Copy the .lef file and .lib file to the source directory of main design
  
  ```
  vasanthi@vasanthi-VirtualBox:~/Desktop/OpenLane/vsdstdcelldesign/libs$ cp sky130_vsdinv.lef /home/vasanthi/Desktop/OpenLane/designs/iiitb_icg/src
  
  vasanthi@vasanthi-VirtualBox:~/Desktop/OpenLane/vsdstdcelldesign/libs$ cp sky130_fd_sc_hd__* /home/vasanthi/Desktop/OpenLane/designs/iiitb_icg/src
  
  ```
  
  ![image](https://user-images.githubusercontent.com/67214592/187141055-56c7d6a4-5ad5-4755-b9da-aaab1bb24b75.png)
  
### **3. Synthesis**

Synthesis is process of converting RTL (Synthesizable Verilog code) to technology specific gate level netlist (includes nets, sequential and combinational cells and their connectivity).

  > Step1: To start openlane, we open the shell in openLANE_flow(openlane) directory and run the command,
  
  ![image](https://user-images.githubusercontent.com/67214592/187149282-80b98d3c-82d2-40b6-a752-f02be949f654.png)
  
  > Step 2:Import openlane packages specifying its version and specify the design that we intend to work on, which is iiitb_icg
  
  ![pack and prep](https://user-images.githubusercontent.com/67214592/186325966-6d4f1763-9e81-469b-8054-e1b075e11b87.PNG)
  
  This command merges two lefs and places it in a new folder which is named as date and time while running the command, inside directory designs/iiitb_icg/runs/.
  
  > Step 3: Include the below command to include the additional lef into the flow:
  
  ![image](https://user-images.githubusercontent.com/67214592/187150066-0151166f-aa7f-4f3b-a766-41ba1b18122c.png)
  
  > Step 4: To invoke synthesis
  
  ![image](https://user-images.githubusercontent.com/67214592/187151843-4175edfa-a478-4e39-971b-16b4761cdd14.png)
  
  This runs the synthesis where yosys translates RTL into circuit using generic components and abc maps the circuit to Standard Cells.
  
  **Physical Cells**  
  
  ![physical cell](https://user-images.githubusercontent.com/67214592/187151993-a1bad438-fcf8-48ad-861c-6dc3298a7ac9.PNG)
  
  * Calcuation of Flop Ratio:
  
  ```
  
  Flop ratio = Number of D Flip flops 
             ______________________
             Total Number of cells
  
  Flop Ratio = 4/8=0.5
  ```
  
  **Power and Area Report**  
  
  ![image](https://user-images.githubusercontent.com/67214592/187152989-6354b999-5cef-4c76-a123-13f676af0b15.png)

### **4. Floorplan**

Physical design is process of transforming netlist into layout which is manufacture-able [GDS]. Physical design process is often referred as PnR (Place and Route) / APR (Automatic Place & Route). Main steps in physical design are placement of all logical cells, clock tree synthesis & routing. During this process of physical design timing, power, design & technology constraints have to be met. Further design might require being optimized w.r.t area, power and performance.

  > Step 1: To invoke floorplan
  
  ![fp run1](https://user-images.githubusercontent.com/67214592/187153230-2fc88096-d71e-4ffa-b9ea-3b283fdb8833.PNG)
  
  * **Die Area**
  
  ![image](https://user-images.githubusercontent.com/67214592/187153594-bec9d6a9-f40f-4dc2-a99a-6e0b46f17845.png)
  
  * **Core Area**
  
  ![image](https://user-images.githubusercontent.com/67214592/187153756-198d8808-a39d-49c2-8b50-035e01b0d927.png)
  
  * **Endcap & Tap Cells**
  
  ![image](https://user-images.githubusercontent.com/67214592/187153967-544ae1f6-ee7b-463e-827e-b38f520c0669.png)
  
  > Step 2: Opening Floorplan in MAGIC Tool
  
  To view the floorplan created, we need to open it in magic as follows,
  
  ![image](https://user-images.githubusercontent.com/67214592/187172555-8e6fd9da-1330-48b4-9892-c126865829b0.png)
  
  The above commmand first reads the tech file which is sky130A.tech, reads lef file which is merged.max.lef and def file which is iiitb_icg.def.
  
  ![fp1](https://user-images.githubusercontent.com/67214592/187172242-aa415fb8-3440-4081-a625-ac5b7eab8525.PNG)
  
  * In the layout, many i/o pins can be seen at the border of the layout, which are equidistant from each other by default.
  
  * * Many tap cells can be seen all over the layout, whcih connect n-well to Vdd and substrate to ground to prevent latch-up. These tap cells are diagonllay equidistant from each other.
  
  ![fp2](https://user-images.githubusercontent.com/67214592/187172290-e711dac8-36ff-4bbb-826b-c44dec289063.PNG)
  
  * A few standard cells can also been at the lower left corner of the layout.
  
  ![fp3](https://user-images.githubusercontent.com/67214592/187172689-3e99cbef-87a4-4b2a-883e-ccfa529316cc.PNG)

### **5. Placement**

In this stage, all the standard cells are placed in the design (size, shape & macro-placement is done in floor-plan). Placement will be driven by different criteria like timing driven, congestion driven, power optimization etc. Timing & Routing convergence depends a lot on quality of placement. 

  > Step 1:To invoke placement
  
  ![pl run1](https://user-images.githubusercontent.com/67214592/187173740-f3192e75-bc0a-4cb1-a5bd-0bfe10f79b29.PNG)
  
  > Step 2: Opening floorplan in MAGIC
  
  ```  
  magic -T /home/vasanthi/Desktop/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech read ../../tmp/merged.max.lef def read iiitb_icg.def &  
  ```
  
  ![pl1](https://user-images.githubusercontent.com/67214592/187173982-20451f42-7cb6-49a5-8ab2-609867d891be.PNG)
  
  * sky130_vsdinv inside integrated clock gating design
  
  ![pl2](https://user-images.githubusercontent.com/67214592/187174253-75b11182-3fec-4ea4-a500-06c18c7c96ff.PNG)
  
  ![pl3](https://user-images.githubusercontent.com/67214592/187174305-e047e129-22fe-4eeb-aa6f-8e6ea439a90e.PNG)
  
  > Step 3: Reports
  
  **Area Report**
  
  ![image](https://user-images.githubusercontent.com/67214592/187174952-77f7cd2f-8c6e-4211-9ce1-71e6ad696e6c.png)
  
  **Power Report**
  
  ![image](https://user-images.githubusercontent.com/67214592/187175099-2d76c5e6-ac6c-4518-896a-f5e4f9f8e44d.png)
  
  **Setup and Hold Slack**
  
  ![image](https://user-images.githubusercontent.com/67214592/187175229-4c875f84-c1d0-4f27-9e11-b39e3f9b1673.png)

### **6. Clcok Tree Synthesis (CTS)**

Clock Tree Synthesis (CTS) is one of the most important stages in PnR. CTS QoR decides timing convergence & power. In most of the ICs clock consumes 30-40 % of total power. So efficient clock architecture, clock gating & clock tree implementation helps to reduce power.

  > Step 1: To invoke CTS
  
  ![cts run1](https://user-images.githubusercontent.com/67214592/187175341-c4577af6-f188-49b6-b0b6-97b2cab26b63.PNG)
  
  > Step 2: Reports
  
  ![image](https://user-images.githubusercontent.com/67214592/187176246-b1f8c24a-00e0-47ab-a9d8-ef89c709302f.png)
  
  * **tns & wns report**
  
  ![image](https://user-images.githubusercontent.com/67214592/187176405-c3f89f4c-20f0-4fec-920d-a56ca82c59d0.png)
  
  * **Setup & Hold Report**
  
  ![image](https://user-images.githubusercontent.com/67214592/187176618-1466f415-789d-4d48-9436-901ef26213c4.png)
  
  * **Power & Area Report**
  
  ![image](https://user-images.githubusercontent.com/67214592/187176775-1d35c6c5-47f2-48ca-9189-f11fc32153de.png)

### **7. Routing**

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

  * Fast route - Implemented using FastROAD. It generates routing guides.  
  * Detailed route - Implemented using TritonRoute. It uses the routing guides generated in fast route to find the best route and makes connections.

  > Step 1: To Invoke Routing
  
  ![routing run1](https://user-images.githubusercontent.com/67214592/187177152-f2bb745b-6e55-4fc9-8e9f-5640ed5ddcb9.PNG)
  
  > Step 2: Opening Routing in MAGIC Tool
  
  ```
  magic -T /home/vasanthi/Desktop/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech read ../../tmp/merged.max.lef def read iiitb_icg.def & 
  ```
  
  * Post Layout
  
  ![r1](https://user-images.githubusercontent.com/67214592/187178696-c0c9a94c-db4f-4243-b2a9-849d5dc8b458.PNG)
  
  ![R2](https://user-images.githubusercontent.com/67214592/187178742-5ff5c596-bc2f-4f70-8bb4-4fce3a3a5df6.PNG)
  
  ![image](https://user-images.githubusercontent.com/67214592/187410313-0a2f1873-c17f-41a4-9796-d3967fbe27ad.png)
  
  > Step 3: Reports
  
  * **Congestion Report**
  
  ![image](https://user-images.githubusercontent.com/67214592/187178339-3370eb0b-9c7b-49d1-a89c-6873a17a486b.png)
  
  * **tns, wns, setup and hold reports**
  
  ![image](https://user-images.githubusercontent.com/67214592/187178472-28c4ae19-d854-4aec-b3ab-9592838fe902.png)
  
  * **Power and Area Report**
  
  ![image](https://user-images.githubusercontent.com/67214592/187178598-cbd0933b-43d4-4722-832e-52d9b8fd2393.png)
  

# **PARAMETER ANALYSIS**

> 1. Post-Layout Synthesis: Gate count & Flop ratio

![gatecount](https://user-images.githubusercontent.com/67214592/192341497-391380c0-71c3-445d-a116-e2ee1eb82013.PNG)

**Gate Count = 8**

Flop ratio = Number of D Flip flops 
             ______________________
             Total Number of cells
  
**Flop Ratio = 4/8 = 0.5**

> 2. Area

![box](https://user-images.githubusercontent.com/67214592/192341782-f9583a3b-a3d8-4ea0-8bf8-e449866304b3.PNG)

**Area = 2336.147um2**

> 3. Performance

![1](https://user-images.githubusercontent.com/67214592/192342240-ced0374c-c080-48b0-bbcb-be64305ff73a.PNG)

![2](https://user-images.githubusercontent.com/67214592/192342267-d0a93ca0-9c9f-480a-b0e1-9485d83bbfd7.PNG)

> 4. Power

![image](https://user-images.githubusercontent.com/67214592/187178598-cbd0933b-43d4-4722-832e-52d9b8fd2393.png)

**Internal Power = 1.24e-04 W**
**Switching Power = 2.39e-05 W**
**Leakage Power = 2.06e-10 W**
**Total Power = 1.48e-04 W**



## Author

Vasanthi D R

## References
 
 [1] VLSI System Design: https://www.vlsisystemdesign.com/
 
 [2] SkyWater SKY130 PDK: https://skywater-pdk.readthedocs.io/en/main/contents/libraries/foundry-provided.html
 
 [3] RTL Design using Verilog with Sky130 Technology: https://www.vsdiat.com/dashboard
 
 [4] Openlane - SKY130: https://github.com/The-OpenROAD-Project/OpenLane
 
 [5] Magic Installation: https://github.com/RTimothyEdwards/magic
 
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
  
 
