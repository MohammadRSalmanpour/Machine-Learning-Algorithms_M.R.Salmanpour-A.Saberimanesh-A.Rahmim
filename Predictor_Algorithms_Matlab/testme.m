clc;
clear

data = xlsread('sample490.xlsx','Sheet1');
data=data';
%%Generating 4D Mackey Glass data.
for i=1:490
    for ii=1:1559
        a=i+(ii-1)*(ii-1);
        b=i+8;
        if a<=490 
        X(i,ii)     = data(i+(ii-1)*(ii-1),3);
        end
        if b<=490
        X(i,ii+1)   = data(i+8,3);
        end
    end
end