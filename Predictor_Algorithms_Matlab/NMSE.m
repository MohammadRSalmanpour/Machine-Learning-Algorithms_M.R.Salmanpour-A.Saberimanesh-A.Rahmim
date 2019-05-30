function [e] = NMSE(Ytrn,Yhat)
meany = mean(Ytrn);

e = sum((Ytrn-Yhat).^2)/sum((Ytrn-meany).^2);