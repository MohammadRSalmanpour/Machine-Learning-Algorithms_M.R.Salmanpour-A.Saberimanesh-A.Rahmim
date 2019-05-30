close all;
%clear all;
clc;
% Xtmp = Xtrn(end,:);
% last = netFeed(C,V,W,Xtmp);

% for i=1:10
%     Xtmp(1,1:13) = Xtmp(1,2:end);
%     last = netFeed(C,V,W,Xtmp);
%     prd(i,1) = last;
%     Xtmp(1,14) = last;
% end
% hold on
% plot(prd)
% plot(Xprd)
% hold off
hold on
plot(Ytst(1:end-1,:),'b-');
plot(Yh2(1:end-1,:),'r-');
hold off