function val = generate_connection_matrix(connection_string, ... string type
                     input_size, ...
                     gate_matrix_size)
tmp = cell(gate_matrix_size);
matrix_string_size = size(connection_string);

% 1st column:
for y_iter = 1:gate_matrix_size(1)
   tmp{y_iter,1} = get_binary_string_matrix( ....
       connection_string(1+input_size(2)*(y_iter-1):...
                                input_size(2)*(y_iter)) );
end

% other columns:
iter_begin = input_size(2)*gate_matrix_size(1)+1;
for x_iter = 2:gate_matrix_size(2)
    for y_iter = 1:gate_matrix_size(1)
        it = (y_iter-1) + (x_iter-1)*gate_matrix_size(1);
        tmp{y_iter,x_iter} = get_binary_string_matrix(...
            connection_string(iter_begin+gate_matrix_size(1)*(y_iter-1)...
            +(x_iter-2)*gate_matrix_size(1)*gate_matrix_size(1):...
            iter_begin+gate_matrix_size(1)*y_iter-1 ...
            +(x_iter-2)*gate_matrix_size(1)*gate_matrix_size(1) ));   
    end
end

val = tmp;
end