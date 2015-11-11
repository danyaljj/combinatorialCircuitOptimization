function f=ff(a)
for i=1:100
    %[x,y]=cceval(a{i},1,4,[0 0 0 0 0]);
    f(i)=fit_circ(a{i});%(10*fit_circ(a{i})/16+y/15);
    
end
end