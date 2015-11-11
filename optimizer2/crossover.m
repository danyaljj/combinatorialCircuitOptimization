function gen = crossover( gen, mutation_pop, crossover_pop,...
    population_size, gate_matrix_size, connection_string_size )
%%
rnd = rand();
gen_size = size(gen);
gen_rnd_index = round(rnd*(gen_size(1)-1))+1;

%% gate_matrix:
rnd_x = round(rnd*(gate_matrix_size(2)-1))+1;

for i=1:crossover_pop
    gen_size = size(gen);
    gen_tmp_1 = gen(rem(i+gen_rnd_index,population_size)+1,:);
    gen_tmp_2 = gen(rem(i+gen_rnd_index+1,population_size)+1,:);
    matrix_tmp_1 = gen_tmp_1{1,2};
    matrix_tmp_2 = gen_tmp_2{1,2};
    gen_tmp_1{1,2} = [ matrix_tmp_1(:,1:rnd_x) matrix_tmp_2(:,(rnd_x+1):end)];
    gen_tmp_2{1,2} = [ matrix_tmp_2(:,1:rnd_x) matrix_tmp_1(:,(rnd_x+1):end)];
    gen(gen_size(1)+1,:) = gen_tmp_1;
    gen(gen_size(1)+2,:) = gen_tmp_2;
end

%gate_string:
rnd_index = round( rnd*(connection_string_size-1)+1 )+1;

for i=1:crossover_pop
    gen_size = size(gen);
    
    gen_tmp_1 = gen(rem(i+gen_rnd_index,population_size)+1,:);
    gen_tmp_2 = gen(rem(i+gen_rnd_index+1,population_size)+1,:);
    string_tmp_1 = gen_tmp_1{1,1};
    string_tmp_2 = gen_tmp_2{1,1};
    gen_tmp_1{1,1} = [ string_tmp_1(1,1:rnd_index)...
        string_tmp_2(1,rnd_index+1:end)];
    gen_tmp_2{1,1} = [ string_tmp_2(1,1:rnd_index)...
        string_tmp_1(1,rnd_index+1:end)];
    gen(gen_size(1)+1,:) = gen_tmp_1;
    gen(gen_size(1)+2,:) = gen_tmp_2;
end
end
