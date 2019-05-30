function ERR_MLP=MLP(X,Y,i,F)



DataNum = size(X,1);
InputNum = size(X,2);
OutputNum = size(Y,2);


% train data


 [r,c]=size(X);
 
 
 numTrain=ceil(70*r/100);
 
 %selectData=randperm(DataNum);
 
 XTrainData=X(1:numTrain,:);
 
 YTrainData=Y(1:numTrain,:);
 
%  Test data

 XTestData=X(numTrain:end,:);
 
 YTestData=Y(numTrain:end,:);
 
 

Ytrain=YTrainData;
Xtrain=XTrainData;
Xtest=XTestData;
Ytest=YTestData;

[rXtrain,cXtrain]=size(Xtrain);
[rXtest,cXtest]=size(Xtest);
  

Xtrain=Xtrain';
Xtest=Xtest';
Ytest=Ytest';
Ytrain=Ytrain';


performFcn = 'crossentropy';  % Cross-Entropy

trainFcn = 'trainscg';% Scaled conjugate gradient backpropagation.

nna=ceil(InputNum+5);
nnb=ceil(((2/3)*nna));
nnc=ceil(((2/3)*nnb-2));
m=10;
% AbsErrors=zeros(m,1); % 10 is count of starting nnet
% MinError=1000.0;

MinError=zeros(m,1)
for count=1:m
    close all;
    

    
    
    
    
   
net3 = patternnet([nna nnb nnc],trainFcn,performFcn);
net3.divideParam.valRatio = 5/100;
net3.trainParam.epochs=1000;
net3.trainParam.max_fail=40;
net3.trainParam.sigma=5.0e-5;
net3.trainParam.lambda=5.0e-7;



    net3 = train(net3,Xtrain,Ytrain);
%     view(net3)
    output1 = net3(Xtest);
    output2 = net3(Xtrain);
    %output1=round(output);
