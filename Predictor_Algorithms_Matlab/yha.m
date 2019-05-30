clear all
close all
clc
load Yh2_test2
yh3=Yh2;
for i=1:75
    if Yh2(i)<0
        yh3(i)=0;
    elseif Yh2(i)>=0
        yh3(i)=1;
    end
    disp(i);
    disp(Yh2(i));
    disp(yh3(i));
end

figure;
plot(yh3,'r*');
% hold on;
% plot(Yh2,'go');
% legend('output','lblTest');
