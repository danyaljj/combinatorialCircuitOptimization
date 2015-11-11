function gen = sortGens(gen, population)
% This sorts gens based on their 3rd collumns descending.(worst to best)
isSwaped = 1;
while isSwaped == 1
    isSwaped = 0;
    for i=1:(population-1)
        if gen{i,3} > gen{i+1,3}
            isSwaped = 1; % true
            tmp_cell = gen(i,:);
            gen(i,:) = gen(i+1,:);
            gen(i+1,:) = tmp_cell;
        end
    end
end
end