%    [cc,cm]=confusion(datatotal(test,end)',output1)
%     Acc_MLP(i)=1-cc;
% 
% plotconfusion(Ytest,output1)
% [cc,cm]=confusion(Ytest,output1)
% figure;
% plot(output1,'r*');
% hold on;
% plot(Ytest,'go');
% legend('output','lblTest');

%%%% result train data
ytrainYhatrainpredicted1=output2*1;
Yntrain=Ytrain*1;
MSEtrain= sum((Yntrain-ytrainYhatrainpredicted1).^2)/(rXtrain);
RMSEtrain= ((MSEtrain)^0.5);
SEtrain= ((Yntrain-ytrainYhatrainpredicted1).^2);
MAbsEtrain= sum(abs(Yntrain-ytrainYhatrainpredicted1))/(rXtrain);
AbsEtrain=abs(Yntrain-ytrainYhatrainpredicted1);
Errortrain=(Yntrain-ytrainYhatrainpredicted1);

NormalizedMSEtrain=sum((output2-Ytrain).^2)/(rXtrain);
NormalizedRMSEtrain=((NormalizedMSEtrain)^0.5);
NormalizedMAbsEtrain= sum(abs(output2-Ytrain))/(rXtrain);



%%%% result test data


yntest=Ytest*30;
ypredictedtest=output1*30;
MSEtest= sum((yntest-ypredictedtest).^2)/(rXtest);
RMSEtest= ((MSEtest)^0.5);
SEtest= ((yntest-ypredictedtest).^2);

MAbsEtest= sum(abs(yntest-ypredictedtest))/(rXtest);
AbsEtest=abs(yntest-ypredictedtest);
Error=(yntest-ypredictedtest);

NormalizedMSEtest=sum((Ytest-output1).^2)/(rXtest);
NormalizedRMSEtest=((NormalizedMSEtest).^0.5);
NormalizedMAbsEtest= sum(abs(Ytest-output1))/(rXtest);


figure(1);

subplot(2,4,[1 4]);
   
    x_Ax=[0:1:1];
    y_Ax=x_Ax;
    scatter(Yntrain,ytrainYhatrainpredicted1);
    hold on
    plot(x_Ax,y_Ax);
    hold off

 xlabel('Desired outputs');
 ylabel('Predicted outouts');

title('target train  and outputs train');


subplot(2,4,5);
plot(AbsEtrain);

 ylabel('Abs');
 xlabel('patient');
 

subplot(2,4,6);

plot(SEtrain);
title('Squer Error_Train');
ylabel('SE');
xlabel('patient');

strmin = ['MSE = ',num2str(MSEtrain)];
text(7,10,strmin,'HorizontalAlignment','right');

strmin = ['Mean Absolute Error = ',num2str(MAbsEtrain)];
text(20,10,strmin,'HorizontalAlignment','left');

strmin = ['Normalized Mean Absolute Error = ',num2str(NormalizedMAbsEtrain)];
text(20,10,strmin,'HorizontalAlignment','left');

strmin = ['Normalized MSE = ',num2str(NormalizedMSEtrain)];
text(7,10,strmin,'HorizontalAlignment','right');

strmin = ['RMSE = ',num2str(RMSEtrain)];
text(7,10,strmin,'HorizontalAlignment','right');

strmin = ['RMSEtrain = ',num2str(RMSEtrain)];
text(7,10,strmin,'HorizontalAlignment','right');

strmin = ['Normalized RMSE = ',num2str(NormalizedRMSEtrain)];
text(7,10,strmin,'HorizontalAlignment','right');

subplot(2,4,7);
plot(Errortrain);
title('Error');
ylabel('Eroor');
xlabel('patient');


subplot(2,4,8);

histfit(AbsEtrain,50);
title('Histogram of train absulote Error');


% figure(2);
% plot(ytrainYhatrainpredicted1,'r*');
% hold on;
% plot(Yntrain,'go');
% title('Train');
% legend('Predicted','Desired'); 

figure(2);

subplot(2,4,[1 4]);
   
    x_Ax=[0:1:30];
    y_Ax=x_Ax;
    scatter(yntest,ypredictedtest);
    hold on
    plot(x_Ax,y_Ax);
    hold off

 xlabel('Desired outputs');
 ylabel('Predicted outouts');

title('target test  and outputs test');


subplot(2,4,5);
plot(AbsEtest);
title('Absulote Error Test');
 ylabel('Abs');
 xlabel('patient');
 

subplot(2,4,6);

plot(SEtest);
title('Squer Error_Test');
ylabel('SE');
xlabel('patient');

strmin = ['MSE  = ',num2str(MSEtest)];
text(7,10,strmin,'HorizontalAlignment','right');

strmin = ['Mean Absolute Error = ',num2str(MAbsEtest)];
text(20,10,strmin,'HorizontalAlignment','left');
strmin = ['Normalized Mean Absolute Error = ',num2str(NormalizedMAbsEtest)];

text(20,10,strmin,'HorizontalAlignment','left');

strmin = ['Normalized MSE = ',num2str(NormalizedMSEtest)];
text(7,10,strmin,'HorizontalAlignment','right');
strmin = ['RMSE = ',num2str(RMSEtest)];
text(7,10,strmin,'HorizontalAlignment','right');
strmin = ['Normalized RMSE = ',num2str(NormalizedRMSEtest)];
text(7,10,strmin,'HorizontalAlignment','right');




subplot(2,4,7);

plot(Error);
title('Error');
ylabel('Eroor');
xlabel('patient');


subplot(2,4,8);

histfit(AbsEtest,50);
title('Histogram of test absulote Error');


% figure(4);
% plot(ypredictedtest,'r*');
% hold on;
% plot(yntest,'go');
% title('Test');
% legend('Predicted','Desired'); 
%     AbsErrors(count)= MAbsEtest;
%     if MAbsEtest<MinError
% 
%         dirname=['ResultMLP/Data' num2str(i) '/Workspace'];
%         mkdir(dirname);
% 
%         filename=strcat(dirname,'/set_',num2str(F),'.mat');
%         save(filename);
% 
%         dirname=['ResultMLP/Data' num2str(i) '/Figures'];
%         mkdir(dirname);
% 
%         filename=strcat(dirname,'/set_',num2str(F),'.fig');
%         savefig(filename);
        
        MinError(count,1)=MAbsEtest;
%     end
    
    
end
meanminerrortemporal=mean(MinError);
   ERR_MLP=meanminerrortemporal;
   
end
