function [fit, g_distance, gate_number, valid] = fittness_output_1( truth_table,...
    output, connection_string, gate_type_matrix )
%%Weights
truth_weight = 15;       %how output is correct
wire_weight = 1;        %minimum number of gates

%%
% gate:
% WIRE(0),AND(1),OR(2),XOR(3),NAND(4), NOR(5)

evolved_circuit_output=[];
wire_gate_population = cumsum(~gate_type_matrix(:));
wire_gate_population = wire_gate_population(end);
gate_matrix_size = size(gate_type_matrix);
truth_table_size = size( truth_table );
connection_matrix = generate_connection_matrix(connection_string, ...
    [ 1 truth_table_size(2)], gate_matrix_size);

%% This is stright implementation (not recursive!)
for iter=1:truth_table_size(1)
    [ cir_val cir_valid gate_number ] = circuit_output_1( connection_matrix, gate_type_matrix,...
        truth_table(iter,:));
    evolved_circuit_output = [ evolved_circuit_output cir_val];
end
valid = cir_valid;

evolved_circuit_output = evolved_circuit_output(1,:); % just first output

%output
% return output = (1-distance/table_length)*a1+(wire/gate_pop)*1
distance = cumsum(abs(evolved_circuit_output-output));
distance = distance(end);
g_distance = distance;
if cir_valid ==1
    if 0
        fit = (1-distance/truth_table_size(1))*truth_weight;
        fit = fit / ( truth_weight);
    else
        fit = (1-distance/truth_table_size(1))*truth_weight ...
            + (1- gate_number/(gate_matrix_size(1)*gate_matrix_size(2)))*wire_weight;
        fit = fit / ( truth_weight  + wire_weight ); % Normalized up to one.
    end
else
    fit = 0;  %% not a valid gate!
end
end