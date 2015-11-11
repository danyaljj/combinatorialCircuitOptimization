function pop=create_pop(n)
global cols rows;
for i=1:n
    pop{i}=create_chromosome(rows,cols);
end


end