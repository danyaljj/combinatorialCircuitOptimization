function fromgui(G)
fid=fopen('E:\Projects&Researchs\2010_MinimizingDigitalGates\gui\gui_1_7\input.txt','wt');
global rows cols in;
% % % for i=1:size(G,1)
% % %     for j=1:size(G,2)
% % %         disp(G{i,j});
% % %         F=G{i,j};
% % %         switch F(5)
% % %             case 1
% % %                 F(5)=2;
% % %             case 2
% % %                 F(5)=3;
% % % 
% % %             case 3
% % %                 F(5)=6;
% % % 
% % %             case 5
% % %                 F(5)=5;
% % %         end
% % %         fprintf(fid,'%d %d %d %d %d %d %d\n',[j i F(2) F(1) F(4) F(3) F(5)]);
% % %     end
% % % end
cceval(G,rows,cols,zeros(1,in));
for i=1:size(gates)
    F=gates(i,:);
    switch F(5)
        case 1
            F(5)=2;
        case 2
            F(5)=3;

        case 3
            F(5)=6;

        case 5
            F(5)=5;
    end
    fprintf(fid,'%d %d %d %d %d %d %d\n',[F(7) F(6) F(2) F(1) F(4) F(3) F(5)]);
end
fclose('all');
function [val,jj]=cceval(G,r,c,I)
global ii;

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
                    gates(ii+1,:)=[B r c];
                    ii=ii+1;
                case 1%AND
                    a=cceval(G,B(3),B(4),I);
                    b=cceval(G,B(1),B(2),I);
                    val=a&&b;
                    gates(ii+1,:)=[B r c];
                    ii=ii+1;
                case 2%OR
                   
                    a=cceval(G,B(3),B(4),I);
                    b=cceval(G,B(1),B(2),I);
                    val=a||b;
                    gates(ii+1,:)=[B r c];
                    ii=ii+1;
                case 3%XOR
                   
                    a=cceval(G,B(3),B(4),I);
                    b=cceval(G,B(1),B(2),I);
                    val=xor(a,b);
                    gates(ii+1,:)=[B r c];
                    ii=ii+1;
                case 4%NAND
                   
                    a=cceval(G,B(3),B(4),I);
                    b=cceval(G,B(1),B(2),I);
                    val=~(a&&b);
                    gates(ii+1,:)=[B r c];
                    ii=ii+1;
                case 5%NOR
                   
                    a=cceval(G,B(3),B(4),I);
                    b=cceval(G,B(1),B(2),I);
                    val=~(a||b);
                    gates(ii+1,:)=[B r c];
                    ii=ii+1;
            end
jj=ii;
end
end



