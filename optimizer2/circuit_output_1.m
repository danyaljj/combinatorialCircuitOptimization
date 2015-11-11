function [val, valid, gate_numbers ] = circuit_output_1( connection_matrix,... 
                                 gate_type_matrix,... 
                                 input )
% gate: 
% WIRE(0),AND(1),OR(2),XOR(3),NAND(4)

%% This is stright implementation (not recursive!)
gate_matrix_size = size (gate_type_matrix);
gate_value_matrix = zeros(gate_matrix_size);
%% Validity: 
gate_validity_matrix = ones(gate_matrix_size); % 1:is valid  / 0:is not valid 
for x_iter=1:gate_matrix_size(2)
    for y_iter=1:gate_matrix_size(1)
        if x_iter ==1 
            tmp = cumsum( connection_matrix{y_iter, x_iter} );
        else
                tmp = cumsum( connection_matrix{y_iter, x_iter}...
                    .* gate_validity_matrix(:, x_iter-1)' );
        end
        tmp = tmp(1,end);
%         if gate_type_matrix(y_iter,x_iter) == 0  % Wire: ate least one connection
            if tmp == 0 
                gate_validity_matrix(y_iter, x_iter) = 0;
            end
%         else % not wire: at least 2 connection.
%             if tmp <= 1 
%                 gate_validity_matrix(y_iter, x_iter) = 0;
%             end
%         end 
    end
end
if gate_validity_matrix(1, end) == 0 
    valid = 0;
else
    valid = 1;
end
%% Number of gates used:
gate_usage_matrix = zeros(gate_matrix_size);
if  gate_type_matrix(1,end) ~= 0  % not wire
    gate_usage_matrix(1,end) = 1;
end

for x_iter=gate_matrix_size(2):-1:2
    for y_iter=1:gate_matrix_size(1)
        if gate_usage_matrix(y_iter,x_iter) == 1 ...
            | ( gate_type_matrix(y_iter,x_iter)==0 ...
              & gate_validity_matrix(y_iter, x_iter)==1 )  % or valid wire
            tmp_1 = gate_usage_matrix(:, x_iter-1); % vertical matrix
            tmp_2 = connection_matrix{y_iter, x_iter}';
            tmp = tmp_1 + tmp_2;
            tmp = ( tmp > 0 ); % just 1 and zero!
            tmp = tmp .* gate_validity_matrix(:, x_iter-1);
            tmp_1 = (gate_type_matrix(:, x_iter-1) > 0); % Not wire!
            tmp = tmp .* tmp_1;
            gate_usage_matrix(:,x_iter-1) = tmp;
        end
    end
end
tmp = cumsum(gate_usage_matrix(:));
gate_numbers = tmp(end,1);
%% Main Evaluation:
for x_iter=1:gate_matrix_size(2)
    for y_iter=1:gate_matrix_size(1)
        
        if gate_validity_matrix(y_iter,x_iter) == 0
            continue;  % if gate is not valid, dont calc it's value
        end
        if x_iter == 1 
            % inputs: 
            tmp = connection_matrix{y_iter,1}.*gate_validity_matrix(y_iter,1);
            indices = find(tmp==1);
            switch gate_type_matrix(y_iter,1);
                case 0  % wire 
                    tmp = input(indices);
                    gate_value_matrix(y_iter,1) = tmp(1,1);                
                case 1  % and 
                    gate_value_matrix(y_iter,1)...
                    = matrix_and( input(indices) );
                case 2  % or                  
                    gate_value_matrix(y_iter,1)...
                    = matrix_or( input(indices) );
                case 3  % xor
                    gate_value_matrix(y_iter,1)...
                    = matrix_xor( input(indices) );
                case 4  % nand 
                    gate_value_matrix(y_iter,1)...
                    = matrix_nand( input(indices) );               
                otherwise  % nor 
                    gate_value_matrix(y_iter,1)...
                    = matrix_nor( input(indices) );               
            end
        else
        % prevous gate:
            tmp = connection_matrix{y_iter,x_iter}.*gate_validity_matrix(y_iter,x_iter);
            indices = find(tmp==1);
            switch gate_type_matrix(y_iter,x_iter)
                case 0  % wire 
                    tmp = gate_value_matrix(indices,x_iter-1);
                    gate_value_matrix(y_iter,x_iter) = tmp(1,1);   
                case 1  % and 
                    gate_value_matrix(y_iter,x_iter) ...
                            = matrix_and( gate_value_matrix(indices,x_iter-1)' ); 
                case 2  % or                  
                    gate_value_matrix(y_iter,x_iter) ...
                            = matrix_or( gate_value_matrix(indices,x_iter-1)' );        
                case 3  % xor
                    gate_value_matrix(y_iter,x_iter) ...
                            = matrix_xor( gate_value_matrix(indices,x_iter-1)' );
                case 4 % nand
                    gate_value_matrix(y_iter,x_iter) ...
                            = matrix_nand( gate_value_matrix(indices,x_iter-1)' );               
                otherwise  % nor 
                    gate_value_matrix(y_iter,x_iter) ...
                            = matrix_nor( gate_value_matrix(indices,x_iter-1)' );               
            end
        end
    end
end
% return output
gate_value_matrix;
val = gate_value_matrix(:,gate_matrix_size(2));
end