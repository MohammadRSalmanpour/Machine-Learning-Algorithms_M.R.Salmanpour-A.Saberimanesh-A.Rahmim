function [I ] = LLS( M,X,Y,W)
%The local loss summation of the i-th locla linear model, ver 0.1

    tmp = ones(size(X,1),1);
    X   = [tmp X];
    s   = size(M,2);

    for i = 1:s
        I(i,1) = M(:,i)'*(Y(:,1) - X*W(i,:)').^2;
    end
    I = sum(I);
end