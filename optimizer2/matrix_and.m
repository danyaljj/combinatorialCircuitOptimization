% just horizantal matrixes ! 
function val = matrix_and(input)
input_size = size(input);
tmp = 1;
    for i=1:input_size(2)
        tmp = and(input(i),tmp);
    end
val = tmp;    
end