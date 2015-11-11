function val = randomBinaryString(num_size) %output is string
tmp = [];
if num_size(2) < 30
    tmp = dec2bin( round((2^num_size(2)-...
        2^(num_size(2)-1))*rand()...
        +2^(num_size(2)-1))  ); % binary string
else
    for i=1:(round(num_size(2)/30)+1)
        tmp = [tmp dec2bin( round((2^30-...
            2^(30-1))*rand()...
            +2^(30-1)))]; % binary string
    end
end
val = tmp(1:num_size(2));

end