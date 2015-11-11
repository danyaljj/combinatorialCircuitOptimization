function [val,jj]=cceval(G,r,c,I)
global ii;
global cols;
if c==cols
ii=0;
end

if (c==0)
    val=I(r);
    return;
end

B=G{r,c};

%if B(2)==0
 %   val=I(B(1));
  %  return;
%end

            switch B(5)
                case 0%WIRE
                    val=cceval(G,B(1),B(2),I);
                case 1%AND
                    a=cceval(G,B(3),B(4),I);
                    b=cceval(G,B(1),B(2),I);
                    val=a&&b;
                    ii=ii+1;
                case 2%OR
                   
                    a=cceval(G,B(3),B(4),I);
                    b=cceval(G,B(1),B(2),I);
                    val=a||b;
                    ii=ii+1;
                case 3%XOR
                   
                    a=cceval(G,B(3),B(4),I);
                    b=cceval(G,B(1),B(2),I);
                    val=xor(a,b);
                    ii=ii+1;
                case 4%NAND
                   
                    a=cceval(G,B(3),B(4),I);
                    b=cceval(G,B(1),B(2),I);
                    val=~(a&&b);
                    ii=ii+1;
                case 5%NOR
                   
                    a=cceval(G,B(3),B(4),I);
                    b=cceval(G,B(1),B(2),I);
                    val=~(a||b);
                    ii=ii+1;
            end
jj=ii;
end

