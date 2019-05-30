function [W P] = RLE(M, X, Y)
%Recurssive Local Estimate. Ver 0.2
%Author: Abdolreza Shirvani.
    L       = 1;
    [N p]   = size(X);
    X       = [ones(N,1) X];
    W       = zeros(p+1,1);
    P   = 10^9*eye(p+1);
    I   = eye(p+1);
    
%    R = 10^3*eye(p+1);
    

    for i = 1:N
%         R = (L*(R^-1) + X(i,:)'*M(i,1)*X(i,:))^-1;
%         W = W   + R*X(i,:)'*M(i,1)*(Y(i,:) - X(i,:)*W);
        g = 1/(X(i,:)*P*X(i,:)'+L/M(i,1))*P*X(i,:)';
        P = 1/L*(I-g*X(i,:))*P;
        W = W + g*(Y(i,:) - X(i,:)*W);
    end
end