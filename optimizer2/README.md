# Circuit Optimizer 

Main loop is in file `main.m`. So you can start from there! 

# Description of files

- `circuit_output_1.m`:  calculates output of one circuit when input is given.
- `crossover.m`: crossovers a circuit.
- `fittness_output_1.m`: calculates fitness for one special circuit.
- `get_binary_string_matrix.m`:  generates initial generation. So it is used in initializing the algorithm in `main.m`
- `mutate.m`: It is used for mutating a circuit.
- `randomSelection.m`: This is a kind heuristic selection. Specific ratio of best generations are selected and transferred to 
next generation directly and remaining is selected randomly. It is sometimes
used for increasing diversity between solution moving in search space.
- `rouletteWheenlSelectiom.m`:  welknown roulette wheel algorithm used same as above function for increasing diversity of answers. 
- `matrix_nand.m`, `matrix_and.m`, `matrix_or.m`, `matrix_xor.m`: These are functions for implementing several input( or matrix input ) digital gates using 2 input ones. 
- `debug_file.m`: This file is just used for debuging! So this is not used everytime in the main process.


