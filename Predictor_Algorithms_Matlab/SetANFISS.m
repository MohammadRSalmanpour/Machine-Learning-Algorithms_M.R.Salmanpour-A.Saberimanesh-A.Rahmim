function SetANFISS(X,Y,i,F)

%Q-Learning Algorithm in order to find the best configuration


dirname=['ResultANFISS/Setting'];
mkdir(dirname);

filename_setting=strcat(dirname,'/seting_',num2str(F),'.mat');
%save(filename);
setting=[];
if exist(filename_setting,'file')==0
    MinError=1000.0;
    LastBestNN=20;
    NN_Temp=LastBestNN;
    LastChange=LastBestNN;
    Coeff=1;
    for count=1:5
        close all;
        saveresult=0;
        AbsErr_Temp=ANFISS(X,Y,i,F,NN_Temp,saveresult);
        LastChange=ceil(LastChange/1.5)
        if AbsErr_Temp<ret
            
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

saveresult=1;
[retm]=ANFISS(X,Y,i,F,setting.RightNumberOfNeurons,saveresult)
save(filename_setting,'setting');

end