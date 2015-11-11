function gen_out = rouletteWheelSelection( gen_, pop_size, fit_sum )

gen_size = size(gen_);

%% Rearrange gens with a biased value: x-> x/2+1
fit_sum = 0;
for i=1:gen_size(1)
    gen_{i,3} = (gen_{i,3}+1)/2; 
    fit_sum = fit_sum + gen_{i,3};
end

cum_fitness(1,1) = gen_{1,3}/fit_sum;
cum_fitness(1,2) = 0;
for i=2:gen_size(1)
    cum_fitness(i,1) = gen_{i,3}/fit_sum + cum_fitness(i-1,1);
    cum_fitness(i,2) = 0; % Not selected !
end

%% Summation
gen_tmp = cell(pop_size, 6);
% Select the 5 % best ones to transfer strightly!
it = round(pop_size* 0.05);
gen_tmp(1:it,:) = gen_(end-it+1:end,:);  % create offspring
cum_fitness(end-it:end,2) = 1;  % Selected !
it = it+1;

%% Selection
while it <= pop_size % loop until new population is full
    rnd = rand();
    for i=2:gen_size(1)
        if rnd < cum_fitness(i,1)  % This is it !
            if  cum_fitness(i-1,2) == 0 % Not selected till now
                gen_tmp(it,:) = gen_(i-1,:);  % create offspring
                it = it+1;
                cum_fitness(i-1,2) = 1;  % Selected !
            end
            break; % break it. Eventhough it is not selected ....
        end
    end 
end
gen_out = gen_tmp;
end