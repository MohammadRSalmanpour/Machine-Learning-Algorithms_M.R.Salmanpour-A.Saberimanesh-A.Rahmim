function ERR_RF=SetRF(X,Y,i,F)

%Q-Learning Algorithm in order to find the best configuration


dirname=['ResultRF/Setting'];
mkdir(dirname);

filename_setting=strcat(dirname,'/seting_',num2str(F),'.mat');
%save(filename);
setting=[];
if exist(filename_setting,'file')==0
    MinError=1000.0;
    LastBestNN=5;
    NN_Temp=LastBestNN;
    LastChange=LastBestNN;
    Coeff=1;
    for count=1:5
        close all;
        
        AbsErr_Temp=RandomForest(X,Y,i,F,NN_Temp,0);
      
        LastChange=ceil(LastChange/2)
        if AbsErr_Temp<MinError
            
            LastBestNN=NN_Temp;
            MinError=AbsErr_Temp;
        else 
            Coeff=(-1)*Coeff;
        end %if
        
            NN_Temp=LastBestNN+(LastChange*Coeff);
    
    end %for
    
    setting.RightNumberOfNeurons=LastBestNN;

else
    load(filename_setting);
end %if

  ERR_RF=RandomForest(X,Y,i,F,NN_Temp,1)


end