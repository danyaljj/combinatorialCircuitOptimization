# Digital Gate Visualizer 

You can use this tool to visualize your combinatorial circuits.


## How it works 
The visualizer reads from `input.txt` and visualizes it. 
If you design another system for optimizing circuits, you just need to write the output of your system in the `input.txt`. 

Each line of the input.txt is as following: 
```
(gate_x, gate_y, input1_x, input1_y, input2_x, input2_y, gate_type )
```

The possible values that gate_type can take are the followings: 
```
0:WIRE 1:NOT 2:AND 3:OR 4:NAND 5:NOR 6:XOR 7:XNOR
```

## Pre-compiled files 
If you problems in compiling this code, use the binary version [here](http://web.engr.illinois.edu/~khashab2/files/2010_GeneticCombinationalCircuits/gui_1_7_release.rar
) (compiled under Windows Vista). 

## Code for optimizing combinatorial circuits 

In addition to the the visualizer, we have two MATLAB systems which design and optimize the circuit. The codes are available [here](http://web.engr.illinois.edu/~khashab2/GACombinatorial.html).  
Each of the the MATLAB codes optimize a circuit and outputs it in a file: `input.txt`  (or some other name which can be renamed to `input.txt`). 

Happy circuit-optimizing! :) 


