function [W] = LE(M, X, Y)
%Local Estimate, ver: 0.1
    [N p] = size(X);
    tmp = ones(N,1);
    X = [tmp X];
    Q = diag(M);%(:,1));
    W = ((X'*Q*X)^-1*X'*Q*Y)';
end