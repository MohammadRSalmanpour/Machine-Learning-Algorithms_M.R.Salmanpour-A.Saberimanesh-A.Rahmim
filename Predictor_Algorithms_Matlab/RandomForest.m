
function ret=RandomForest(X,Y,i,F,NN,SaveResults)






allXdata =X;


allYdata = Y;

DataNum = size(allXdata,1);

InputNum = size(allXdata,2);
OutputNum = size(allYdata,2);



 max=30;
 
% preduce train data
 [r,c]=size(allXdata);
 numTrain=ceil(65*r/100);


%  preduce data train
 XTrainData=allXdata(1:numTrain,:);
numbertrain = size(XTrainData,1);
 
 YTrainData=(allYdata(1:numTrain,:))';
 feature_train=XTrainData;
target_train=YTrainData;

 

% preduce test data
  XTestData=allXdata(numTrain:end,:);
  numbertest = size(XTestData,1);

 YTestData=(allYdata(numTrain:end,:))';



opts= struct;
 opts.depth= NN;
opts.numTrees= 1000;
opts.numSplits= 5;
opts.verbose=true;
opts.classifierID= 4; % weak learners to use. Can be an array for mix of weak learners too



             % train

    
  for it=1:1
m= forestTrain(feature_train,target_train,opts);
yhatTrain = forestTest(m, feature_train);

Abserroetrain=sum(abs(YTrainData-yhatTrain));
Abserrortrain=30*Abserroetrain/numbertrain;

abserrorsun(it)=Abserrortrain;
menabserrortrain=mean(abserrorsun(:));

end %for
      


    
% Test
AbsEtestm=zeros(1,numbertest);    
SEtestpm=zeros(1,numbertest); 
Errorm=zeros(1,numbertest); 


g=5;
for itt=1:g
    
yhatTest = forestTest(m,XTestData);

YTestDatawn=30*YTestData;
yhatTestwn=30*yhatTest;


Abserrortest=sum(abs(YTestDatawn-yhatTestwn));
Abserrortestn=Abserrortest/numbertest;
abserrorsuntest(itt)=Abserrortestn;



AbsEtestn=(abs(YTestDatawn-yhatTestwn));
AbsEtestm=AbsEtestm+AbsEtestn;





MSEtesti= sum((YTestDatawn-yhatTestwn).^2);
MSEtestin=MSEtesti/numbertest;
meMSEtestin(itt)=MSEtestin;




SEtestpnn=(YTestDatawn-yhatTestwn).^2;
SEtestpm=SEtestpm+SEtestpnn;


SEtestg=sum((YTestDatawn-yhatTestwn).^2);
SEtestin=SEtestg/numbertest;
meSEtestin(itt)=SEtestin;



Errori=sum(YTestDatawn-yhatTestwn);
mError=Errori/numbertest;
mErrorn(itt)=mError;


Errorn=(YTestDatawn-yhatTestwn);
Errorm=Errorm+Errorn;


NormalizedMSEtestn=sum((YTestData-yhatTest).^2);
mNormalizedMSEtest=NormalizedMSEtestn/numbertest;
mNormalizedMSEtestn(itt)=mNormalizedMSEtest;
NormalizedMSEtest=mean(mNormalizedMSEtestn(:));

NormalizedRMSEtestn=sum((YTestData-yhatTest).^0.5);
mNormalizedRMSEtestn=NormalizedRMSEtestn/numbertest;
mNormalizedRMSEtestnn(itt)=mNormalizedRMSEtestn;
NormalizedRMSEtest=mean(mNormalizedRMSEtestnn(:));


NormalizedMAbsEtestn= sum(abs(YTestData-yhatTest));

NormalizedMAbsEtesti=NormalizedMAbsEtestn/numbertest;
NormalizedMAbsEtestia(itt)=NormalizedMAbsEtesti;
NormalizedMAbsEtest=mean(NormalizedMAbsEtestia(:));


end
SEtest=mean(meSEtestin(:));
MSEtest=mean(meMSEtestin(:));
RMSEtest= ((MSEtest)^0.5);
MAbsEtest=mean(abserrorsuntest(:));
Error=mean(mErrorn(:));



AbsEtestm=AbsEtestm./g;
SEtestpm=SEtestpm./g;
Errorm=Errorm./g;

% plot
figure ;

subplot(2,4,[1 4]);
   
    x_Ax=[0:1:30];
    y_Ax=x_Ax;
    scatter(YTestDatawn,yhatTestwn);
    hold on
    plot(x_Ax,y_Ax);
    hold off

 xlabel('Desired outputs');
 ylabel('Predicted outouts');

title('target test  and outputs test');


subplot(2,4,5);
plot(AbsEtestm);
title('Absulote Error Test');
 ylabel('Abs');
 xlabel('patient');
 

subplot(2,4,6);

plot(SEtestpm);
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

plot(Errorm);
title('Error');
ylabel('Eroor');
xlabel('patient');


subplot(2,4,8);

histfit(AbsEtestm,50);
title('Histogram of test absulote Error');




% saving

 if SaveResults==1
        dirname=['ResultRF/Data' num2str(i) '/Workspace'];
        mkdir(dirname);

        filename=strcat(dirname,'/set_',num2str(F),'.mat');
        save(filename);

        dirname=['ResultRF/Data' num2str(i) '/Figures'];
        mkdir(dirname);

        filename=strcat(dirname,'/set_',num2str(F),'.fig');
        savefig(filename);
        
 end
        ret=MAbsEtest;


end


