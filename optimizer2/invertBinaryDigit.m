function val = invertBinaryDigit( num, ith )
    if (( round(num/10^(ith-1))*10^(ith-1) - round(num/10^(ith))*10^(ith) )...
                        /10^(ith-1) ) == 1  % digit is 1 ! 
        num = num  - 10^(ith-1);
        %10^(ith-1)
        disp(' Here I am ! ')
    else
        num = num + 10^(ith-1);
        %10^(ith-1)
    end
val = num;
end