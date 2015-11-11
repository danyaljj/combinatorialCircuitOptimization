% just horizantal matrixes ! 
function val = matrix_or(input)
input_size = size(input);
tmp = 0;
    for i=1:input_size(2)
        tmp = or(input(i),tmp);
    end
val = tmp;    
end