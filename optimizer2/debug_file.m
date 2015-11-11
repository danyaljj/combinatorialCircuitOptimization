clear all
% matrix_and(input)
%matrix_and([ 1 1 1 1 0 ])

% function initial_gen = generateInitialGeneration( pop_size, ...
%                         gate_matrix_size,...
%                         gate_string_size,...
%                         gate_types )  % Range of gate types!
a = generateInitialGeneration( 10, [2 2], [1 2], 4 );

%get_binary_string_matrix( '1234' );

% generate_connection_matrix(connection_string, input_size...
%                    , gate_matrix_size)
random_str = '1111111111111';
input = [1 1];
a=generate_connection_matrix( random_str, size(input), [2 2]);

% function val = circuit_output_1( connection_matrix,... 
%                                  gate_type_matrix,... 
%                                  input )
% WIRE(0),AND(1),OR(2),XOR(3),NAND(4)
gate_type_matrix = [ 1 2 ; 0 4 ];
circuit_output_1( a, gate_type_matrix, input )

truth_table = [0 0 0
               1 1 1
               1 0 1
               1 1 1
               0 1 0 
               1 0 1 
               1 1 0 
               1 1 1 ];
output = [ 1 0 0 0 1 0  0 0 ]  % horizantal
% function val = fittness_output_1( truth_table, output, ...
%     connection_string, gate_type_matrix )
fittness_output_1( truth_table, output, random_str, gate_type_matrix )

%% test 2 
% Half adder:
connection_str = '10011100';
truth_table =[ 0 0
               0 1 
               1 0 
               1 1 ];          
gate_type_matrix = [ 0 3 ; 0 0 ];
c_m = generate_connection_matrix(connection_str,[1 2],  [2 2]);
% function val = generate_connection_matrix(connection_string,...
%                      input_size, ...
%                      gate_matrix_size)
circuit_output_1( c_m, gate_type_matrix,truth_table(1,:))

% WIRE(0),AND(1),OR(2),XOR(3),NAND(4), NOR(5)

%% 1 input!
% function val = generate_connection_matrix(connection_string, ... string type
%                      input_size, ...
%                      gate_matrix_size)
connection_str = '101001';
gate_type_matrix = [0,0;2,3];
a = generate_connection_matrix( connection_str, [1 1], [2 2]);
input = [0]
circuit_output_1( a, gate_type_matrix, input )

%% 2 input
connection_str = '111110100110010011010000';
gate_type_matrix = [3,0;2,5;3,4;3,2];
a = generate_connection_matrix( connection_str, [1 2], [4 2]);
input = [1 0]
circuit_output_1( a, gate_type_matrix, input )

%% 3 input
truth_table = [0 0 0
    0 0 1
    0 1 0
    0 1 1
    1 0 0
    1 0 1
    1 1 0
    1 1 1];
output = [0 1 1 0 1 0 0 1 ];
connection_str = '1100011111';
gate_type_matrix = [3,3;0,0];
a = generate_connection_matrix( connection_str, [1 3], [2 2]);
circuit_output_1( a, gate_type_matrix, truth_table(4,:) );
[val, distance, gate_number, valid] = fittness_output_1( truth_table, ...
            output, connection_str,gate_type_matrix )
%% 3 Input : 
truth_table = [0 0 0
    0 0 1
    0 1 0
    0 1 1
    1 0 0
    1 0 1
    1 1 0
    1 1 1];
output = [ 0 0 0 1 0 1 1 0 ];  % Carlos:4 gate/me: 3 gates. 
connection_str = '111111001110110010';
gate_type_matrix = [5,5;3,3;3,2];
a = generate_connection_matrix( connection_str, [1 3], [3 2]);
circuit_output_1( a, gate_type_matrix, truth_table(4,:) );

[val, distance, gate_number, valid] = fittness_output_1( truth_table, ...
            output, connection_str,gate_type_matrix )
