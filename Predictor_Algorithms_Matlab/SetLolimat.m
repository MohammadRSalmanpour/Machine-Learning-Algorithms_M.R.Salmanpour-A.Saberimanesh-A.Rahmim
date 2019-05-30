function [err]=SetLolimat(X,Y,i,F)

%Q-Learning Algorithm in order to find the best configuration


dirname=['ResultLOLIMOT/Setting'];
mkdir(dirname);

filename_setting=strcat(dirname,'/seting_',num2str(F),'.mat');
%save(filename);
setting=[];
if exist(filename_setting,'file')==0
    MinError=1000.0;
    LastBestNN=30;
    NN_Temp=LastBestNN;
    LastChange=LastBestNN;
    Coeff=1;
    for count=1:20
        close all;
        AbsErr_Temp=loli(X,Y,i,F,NN_Temp,0);
        LastChange=ceil(LastChange/1.2)
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

err=loli(X,Y,i,F,setting.RightNumberOfNeurons,1)
save(filename_setting,'setting');


end