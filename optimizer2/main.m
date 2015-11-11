%find(x>0)
%%
% Ctrl + R: to comment
% Ctrl + T: to ucomment !

clear all
%% algorithm specifications:
reproduction_ratio = 1;  % 1-reproduction_ratio = transfer_ratio
crossover_ratio = 0.5; % 1-crossover_ratio = mutation_ratio
max_generation_iterations = 10000; % number of iterations
gate_types = 5;  % 5 type of gates
% WIRE(0),AND(1),OR(2),XOR(3),NAND(4), NOR(5)

%% 1 Variable!
% truth_table = [0; 1];
% output = [0 1];  % wire
%% 2 Variable:
% truth_table = [0 0
%     0 1
%     1 0
%     1 1];
% % Half adder:
% output = [0 1 1 1 ];  % horizantal
%% 3 Variable:
% truth_table = [0 0 0
%     0 0 1
%     0 1 0
%     0 1 1
%     1 0 0
%     1 0 1
%     1 1 0
%     1 1 1 ];
% truth_table_size = size(truth_table);
% population_size = 70;
% gate_matrix_size = [round(truth_table_size(2)/2)+1 round(truth_table_size(2)/2)];
% % output = [0 1 1 0 1 0 0 1 ];  % Full Adder(Sum):
% % output = [0 0 0 1 0 1 1 1 ];  % Full Adder(Carry):
% output = [ 0 0 0 1 0 1 1 0 ];  % Carlos:4 gate/me: 3 gates. 

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
truth_table_size = size(truth_table);

% gate_matrix_size = [round(truth_table_size(2)/2+1) round(truth_table_size(2)/2)+2];
% population_size = 70;
% range : 2 * 2 
% output = [0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ];  % A+B+C+D : ok
% output = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 ];  % A.B.C.D : ok
% output = [0 1 1 0 1 0 0 1 1 0 0 1 0 1 1 0 ];  % xor(A,B,C,D) :ok
% output = ~[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 ]; % ~(A.B.C.D) : ok
% gate_matrix_size = [round(truth_table_size(2)/2+2) round(truth_table_size(2)/2)+1];
% population_size = 120;
% output = ~[0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ];  % ~(A+B+C+D) : ok 
% output = [ 1 1 0 0 1 0 1 1 1 1 1 0 0 1 0 0 ];  % 1
% output = [ 1 0 1 0 1 1 1 1 0 1 0 1 0 1 0 1 ];  % 2   ?1
% output = [ 1 0 0 1 1 1 0 0 1 1 1 0 0 1 0 1 ];  % 3  ?2
% output = [ 1 0 0 0 1 0 1 1 1 1 0 0 0 1 0 1 ];  % 4``?2
% output = [ 0 0 0 0 0 0 1 0 1 1 1 0 0 1 0 1 ];  % 5  ?1
% output = [ 0 1 0 0 0 0 1 0 0 1 0 0 0 1 0 1 ];  % 6 ?2
output = [ 0 0 1 0 0 0 1 0 0 1 1 0 0 1 0 1 ];  % 7 ?2



% Unsolved!
population_size = 100;
gate_matrix_size = [round(truth_table_size(2)/2)+2  round(truth_table_size(2)/2)+1];
% output = [ 1 0 1 0 1 0 1 1 1 1 1 0 0 1 1 1 ];  % 4: carlos: Toward: 2nd Example 
output = [ 1 0 0 0 1 1 1 1 1 1 1 0 0 1 0 1 ];  % 3 (6 gate)
% output = [ 1 1 0 1 0 0 1 1 1 0 1 0 0 1 0 0 ];  % 2 (6 gate)


%% 5 Variables:
% truth_table = [0 0 0 0 0
%                0 0 0 0 1
%                0 0 0 1 0
%                0 0 0 1 1
%                0 0 1 0 0
%                0 0 1 0 1
%                0 0 1 1 0
%                0 0 1 1 1
%                0 1 0 0 0
%                0 1 0 0 1
%                0 1 0 1 0
%                0 1 0 1 1
%                0 1 1 0 0
%                0 1 1 0 1
%                0 1 1 1 0
%                0 1 1 1 1
%                1 0 0 0 0
%                1 0 0 0 1
%                1 0 0 1 0
%                1 0 0 1 1
%                1 0 1 0 0
%                1 0 1 0 1
%                1 0 1 1 0
%                1 0 1 1 1
%                1 1 0 0 0
%                1 1 0 0 1
%                1 1 0 1 0
%                1 1 0 1 1
%                1 1 1 0 0
%                1 1 1 0 1
%                1 1 1 1 0
%                1 1 1 1 1 ];
% truth_table_size = size(truth_table);
% population_size = 200;
% output = [0 ones(1,31) ];  % A+B+C+D+E   
%% 6 Variables:
% truth_table = [0 0 0 0 0 0
%                0 0 0 0 0 1
%                0 0 0 0 1 0
%                0 0 0 0 1 1
%                0 0 0 1 0 0
%                0 0 0 1 0 1
%                0 0 0 1 1 0
%                0 0 0 1 1 1
%                0 0 1 0 0 0
%                0 0 1 0 0 1
%                0 0 1 0 1 0
%                0 0 1 0 1 1
%                0 0 1 1 0 0
%                0 0 1 1 0 1
%                0 0 1 1 1 0
%                0 0 1 1 1 1
%                0 1 0 0 0 0
%                0 1 0 0 0 1
%                0 1 0 0 1 0
%                0 1 0 0 1 1
%                0 1 0 1 0 0
%                0 1 0 1 0 1
%                0 1 0 1 1 0
%                0 1 0 1 1 1
%                0 1 1 0 0 0
%                0 1 1 0 0 1
%                0 1 1 0 1 0
%                0 1 1 0 1 1
%                0 1 1 1 0 0
%                0 1 1 1 0 1
%                0 1 1 1 1 0
%                0 1 1 1 1 1
%                1 0 0 0 0 0
%                1 0 0 0 0 1
%                1 0 0 0 1 0
%                1 0 0 0 1 1
%                1 0 0 1 0 0
%                1 0 0 1 0 1
%                1 0 0 1 1 0
%                1 0 0 1 1 1
%                1 0 1 0 0 0
%                1 0 1 0 0 1
%                1 0 1 0 1 0
%                1 0 1 0 1 1
%                1 0 1 1 0 0
%                1 0 1 1 0 1
%                1 0 1 1 1 0
%                1 0 1 1 1 1
%                1 1 0 0 0 0
%                1 1 0 0 0 1
%                1 1 0 0 1 0
%                1 1 0 0 1 1
%                1 1 0 1 0 0
%                1 1 0 1 0 1
%                1 1 0 1 1 0
%                1 1 0 1 1 1
%                1 1 1 0 0 0
%                1 1 1 0 0 1
%                1 1 1 0 1 0
%                1 1 1 0 1 1
%                1 1 1 1 0 0
%                1 1 1 1 0 1
%                1 1 1 1 1 0
%                1 1 1 1 1 1];
% truth_table_size = size(truth_table);
% output = [0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 ...
%     0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 ...
%     0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 ...
%     0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 ];  % horizantal

