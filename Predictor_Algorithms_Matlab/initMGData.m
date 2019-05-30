function [X Y Xtrn Ytrn Xvld Yvld ] = initMGData()

data = xlsread('sample490.xlsx','Sheet1');
load target
target=target';

data=data';
%%Generating 4D Mackey Glass data.
for i=1:490
    for ii=1:13
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
h = ones(size(X,1),1);
X = (X-h*mean(X))./(h*var(X).^.5);

Xtrn    = X(1:245,1:13);
Ytrn    = X(1:245,1560);

Xvld    = X(246:490,1:13);
Yvld    = X(246:490,1560);

Y = X(:,1560);
X = X(:,1:13);