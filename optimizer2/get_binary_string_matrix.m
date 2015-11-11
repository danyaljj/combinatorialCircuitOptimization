% returns a matrix with dimention 1*length of a string
function val = get_binary_string_matrix( str )
tmp = [];
length = size( str );
for i=1:length(2)
    tmp = [ tmp str2num( str(i) ) ] ;
end
val = tmp;
end