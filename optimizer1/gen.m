function [po,Fit]=gen(n,samp,pop)
tic
global in rows cols;
I=zeros(1,in);
roul_size=20000;
%pop=create_pop(samp);
pop2=cell(1,samp);
pop3=pop2;
F=ones(1,2*samp);
gaten=F;
Fit=zeros(3,2*samp);

crs=0.2*samp;%ceil(0.6*samp);
mut=samp-crs;%ceil((samp-crs)*0.8);
%mut=0;
for i=1:n
    disp(i);%
    %while (sum(F)~=0)
    for k1=1:crs
        r=ceil(rand(1,4)*samp);
        pop2{k1}=circ_cross(pop{r(1)},pop{r(2)});
        
    end
    
    for k2=1:mut
        r=ceil(rand(1,4)*samp);
        
        pop2{k2+crs}=circ_mute(pop{r(3)});
    end
    
    for k3=1:samp-mut-crs
        r=ceil(rand(1,4)*samp);
        
        pop2{k3+crs+mut}=pop{r(4)};
    end
    
    %     for k4=1:ceil(mut/1.25)
    %         r=ceil(rand(1,4)*samp);
    %
    %         pop{samp-k4+1}=circ_mute(pop{r(1)});
    %     end
    %
    %     for k5=1:ceil(crs/1.25)
    %         r=ceil(rand(1,4)*samp);
    %
    %         pop{samp-ceil(mut/2)-k5+1}=circ_cross(pop{r(1)},pop{r(2)});
    %     end
    %%%%%%%%%%%%%%%%%Roulet Select;
    
    %%%%%%%%%%%%%%%%%best_fit;
    for j=1:samp
        
        F(j)=fit_circ(pop{j});
        %[val,gate1]=cceval(pop{j},1,4,I);
        %[val,gate2]=cceval(pop{j},2,4,I);
        %[val,gate3]=cceval(pop{j},3,4,I);
        [val,gate4]=cceval(pop{j},rows,cols,I);
        gaten(j)=gate4;%+gate2+gate3+gate4;
    end
    for j=1:samp
        
        F(samp+j)=fit_circ(pop2{j});
        %[val,gate1]=cceval(pop2{j},1,4,I);
        %[val,gate2]=cceval(pop2{j},2,4,I);
        %[val,gate3]=cceval(pop2{j},3,4,I);
        [val,gate4]=cceval(pop2{j},rows,cols,I);
        gaten(samp+j)=gate4;%+gate2+gate3+gate4; &Multi Input
    end
    
    %disp(F(1:40));
    %pause;
    
    f=(10*F/2^in+gaten/31)/11;
    %f=F/16;
    %%%%%%%%%%%%%%%%%%%%Roulette's Wheel
    % % %     [B,ix]=sort(f);
    % % %     elites=4;%0.02*2*samp;
    % % %     ix=ix(elites+1:2*samp);
    % % %     Roul=zeros(0,0);
    % % %     for j=1:2*samp-elites
    % % %         Roul=[Roul ix(j)*ones(1,ceil(roul_size*(1-f(ix(j)))/sum((1-f(ix)))))];
    % % %     end
    % % %     %disp(Roul);
    % % %    %pause;
    % % %     sel=ceil(rand(1,samp-elites)*roul_size);
    % % %     ix(elites+1:samp)=Roul(sort(sel));
    [B,ix]=sort(f);
    elites=0.1*samp;
    ixn=ix(1:elites);
    ixp=ix(elites+1:end);
    
    % %     sel=ceil(rand(1,samp-elites)*roul_size);
    % %     Roul=zeros(0,0);
    % %     idx=Roul;
    % %     for k=1:samp-elites
    % %         sfix=sum(1-f(ixp));
    % %         nixp=numel(ixp);
    % %         for j=1:nixp
    % %             addi=ones(1,ceil(roul_size*(1-f(ixp(j)))/sfix));
    % %             Roul=[Roul ixp(j)*addi];
    % %             idx=[idx j*addi];
    % %         end
    % %         selected(elites+k)=Roul(sel(k));
    % %         ixp(idx(sel(k)))=[];
    % %         disp(k);
    % %     end
    sel=rand(1,samp-elites);
    for j=1:samp-elites
        prob=sqrt(1-f(ixp))/sum(sqrt(1-f(ixp)));
        cumprob=cumsum(prob);
        
        selected=sum(cumprob<=sel(j));
        if selected==0%%%%%%%%%%???????????????????????????????????????????????
            selected=1;
        end
        %disp(selected);
        ixn=[ixn ixp(selected)];
        ixp(selected)=[];
    end
    ix=ixn;
    
    %    disp(ixn);
    %ix=sort(ix);
    %ix=ix(1:samp);
    %%%%%%%%%%%%%%
    %     if (i==-1) & (F(ix)==zeros(1,length(F(ix))))%#ok<AND2>
    %         [B,ix]=sort(gaten);
    %        ix=ix(1:samp);
    %     for j=1:samp
    %         if ix(j)<=samp
    %             pop3{j}=pop{ix(j)};
    %         end
    %         if ix(j)>samp
    %             pop3{j}=pop2{ix(j)-samp};
    %         end
    %
    %     end
    %     else
    %     %%%%%%%%%%%%%%
    %     [B,ix]=sort(f);
    %     ix=ix(1:samp);
    %     %disp(ff(pop));
    %     %pause
    for j=1:samp
        if ix(j)<=samp
            pop3{j}=pop{ix(j)};
        end
        if ix(j)>samp
            pop3{j}=pop2{ix(j)-samp};
        end
        
    end
    %     %disp(ff(pop3));
    %     %pause;
    %     end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%
    pop=pop3;
    %fromgui(pop{1});
    
    %disp('/////');
    %for l=1:30
    %disp(fit_circ(pop{l}));
    %end
    % pause;
    Fit(1,i)=sum((f(ixn)));Fit(2,i)=min(f(ixn));Fit(3,i)=max(f(ixn)); %%%%IN OON KHATTE KEH YAROU RO TOLID MIKONEH
    %% Plot
plot(1-Fit(2,1:i), '--b', 'LineWidth', 2)
plot(1-Fit(1,1:i)/200, '--g', 'LineWidth', 2)
plot(1-Fit(3,1:i), '--r', 'LineWidth', 2)
if i==1
   legend('Best Fittness','Mean Fittness', 'Worst Fitness','Location', 'SouthEast');
end
    pause(0.1);
    
    %for i=1:20
    %   disp(['Individual: ' i  Fit(1,i)   ])
    %end
    
    if mod(i,5)==0 
        fromgui(pop{1});
    end
    
end
%[B,ix]=sort(f);
%ix=ix(1:samp);


po=pop;
%Fit=f(ix);%ff(po);%B;%ff(po);%B;%f(ix);

toc;

end