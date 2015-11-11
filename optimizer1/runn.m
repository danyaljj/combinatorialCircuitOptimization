global in rows cols;
in=4;
rows=5;
cols=5;
%% Plot
figure(1)
axis([0 100 0 1]);
xlabel('Generation')
ylabel('Fittness Value')
title('Accending fittness valus of digital gates in each generation.');
hold on;
pause(0.1)
%% 
a=create_pop(200);
[a,b]=gen(10000,200,a);
fromgui(a{1});
%sum = b(1,:)
%min = b(2,:)
%max = b(3,:)