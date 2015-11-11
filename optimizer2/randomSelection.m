function gen_out = randomSelection( gen_, pop_size, fit_sum )

gen_size = size(gen_);

%% Rearrange gens with a biased value: x-> x/2+1
cum_fitness(1,1) = 1;
cum_fitness(1,2) = 0;
for i=2:gen_size(1)
    cum_fitness(i,1) = 1; % Uniform weight ! 
    cum_fitness(i,2) = 0; % Not selected !
end

%% Summation
gen_tmp = cell(pop_size, 6);
% Select the 5 % best ones to transfer strightly!
it = round(pop_size* 0.05);
%it = 10;
gen_tmp(1:it,:) = gen_(end-it+1:end,:);  % create offspring
cum_fitness(end-it:end,2) = 1;  % Selected !
it = it+1;

%% Selection
while it <= pop_size % loop until new population is full
    rnd = round( rand()*(gen_size(1)-round(pop_size* 0.05)- 2) )+1;
    if  cum_fitness(rnd,2) == 0 % Not selected till now
        gen_tmp(it,:) = gen_(rnd,:);  % create offspring
        it = it+1;
        cum_fitness(rnd,2) = 1;  % Selected !
    end
end
gen_out = gen_tmp;
end