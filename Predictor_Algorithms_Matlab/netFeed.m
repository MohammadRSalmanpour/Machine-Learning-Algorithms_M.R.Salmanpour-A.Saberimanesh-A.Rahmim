function [Yh] = netFeed(C ,V, W ,X)
    s1 = size(X);
    X1 = [ones(s1(1,1),1) X];
    %s2 = size(F);
    Yh = sum(phi(X,C,V).*(X1*W'),2);
end