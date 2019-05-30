function [err]=loli(X,Y,i,F,nn,SaveResults)



DataNum = size(X,1);

InputNum = size(X,2);
OutputNum = size(Y,2);



 max=30;
 
% preduce train data
 [r,c]=size(X);
 numTrain=ceil(65*r/100);

 XTrainData=X(1:numTrain,:);

 YTrainData=Y(1:numTrain,:);
 
% preduce  validate data
 numvalidation= ceil(5*r/100);
 numvalidat=numvalidation+numTrain;

 XvalidData= X(numTrain:numvalidat,:);
 
 YvalidData=Y(numTrain:numvalidat,:);
 
% preduce test data
  XTestData=X(numvalidat:end,:);
  
 YTestData=Y(numvalidat:end,:);
 nytst=size(YTestData,1);


Ytrn=YTrainData;
Xtrn=XTrainData;
Yvld= YvalidData;
Xvld=XvalidData
Xtst=XTestData;
Ytst=YTestData;


%%%%% mean
metr=mean(Xtrn);
meva=mean(Xvld);
mete=mean(Xtst);


%  train step
if nn==0
    nn = (InputNum/2.2)+2;
end


%%%%%%%%%%%%%%%%%train
 SXt=size(Xtrn,1);
 SYt=size(Xtrn,2);

for hh=1:SYt
      if metr(1,hh)==0 || metr(1,hh)==1  
   
          Xtrn(1,hh)=Xtrn(1,hh)+0.5;
       end
end
      %%%%%%%%%%%%%%%%%%%%%%%%%validation
 SXva=size(Xvld,1);
 SYva=size(Xvld,2);

   for kk=1:SYva
      if meva(1,kk)==0 || meva(1,kk)==0.5  
   
          Xvld(1,kk)=Xvld(1,kk)+1;
      end
   end
   %%%%%%%%%%%%%%%%%%% %%%%%%%Test
   SXte=size(Xvld,1);
 SYte=size(Xvld,2);

   for gg=1:SYte
      if mete(1,gg)==0 || mete(1,gg)==1  
   
          Xvld(1,gg)=Xvld(1,gg)+0.0000000001;
      end
   end    

[C I LB M UB V W] = FLoLiMoT(Xtrn, Ytrn, Xvld, Yvld,nn);
yhtrn=netFeed(C ,V, W ,Xtrn);
Yhatrainpredicted=yhtrn;
etrn=NMSE(Ytrn,yhtrn);
[Rtr,Ctr]=size(Ytrn);
ytrainYhatrainpredicted1=Yhatrainpredicted*max;
Ytrain=Ytrn*max;
MSEtrain= sum((Ytrain-ytrainYhatrainpredicted1).^2)/(Rtr);
RMSEtrain= ((MSEtrain)^0.5);
SEtrain= ((Ytrain-ytrainYhatrainpredicted1).^2);
MAbsEtrain= sum(abs(Ytrain-ytrainYhatrainpredicted1))/(Rtr);
AbsEtrain=abs(Ytrain-ytrainYhatrainpredicted1);
Errortrain=(Ytrain-ytrainYhatrainpredicted1);

NormalizedMSEtrain=sum((Ytrn-yhtrn).^2)/(Rtr);
NormalizedRMSEtrain=((NormalizedMSEtrain)^0.5);
NormalizedMAbsEtrain= sum(abs(Ytrn-yhtrn))/(Rtr);

% test step
Yh1 = netFeed(C ,V, W ,Xtst);
e2 = NMSE(Ytst,Yh1);
yh3=Yh1;
[Rte,Cte]=size(Ytst);
ytest=Ytst*max;
ypredictedtest=Yh1*max;
MSEtest= sum((ytest-ypredictedtest).^2)/(Rte);
RMSEtest= ((MSEtest)^0.5);
SEtest= ((ytest-ypredictedtest).^2);

MAbsEtest= sum(abs(ytest-ypredictedtest))/(Rte);
AbsEtest=abs(ytest-ypredictedtest);
Error=(ytest-ypredictedtest);

NormalizedMSEtest=sum((Ytst-Yh1).^2)/(Rte);
NormalizedRMSEtest=((NormalizedMSEtest).^0.5);
NormalizedMAbsEtest= sum(abs(Ytst-Yh1))/(Rte);

% Print_train

figure(1);

subplot(2,4,[1 4]);
   
    x_Ax=[0:1:30];
    y_Ax=x_Ax;
    scatter(Ytrain,ytrainYhatrainpredicted1);
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
% plot(Ytrain,'go');
% title('Train');
% legend('Predicted','Desired'); 

% PRINT_TEST
figure(2);

subplot(2,4,[1 4]);
   
    x_Ax=[0:1:30];
    y_Ax=x_Ax;
    scatter(ytest,ypredictedtest);
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
strmin = ['RMSE = ',num2str(NormalizedRMSEtest)];
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
% 
% figure(4);
% plot(ypredictedtest,'r*');
% hold on;
% plot(ytest,'go');
% title('Test');
% legend('Predicted','Desired'); 
    
    if SaveResults==1

        dirname=['ResultLOLIMOT/Data' num2str(i) '/Workspace'];
        mkdir(dirname);

        filename=strcat(dirname,'/set_',num2str(F),'.mat');
        save(filename);

        dirname=['ResultLOLIMOT/Data' num2str(i) '/Figures'];
        mkdir(dirname);

        filename=strcat(dirname,'/set_',num2str(F),'.fig');
        savefig(filename);
        
    end %if


    err=MAbsEtest;

end %function

