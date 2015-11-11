function [Tp,gaten]=circ_eval(G)

global rows cols in;
gaten=0;
Tp=zeros(max(in,rows),cols+1);

for m=1:rows
    for n=1:cols
        B=G{m,n};
        %disp([ m n]);
        if (B(5)~=0) %& ([B(1) B(2)]~=[B(3) B(4)])
            gaten=gaten+1;
        end
    end
end

for i=0:2^in-1

    a=[dec2bin(i,in)  dec2bin(0,(rows-in)*(rows-in>=0))];
    %%%%%%%%%%%%%%%%%
    T=zeros(max(in,rows),cols+1);%T=zeros(rows,cols+1);
    %m=1;
    
    T(:,1)=str2num(a'); %#ok<ST2NM>
%    T(:,1)=str2num(['0' '0' '0']');
    for n=1:rows
            B=G{n,1};
            
            switch B(5)
                case 0%WIRE
                    T(n,2)=T(B(1),1);
                case 1%AND
                    T(n,2)=T(B(1),1)&&T(B(3),1);
                case 2%OR
                    T(n,2)=T(B(1),1)||T(B(3),1);
                case 3%XOR
                    T(n,2)=xor(T(B(1),1),T(B(3),1));
                case 4%NAND
                    T(n,2)=~(T(B(1),1)&&T(B(3),1));
                case 5%NOR
                    T(n,2)=~(T(B(1),1)||T(B(3),1));
            end
    end
%disp(T);
    for m=2:cols
        for n=1:rows 
            B=G{n,m};
            
            switch B(5)
                case 0
                    T(n,m+1)=T(B(1),B(2)+1);
                case 1
                    T(n,m+1)=T(B(1),B(2)+1)&&T(B(3),B(4)+1);
                case 2
                    T(n,m+1)=T(B(1),B(2)+1)||T(B(3),B(4)+1);
                case 3
                    T(n,m+1)=xor(T(B(1),B(2)+1),T(B(3),B(4)+1));
                case 4
                    T(n,m+1)=~(T(B(1),B(2)+1)&&T(B(3),B(4)+1));
                case 5
                    T(n,m+1)=~(T(B(1),B(2)+1)||T(B(3),B(4)+1));
            end
        end
 %       disp(T);
    end
    %%%%%%%%%%%%%%%%%
    %disp(T);
    Tp(:,i+1)=T(:,cols+1);
end
end