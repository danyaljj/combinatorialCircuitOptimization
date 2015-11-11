function G=create_chromosome(rows,cols)

    %in=4;
    global in;
    gate=6;
R=rand(30,30);
     c1=ceil(R(:,1)*in);%c1=ceil(rand(10,1)*in);

     c3=ceil(R(:,3)*in);%c3=ceil(rand(10,1)*in);

     c2=zeros(10,1);c4=zeros(10,1);
     c5=floor(R(:,1)*gate);%c5=floor(rand(10,1)*gate);

     
     c3=(c5~=0).*c3+c1.*(c5==0);%WIRE problem
      
     B=[(c1(1:rows)) (c2(1:rows)) (c3(1:rows)) (c4(1:rows)) c5(1:rows)];
     G=mat2cell(B,ones(1,rows),5);
     
     L=~(B==0);
     gate_n(1)=sum(L(:,5));
    for i=2:cols
        R=rand(30,30);
     c1=ceil(R(:,11)*rows);%c1=ceil(rand(10,1)*rows);

     c2=ceil(R(:,12)*i)-1;%(i-1)*ones(30,1);%c2=ceil(R(:,12)*i)-1;%c2=ceil(rand(10,1)*(i))-1;

     
     c3=ceil(R(:,13)*rows);%c3=ceil(rand(10,1)*rows);
%gate_n(i-1));
     c4=ceil(R(:,14)*i)-1;%(i-1)*ones(30,1);%c4=ceil(R(:,14)*i)-1;%c4=ceil(rand(10,1)*(i))-1;

     c5=floor(R(:,15)*gate);%c5=floor(rand(10,1)*gate);

      c1=(c2~=0).*c1+(c2==0).*ceil(R(:,20)*in);%INPUT problem
     c3=(c4~=0).*c3+(c4==0).*ceil(R(:,21)*in);%INPUT problem
     
     c3=(c5~=0).*c3+c1.*(c5==0);%WIRE problem
     c4=(c5~=0).*c4+c2.*(c5==0);%WIRE problem
     
     B=[(c1(1:rows)) (c2(1:rows)) (c3(1:rows)) (c4(1:rows)) c5(1:rows)];
     
     G=[G mat2cell(B,ones(1,rows),5)];
     
     L=~(B==0);
     gate_n(i)=sum(L(:,5));
    end

    %disp(circ_eval(G));
end