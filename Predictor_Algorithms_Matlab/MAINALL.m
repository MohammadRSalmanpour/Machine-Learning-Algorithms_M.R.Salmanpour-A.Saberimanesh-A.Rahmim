
% -------------------------------------------------------------------------
% Multi algorithms for outcome prediction task.
% -------------------------------------------------------------------------
% DESCRIPTION:
% This code is included 6 predictor algorithms(LoLIMOT(Local Linear Model Trees),RBF (Radial basis Function) , 
% Random Forest, MLP_BP(Multilayer Perceptron_ Back propagation),RNN(Reccurent Neural Network) and
% ANFIS(Adaptive neuro fuzzy inference system)). Automated Machine Learning Hyperparameter Tuning is applied to
% some algorithms sothat some paremeters such as number of neurons for some
% machines (such as RBF, LoLIMOT and ANFIS and for Random Forest  tunes depth) will tune automatically.
% This code needs a feature table which shows various combinations between
% features. So this code is able to work with each combination introduced
% in Feature table automatically. Also, this code is able to work with
% various datasheets automatically. Results of each combination for each
% datasheet will save finally.
% -------------------------------------------------------------------------
% INPUTS:
% This code is able to work with various input combinations. it must be loaded in top of program namely Feature_Table.
% Be Careful!!! number of each column of  Feature_Table must be similar to number of inputs features and target for each datasheet.
% This code is able to simultaneously work with several datasheets acompanied with various combinations. Each datasheet should name similarely data1, data2, data3, etc.
% Target should add last column of each datasheet.It can be useful for
% datasheets that are as timeseties, for example data at year 1, data year
% 2 and etc. So number of columns of each dataseet must be similar to number
% of inputs and target.
% -------------------------------------------------------------------------
% OUTPUTS:
% For each function (predictor algorithm), fitting carve of true outcome and predicted outcome draws and saves.
% The workspase for each datasheet and for each combination will saved.
% Fitting curve of each run (True outcome VS predicted Outcome) will save.
% Results of each datasheet accompanied with various combinations will save saparately.
% -------------------------------------------------------------------------
% % AUTHOR(S):
% - Mohammad Reza Salmanpour Paeen Afrakati, Abdollah Saberimanesh
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% STATEMENT:
% This file is part of prediction task for Parkinson disease progression. Package by Mohammad Reza Salmanpour, Abdollah Saberimanesh and Arman Rahmim.
% --> Copyright (C) 2018-2019  Mohammad Reza Salmanpour ,Amirkabir University of Technology (Tehran Polytechnic) 
% All rights reserved for Mohammad Reza Salmanpour Paeen Afrakati, Abdollah Saberimanesh and Arman Rahmim.
% This package is distributed in the hope that it will be useful,

%Any feedback welcome!!!
%m.salmanpoor66@gmail.com, mohamad91@aut.ac.ir
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear all;
close all;

%%%%%% Loading table included various combinations
load('Feature_Table');
Various_Combinations=Table(:,1:end);
[Ytable Xtable]=size(Various_Combinations);


NUM_File=10;
MenAbserrorsLOLI=zeros(Ytable,NUM_File);
MenAbserrorsRNN=zeros(Ytable,NUM_File);
MenAbserrorsRBF=zeros(Ytable,NUM_File);
MenAbserrorsMLP=zeros(Ytable,NUM_File);
MenAbserrorsRF=zeros(Ytable,NUM_File);
MenAbserrorsANFIS=zeros(Ytable,NUM_File);

for i=1:NUM_File
    
    %%%Loading data
    filename=strcat('Data',num2str(i),'.mat');
    load(filename);
    
    for F=1:Ytable
        close all;
        %%%% Selecting various combination of input features introduced in Feature_Table
        F_selectingFeatures=Various_Combinations(F,:);
        Data=Datasheet(:, F_selectingFeatures>0);% select all rows and  columns which have amount bigger than zero into F_selectingFeatures
        
        %%%%Inputs and Target for various dataseets and different combinations
        
        Inputs = DataTemp(:,1:end-1);
        Target = DataTemp(:,end);
        
        %%%% Predictor functions
        [ERR_LOLI]=SetLolimat(Inputs,Target,i,F);
        [ERR]= SetRBF(Inputs,Target,i,F);
        [ERR_MLP]=MLP(Inputs,Target,i,F);
        ERR_RF= SetRF(Inputs,Target,i,F)
        ERR_RNN=RNN(Inputs,Target,i,F);
        SetANFISS(Inputs,Target,i,F);
        
        
        %%%%% Saving Results%%%%%%%%%%%%
        error=ERR_LOLI;
        MenAbserrorsLOLI(F,i)=error;
        dirname=['ResultLOLIMOT','/Data_Error'];
        mkdir(dirname);
        ffname=strcat(dirname,'/MenAbserrorsLOLI',num2str(i),'.mat');
        save(ffname,'MenAbserrorsLOLI');
        
        error_RNN=ERR_RNN;
        MenAbserrorsRNN(i,:)=error_RNN;
        dirname=['ResultRNN','/Data_Error'];
        mkdir(dirname);
        ffname=strcat(dirname,'/MenAbserrorsRNN',num2str(i),'.mat');
        save(ffname,'MenAbserrorsRNN');
        
        error_RBF=ERR;
        MenAbserrorsRBF(i,F)=error_RBF;
        dirname=['ResultRBF','/Data_Error'];
        mkdir(dirname);
        ffname=strcat(dirname,'/MenAbserrorsRBF',num2str(i),'.mat');
        save(ffname,'MenAbserrorsRBF');
        
        
        error_MLP=ERR_MLP;
        MenAbserrorsMLP(i,:)=error_MLP;
        dirname=['ResultMLP','/Data_Error'];
        mkdir(dirname);
        ffname=strcat(dirname,'/MenAbserrorsMLP',num2str(i),'.mat');
        save(ffname,'MenAbserrorsMLP');
        
        error_ANFIS=retm;
        MenAbserrorsANFIS(F,i)=error_ANFIS;
        dirname=['ResultANFIS','/Data_Error'];
        mkdir(dirname);
        ffname=strcat(dirname,'/MenAbserrorsANFIS',num2str(i),'.mat');
        save(ffname,'MenAbserrorsANFIS');
        
        error_RF=ERR_RF;
        MenAbserrorsRF(F,i)=error_RF;
        dirname=['ResultRF','/Data_Error'];
        mkdir(dirname);
        ffname=strcat(dirname,'/MenAbserrorsRF',num2str(i),'.mat');
        save(ffname,'MenAbserrorsRF');
        
    end
end

clc;
close all;
clear all;