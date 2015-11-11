% just horizantal matrixes ! 
function val = matrix_xor(input)
input_size = size(input);
if input_size(2) == 1
   val = 0; 
else
    tmp = input(1);
    for i=2:input_size(2)
        tmp = xor(input(i),tmp);
    end
    val = tmp;
end
end