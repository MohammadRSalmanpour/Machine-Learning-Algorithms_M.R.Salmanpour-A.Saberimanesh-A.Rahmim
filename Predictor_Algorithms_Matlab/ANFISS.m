function [retm retm]=ANFISS(X,Y,i,F,nn,saveresult);

DataNum = size(X,1);
InputNum = size(X,2);
OutputNum = size(Y,2);

%% Normalization
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
 
%  selectData=randperm(DataNum);
 
 XTrainData=X(1: numTrain,:);
 
 YTrainData=Y(1: numTrain,:);
 
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








[rXtrain,cXtrain]=size(Xtrain);
[rXtest,cXtest]=size(Xtest);

%%%%% mean
metr=mean(Xtrain);

mete=mean(Xtest);




%%%%%%%%%%%%%%%%%train
 SXt=size(Xtrain,1);
 SYt=size(Xtrain,2);

for hh=1:SYt
      if metr(1,hh)==0 || metr(1,hh)==1  
   
          Xtrain(1,hh)=Xtrain(1,hh)+1;
       end
end

   %%%%%%%%%%%%%%%%%%% %%%%%%%Test
   SXte=size(Xtest,1);
 SYte=size(Xtest,2);

   for gg=1:SYte
      if mete(1,gg)==0 || mete(1,gg)==1  
   
          Xtest(1,gg)=Xtest(1,gg)+1;
      end
   end   




% generate basic fis
fis=genfis3(Xtrain,Ytrain);


% tarin using anfis
if nn==0
    nn = (InputNum^2-5*InputNum);
end

m=10;
AbsErrors=zeros(m,1); % m is count of starting nnet

MinError=1000.0;

for count=1:size(AbsErrors)
    close all;
   


	fistrain=anfis([Xtrain,Ytrain],fis,nn);
	Predictedvalustriain=evalfis(Xtrain,fistrain);


	ytrainYhatrainpredicted1=Predictedvalustriain*30;
	Yntrain=Ytrain*30;
	MSEtrain= sum((Yntrain-ytrainYhatrainpredicted1).^2)/(rXtrain);
	RMSEtrain= ((MSEtrain)^0.5);
	SEtrain= ((Yntrain-ytrainYhatrainpredicted1).^2);
	MAbsEtrain= sum(abs(Yntrain-ytrainYhatrainpredicted1))/(rXtrain);
	AbsEtrain=abs(Yntrain-ytrainYhatrainpredicted1);
	Errortrain=(Yntrain-ytrainYhatrainpredicted1);

	NormalizedMSEtrain=sum((Predictedvalustriain-Ytrain).^2)/(rXtrain);
	NormalizedRMSEtrain=((NormalizedMSEtrain)^0.5);
	NormalizedMAbsEtrain= sum(abs(Predictedvalustriain-Ytrain))/(rXtrain);

	% % test data
	Predictedvalustest=evalfis(Xtest,fistrain);


	[rXtest,cXtest]=size(Xtest);
	ytest=YTestData*30;
	ypredictedtest=Predictedvalustest*30;
	MSEtest= sum((ytest-ypredictedtest).^2)/(rXtest);
	RMSEtest= ((MSEtest)^0.5);
	SEtest= ((ytest-ypredictedtest).^2);

	MAbsEtest= sum(abs(ytest-ypredictedtest))/(rXtest);
	AbsEtest=abs(ytest-ypredictedtest);
	Error=(ytest-ypredictedtest);

	NormalizedMSEtest=sum((YTestData-Predictedvalustest).^2)/(rXtest);
	NormalizedRMSEtest=((NormalizedMSEtest).^0.5);
	NormalizedMAbsEtest= sum(abs(YTestData-Predictedvalustest))/(rXtest);

	% Print_train


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

	AbsErrors(count,1)= MAbsEtest;
% 	MinError=MAbsEtest;
	
   end %for
   if saveresult==0
   MinError=mean(AbsErrors);
	 ret=MinError;
   end
     if saveresult==1
     retm=mean(AbsErrors);
     end
end
