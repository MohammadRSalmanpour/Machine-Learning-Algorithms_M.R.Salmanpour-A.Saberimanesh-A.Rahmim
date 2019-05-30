function F = phiMCH(X)
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
end
