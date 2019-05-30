function [ Mu ] = phi( X, C, V )
[N p] = size(X);
s = size(C,1);
h = ones(N,1);
Mu = ones(N,s);
for i=1:s
    for ii=1:p
        Mu(:,i) = Mu(:,i).*exp(-.5.*(X(:,ii)-(C(i,ii)*h)).^2./(V(i,ii)*h));
    end
end
Mu = Mu./(repmat(sum(Mu,2),1,s));
end