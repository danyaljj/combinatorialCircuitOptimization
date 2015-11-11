function gen = mutate( gen, mutation_pop, crossover_pop,...
    population_size,...
    gate_matrix_size, connection_string_size )
%% one-point mutation:
rnd = rand();
gen_size = size(gen);
gen_rnd_index = round(rnd*(gen_size(1)-1))+1;

% if rem( gen_rnd_index,2 )==0
    %%
    % connection_string:
    con_string_rnd_index = round(rnd*(connection_string_size(2)-1))+1;
    for i=1:mutation_pop
        gen_size = size(gen);
        gen_tmp = gen(rem(i+gen_rnd_index,population_size)+1,:);
        string_tmp = gen_tmp{1,1};
        if string_tmp(con_string_rnd_index) == '1'
            string_tmp(con_string_rnd_index) = '0';
        else
            string_tmp(con_string_rnd_index) = '1';
        end
        gen_tmp{1,1} = string_tmp;
        gen(gen_size(1)+1,:) = gen_tmp;  %% add it to gens!
    end
% else
    % gate_matrix:
    x_rnd = round( rnd * (gate_matrix_size(2)-1)+1);
    y_rnd = round( rnd * (gate_matrix_size(1)-1)+1);
    for i=1:mutation_pop
        gen_size = size(gen);
        gen_tmp = gen(rem(i+gen_rnd_index,population_size)+1,:);
        matrix_tmp = gen_tmp{1,2};
        matrix_tmp(y_rnd,x_rnd) = rem( round( matrix_tmp(y_rnd,x_rnd)*...
            rnd*10),6 );  % 0-5 types of gates
        gen_tmp{1,2} = matrix_tmp;
        gen(gen_size(1)+1,:) = gen_tmp; % add it to gens
    end
%  end
end
