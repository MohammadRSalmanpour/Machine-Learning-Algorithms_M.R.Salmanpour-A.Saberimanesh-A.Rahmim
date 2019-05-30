function data=LoadData()

%%%%Data file is a matfile included target and inputs
load('Data.mat');

x= Data(1:end-1,:);%%%Inputs

t = Data(end,:);%%%%Output


    data.x=x;
    data.t=t;
    
    data.nx=size(x,1);
    data.nt=size(t,1);
    data.nSample=size(x,2);

end