%% 4 Variable:
truth_table = [0 0 0 0
    0 0 0 1
    0 0 1 0
    0 0 1 1
    0 1 0 0
    0 1 0 1
    0 1 1 0
    0 1 1 1
    1 0 0 0
    1 0 0 1
    1 0 1 0
    1 0 1 1
    1 1 0 0
    1 1 0 1
    1 1 1 0
    1 1 1 1 ];
output = [ 1 1 0 1 0 0 1 1 1 0 1 0 0 1 0 0 ];  % 2 (6 gate)
connection_str = '011001001000101111000000001000011011000000000000';
gate_type_matrix = [1 3 3; 0 0 0; 0 0 0; 2 0 0];
a = generate_connection_matrix( connection_str, [1 4], [4 3]);
val_t = [];
for i=1:16
[val, valid, gate_numbers ] = circuit_output_1( a, gate_type_matrix, truth_table(i,:) );
val_t = [ val_t  val(1,1) ];
end
disp( val_t );

[val, distance, gate_number, valid] = fittness_output_1( truth_table, ...
            output, connection_str,gate_type_matrix )
        
        
%% 4 Variable:
truth_table = [0 0 0 0
    0 0 0 1
    0 0 1 0
    0 0 1 1
    0 1 0 0
    0 1 0 1
    0 1 1 0
    0 1 1 1
    1 0 0 0
    1 0 0 1
    1 0 1 0
    1 0 1 1
    1 1 0 0
    1 1 0 1
    1 1 1 0
    1 1 1 1];
output = [ 1 1 0 1 0 0 1 1 1 0 1 0 0 1 0 0 ];  % 2 (6 gate) 
connection_str = '110110110111101001010101101000';
gate_type_matrix = [3,3,3;5,0,5;4,4,0];
a = generate_connection_matrix( connection_str, [1 4], [3 3]);
for i=5:5
[val, valid, gate_numbers ] = circuit_output_1( a, gate_type_matrix, truth_table(i,:) );
disp( val(1,1) )
end
[val, distance, gate_number, valid] = fittness_output_1( truth_table, ...
            output, connection_str,gate_type_matrix )
        

        
        %% 4 Variable:
truth_table = [0 0 0 0
    0 0 0 1
    0 0 1 0
    0 0 1 1
    0 1 0 0
    0 1 0 1
    0 1 1 0
    0 1 1 1
    1 0 0 0
    1 0 0 1
    1 0 1 0
    1 0 1 1
    1 1 0 0
    1 1 0 1
    1 1 1 0
    1 1 1 1];
output = [ 1 0 1 0 1 0 1 1 1 1 1 0 0 1 1 1 ];  % 4: carlos: Toward: 2nd Example 
connection_str = '111100101001110111100010011110';
gate_type_matrix = [0,1,0;4,2,1;5,1,0];
a = generate_connection_matrix( connection_str, [1 4], [3 3]);
for i=1:16
[val, valid, gate_numbers ] = circuit_output_1( a, gate_type_matrix, truth_table(i,:) );
disp( val(1,1) )
end
[val, distance, gate_number, valid] = fittness_output_1( truth_table, ...
            output, connection_str,gate_type_matrix )
        
       
 %% 5 input: 
 connection_str = ...
     '11110001110000011101011100010010010101000101101010101001000010100010';
gate_type_matrix = [3,5,1,5;3,1,2,4;0,2,0,3;2,2,0,4;];
a = generate_connection_matrix( connection_str, [1 5], [4 4]);
circuit_output_1( a, gate_type_matrix, truth_table(4,:) );

[val, distance, gate_number, valid] = fittness_output_1( truth_table, ...
            output, connection_str,gate_type_matrix )

%%  test costume
        
 connection_str = ...
     '1001101001011110100010001001001010111101010100110110100000100010';        
a = generate_connection_matrix( connection_str, [1 4], [4 4]);%%


        
 