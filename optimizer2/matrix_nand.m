% just horizantal matrixes ! 
function val = matrix_nand(input)
input_size = size(input);
if input_size(2) == 1
    val = ~input(1);
else
    tmp = input(1);
    for i=2:input_size(2)
        tmp = and(input(i),tmp);
    end
    val = ~tmp;
end
end