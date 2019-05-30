close all;
clear all;
clc;

% X = [1 2 3];
% s1 = size(X,2);
% tmp = diag(X)*triu(repmat(X,s1,1),0);
% F = [];
% 
% for i=0:s1-1
%     F = [F; diag(tmp,i)];
% end
% F = [F; X']

X = rand(4,3);
[N p] = size(X);
F = [];
for i=1:N
    tmp = diag(X(i,:))*triu(repmat(X(i,:),p,1),0);
    tmpF = [];    
    for ii=0:p-1
        tmpF = [tmpF diag(tmp,ii)'];
    end
    tmpF = [tmpF X(i,:)];
    F = [F; tmpF];
end
