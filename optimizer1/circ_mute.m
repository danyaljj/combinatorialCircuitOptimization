function M=circ_mute(Ch)
%gate_n=[3 3 3];
gate=6;
global in rows cols;
rand('seed',rand('seed'));
R=rand(100,100);

s(1)=ceil(rand(1,1)*rows);
s(2)=ceil(rand(1,1)*cols);

if s(2)~=1
     c1=ceil(R(:,1)*rows);
     c2=ceil(R(:,2)*(s(2)))-1;%(s(2)-1)*ones(100,1);%c2=ceil(R(:,2)*(s(2)))-1;
     
     c3=ceil(R(:,3)*rows);
     c4=ceil(R(:,4)*(s(2)))-1;%(s(2)-1)*ones(100,1);%c4=ceil(R(:,4)*(s(2)))-1;
     c5=floor(R(:,5)*gate);
     
     c1=(c2~=0).*c1+(c2==0).*ceil(R(:,20)*in);%INPUT problem
     c3=(c4~=0).*c3+(c4==0).*ceil(R(:,21)*in);%INPUT problem

     c3=(c5~=0).*c3+c1.*(c5==0);%WIRE problem
     c4=(c5~=0).*c4+c2.*(c5==0);%WIRE problem
else
    c1=ceil(rand(10,1)*in);
     c3=ceil(rand(10,1)*in);
     c2=zeros(10,1);c4=zeros(10,1);
     c5=floor(rand(10,1)*gate);
     
     c3=(c5~=0).*c3+c1.*(c5==0);%WIRE problem
end

B=[(c1(1:rows)) (c2(1:rows)) (c3(1:rows)) (c4(1:rows)) c5(1:rows)];
M=Ch;
% s(3)=ceil(rand(1,1)*3);
% Bp=M{s(1),s(2)};
% switch s(3)
%     case 1
%         Bp(1)=B(2,1);
%     case 2
%         Bp(3)=B(2,3);
%     case 3
%         Bp(5)=B(2,5);
% end
% %Bp(s(3))=B(2,s(3));

%M(:,s(2))=mat2cell(B,ones(1,rows),5);

M{s(1),s(2)}=B(2,:);
end