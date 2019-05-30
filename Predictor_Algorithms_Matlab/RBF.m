function [ERR]=RBF(X,Y,i,F,nn,SaveResults)



DataNum = size(X,1);
InputNum = size(X,2);
OutputNum = size(Y,2);

% %% Normalization
% MinX = min(X);
% MaxX = max(X);
% 
% 
% MinY = min(Y);
% MaxY = max(Y);
% 
%  for ii = 1:InputNum
%      XN(:,ii) = Normalize_Fcn(X(:,ii),MinX(ii),MaxX(ii));
%  end
%  
%  for ii = 1:OutputNum
%      YN(:,ii) = Normalize_Fcn(Y(:,ii),MinY(ii),MaxY(ii));
%  end
% train data


 [r,c]=size(X);
 
 
 numTrain=ceil(65*r/100);
 
 selectData=randperm(DataNum);
 
 XTrainData=X(1:numTrain,:);
 
 YTrainData=Y(1:numTrain,:)
 
%  Test data

 XTestData=X(numTrain:end,:);
 
 YTestData=Y(numTrain:end,:);
 
%  STest=selectData(1,numTrain:end);
%  SValidate=selectData(1,1:numTrain);
 
%  % Save DATA Test and Train
%  SaveTrainData=data(selectData(1,1:numTrain),:);
%  save('SaveTrainData','SaveTrainData');
%  
% %  Save test data
%  SaveTestData=data(selectData(1,numTrain:end),:);
%   save('SaveTestData','SaveTestData');

Ytrain=YTrainData;
Xtrain=XTrainData;
Xtest=XTestData;
Ytest=YTestData;

% [rXtrain,cXtrain]=size(Xtrain);
% [rXtest,cXtest]=size(Xtest);
% datatotal=xlsread('drug490.xlsx');
% datatotal=datatotal';
% 
% n=size(datatotal,1) ;
% R = randperm(n)';
% c=0.8;

TrainData=Xtrain;
lblTrain=Ytrain;
TestData=Xtest;
lblTest=Ytest;
TrainData=TrainData';
TestData=TestData';
lblTest=lblTest';
lblTrain=lblTrain';

% load TrainData81
% load TestData81
% load lblTrain81
% load lblTest81

% make ANN
% net=narxnet(1:2,1:2,10);
% netp = removedelay(net);
% view(netp)
% [Xs,Xi,Ai,Ts] = preparets(netp,TrainData,{},lblTrain);
% y = netp(Xs,Xi,Ai);
if nn==0
    nn=ceil(InputNum/2.2)+5;
end

net = newrb(TrainData,lblTrain,0,1,nn,1);
% view(net)

%output = sim(net,TrainData);
outputtrain = sim(net,TrainData);


%output = sim(net,TestData);
outputtest = sim(net,TestData);
outputtrain = sim(net,TrainData);

% output1=round(output);
% % for i=1:size(yh3,1)
% %     if output(i)<0
% %         yh3(i)=0;
% %     elseif output(i)>=0
% %         yh3(i)=1;
% %     end
% % %     disp(i);
% % %     disp(Yh2(i));
% % %     disp(yh3(i));
% % end
% plotconfusion(lblTest,output1)
% [cc,cm]=confusion(lblTest,output1)
% figure;
% plot(output1,'r*');
% hold on;
% plot(lblTest,'g-');
% legend('output','lblTest');


%  Acc_MLP=(cm(1,1)+cm(2,2))/(cm(1,1)+cm(1,2)+cm(2,1)+cm(2,2))
%     SN_MLP=cm(1,1)/(cm(1,1)+cm(1,2))
%     SP_MLP=cm(2,2)/(cm(2,2)+cm(2,1))
%     F1_MLP = 2*cm(1,1)/(cm(1,2)+cm(2,1)+(2*cm(1,1)))
%     MCC_MLP=((cm(2,2)*cm(1,1))-(cm(1,2)*cm(2,1)))/sqrt((cm(1,1)+cm(1,2))*(cm(1,1)+cm(2,1))*(cm(2,2)+cm(2,1))*(cm(2,2)+cm(1,2)))
% 
% train
[rXtrain,cXtrain]=size(Xtrain);
ytrainYhatrainpredicted1=outputtrain*77;
Yntrain=lblTrain*77;
MSEtrain= sum(((Yntrain-ytrainYhatrainpredicted1).^2))/(rXtrain);
RMSEtrain= ((MSEtrain)^0.5);
SEtrain= ((Yntrain-ytrainYhatrainpredicted1).^2);
MAbsEtrain= sum(abs(Yntrain-ytrainYhatrainpredicted1))/(rXtrain);
AbsEtrain=abs(Yntrain-ytrainYhatrainpredicted1);
Errortrain=(Yntrain-ytrainYhatrainpredicted1);

NormalizedMSEtrain=sum((lblTrain-outputtrain).^2)/(rXtrain);
NormalizedRMSEtrain=((NormalizedMSEtrain)^0.5);
NormalizedMAbsEtrain= sum(abs(lblTrain-outputtrain))/(rXtrain);



% test
[rXtest,cXtest]=size(Xtest);
ytest=lblTest*77;
ypredictedtest=outputtest*77;
MSEtest= (sum((ytest-ypredictedtest).^2))/(rXtest);
RMSEtest= ((MSEtest)^0.5);
SEtest= ((ytest-ypredictedtest).^2);

MAbsEtest= sum(abs(ytest-ypredictedtest))/(rXtest);
AbsEtest=abs(ytest-ypredictedtest);
Error=(ytest-ypredictedtest);

NormalizedMSEtest=sum((lblTest-outputtest).^2)/(rXtest);
NormalizedRMSEtest=(NormalizedMSEtest.^0.5);
NormalizedMAbsEtest= sum(abs(lblTest-outputtest))/(rXtest);

figure(1);

subplot(2,4,[1 4]);
   
    x_Ax=[0:1:77];
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




% PRINT_TEST
figure(2);

subplot(2,4,[1 4]);
   
    x_Ax=[0:1:77];
    y_Ax=x_Ax;
    scatter(ytest,ypredictedtest);
    hold on
    plot(x_Ax,y_Ax);
    hold off

 xlabel('Desired outputs');
 ylabel('Predicted outouts');

title('Target test  and outputs test');


subplot(2,4,5);
plot(AbsEtest);
title('Absulote Error Test');
 ylabel('Abs');
 xlabel('patient');
 

subplot(2,4,6);

plot(SEtest);
title('Squer Error Test');
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
% plot(ytest,'go');
% title('Test');
% legend('Predicted','Desired'); 




    if SaveResults==1
        dirname=['ResultRBF/Data' num2str(i) '/Workspace'];
        mkdir(dirname);

              filename=strcat(dirname,'/set_',num2str(F),'.mat');
            save(filename);

            dirname=['ResultRBF/Data' num2str(i) '/Figures'];
        mkdir(dirname);

         filename=strcat(dirname,'/set_',num2str(F),'.fig');
            savefig(filename);
    end
    ERR=MAbsEtest;
end
