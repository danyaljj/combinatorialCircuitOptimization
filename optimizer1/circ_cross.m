function [Ch1c,Ch2c]=circ_cross(Ch1,Ch2)

global rows cols;
    s(1)=ceil(rand(1,1)*rows);
    s(2)=ceil(rand(1,1)*cols);
    Ch1c=Ch1;
    Ch2c=Ch2;
    %Ch1c(:,s(2))=Ch2(:,s(2));
    %Ch2c(:,s(2))=Ch1(:,s(2));
    
    Ch1c(:,1:s(2))=Ch2(:,1:s(2));
    Ch2c(:,1:s(2))=Ch1(:,1:s(2));
end