%%
% truth_table_size = size(truth_table);
% gate_matrix_size = [2 2];
% gate_matrix_size = [round(truth_table_size(2)/2+2) round(truth_table_size(2)/2)+1];
input_size = truth_table_size(2);
% binary sequencce size = input*y + (x-1)*y*y
connection_string_size = gate_matrix_size(1)*input_size...
    +gate_matrix_size(1)*gate_matrix_size(1)*(gate_matrix_size(2)-1);
connection_string_size = [1 connection_string_size ]
% |--  |--  |--
% |--  |--
% |--  |--

%% Initial Population
gen = generateInitialGeneration( population_size, ...
    gate_matrix_size,...
    connection_string_size,...
    gate_types );

% function initial_gen = generateInitialGeneration( pop_size, ...
%                         gate_matrix_size,...
%                         gate_string_size,...
%                         gate_types )  % Range of gate types!
% a = generateInitialGeneration( 10, [3 4], [1 5], 4 );

% figure(1);
% axis([0 100 0 1]);
% xlabel('Generation')
% ylabel('Fittness Value')
% title('Accending fittness valus of digital gates in each generation.');
% hold on;
best_fit_log = [];
worst_fit_log = [];
mean_fit_log = [];

%% Optimization Loop
for i=1:max_generation_iterations
    disp(['generation: ' num2str(i)]);
    %% Crossover:
    gen = crossover( gen, round((1-crossover_ratio)*reproduction_ratio...
        *population_size), round(crossover_ratio...
        *reproduction_ratio*population_size),...
        population_size,...
        gate_matrix_size,...
        connection_string_size);
    %     function gen = crossover( gen, mutation_pop, crossover_pop,...
    %     population_size, gate_matrix_size, connection_string_size )
    
    %% Mutation:
    gen = mutate( gen, round((1-crossover_ratio)*reproduction_ratio...
        *population_size), round(crossover_ratio...
        *reproduction_ratio*population_size),...
        population_size,...
        gate_matrix_size,...
        connection_string_size);
    %     function gen = mutate( gen, mutation_pop, crossover_pop, population_size,...
    %                             gate_matrix_size, connection_string_size )
    
    %     gen_tmp = generateInitialGeneration( population_size, ...
    %     gate_matrix_size,...
    %     connection_string_size,...
    %     gate_types );
    %     gen = [gen(:,1:2) ; gen_tmp];
    %% Evaluation:
    % Evaluation fittness value for each generation
    gen_size = size(gen);
    fitness_sum = 0;
    for j=1:gen_size(1)
        [val, distance, gate_number, valid] = fittness_output_1( truth_table, ...
            output, gen{j,1}, gen{j,2} );
        gen{j,3} = val;
        fitness_sum = fitness_sum + val;
        gen{j,4} = distance;
        gen{j,5} = gate_number;
        gen{j,6} = valid;
    end
    %% Sorting:
    % input('Press ENTER to sort!...');
    gen = sortGens(gen, gen_size(1))
    best_fit_log = [ best_fit_log  gen{end,3} ];
    worst_fit_log = [worst_fit_log  gen{1,3} ];
    mean_fit_log = [ mean_fit_log fitness_sum/gen_size(1)];
    
%     gen(end-6:end,:)
    %% Selecting bests:
    %input('Press ENTER to select!...');
    % Select the best:
%      if rem(i,10) == 0
%          gen = gen(end-population_size+1:end,:)
%      end   
    % Roulette-Wheele Selection:
    
    gen = randomSelection(gen, population_size, fitness_sum);
%     gen = rouletteWheelSelection(gen, population_size, fitness_sum);
    %function gen_out = rouletteWheelSelection( gen_, pop_size, fit_sum )

    % input('Press ENTER to run next generation!...');
    %% Plot the results:
%      plot(i, gen{end,3}, '-r')
%          if rem(i,5)==0
%               input('Continue?!');
%          end
end
