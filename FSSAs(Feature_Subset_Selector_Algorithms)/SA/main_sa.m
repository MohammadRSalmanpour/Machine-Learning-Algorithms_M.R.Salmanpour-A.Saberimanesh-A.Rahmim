
% This Algorithm (Simulated Annealing; SA) can select optimal number of features.
% AUTHOR(S):
% - Mohammad Reza Salmanpour Paeen Afrakati
% -------------------------------------------------------------------------
% INPUTS:
%Input data and target should be loaded in LoadData function.

% -------------------------------------------------------------------------
% OUTPUT:
% Optimal combination of input features
% -------------------------------------------------------------------------
% STATEMENT:
% This file is part of prediction task for Parkinson disease progression. Package by Mohammad Reza Salmanpour, Abdollah Saberimanesh and Arman Rahmim.
% --> Copyright (C) 2018-2019  Mohammad Reza Salmanpour ,Amirkabir University of Technology (Tehran Polytechnic) 
% All rights reserved for Mohammad Reza Salmanpour Paeen Afrakati, Abdollah Saberimanesh and Arman Rahmim.
% This package is distributed in the hope that it will be useful,

%Any feedback welcome!!!
%m.salmanpoor66@gmail.com, mohamad91@aut.ac.ir
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc;
clear;
close all;

%% Problem Definition
%%%Data file is a matfile included target and inputs
data=LoadData();

nf=18;   % Desired Number of Selected Features

CostFunction=@(q) FeatureSelectionCost(q,nf,data);    % Cost Function

%% SA Parameters

MaxIt=180;     % Maximum Number of Iterations

MaxSubIt=200;    % Maximum Number of Sub-iterations

T0=10;         % Initial Temp.

alpha=0.99;     % Temp. Reduction Rate

%% Initialization

% Create and Evaluate Initial Solution
sol.Position=CreateRandomSolution(data);
[sol.Cost, sol.Out]=CostFunction(sol.Position);

% Initialize Best Solution Ever Found
BestSol=sol;

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);

% Intialize Temp.
T=T0;

%% SA Main Loop

for it=1:MaxIt
    
    for subit=1:MaxSubIt
        
        % Create and Evaluate New Solution
        newsol.Position=CreateNeighbor(sol.Position);
        [newsol.Cost, newsol.Out]=CostFunction(newsol.Position);
        
        if newsol.Cost<=sol.Cost % If NEWSOL is better than SOL
            sol=newsol;
            
        else % If NEWSOL is NOT better than SOL
            
            DELTA=(newsol.Cost-sol.Cost)/sol.Cost;
            
            P=exp(-DELTA/T);
            if rand<=P
                sol=newsol;
            end
            
        end
        
        % Update Best Solution Ever Found
        if sol.Cost<=BestSol.Cost
            BestSol=sol;
        end
    
    end
    
    % Store Best Cost Ever Found
    BestCost(it)=BestSol.Cost;
    
    % Display Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    % Update Temp.
    T=alpha*T;
        
end

%% Results

figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');

% saving
mkdir('ResulSA');

        filename=strcat('ResulSA/','SA.mat');
        save(filename);

        

        filename=strcat('ResulSA/','SA.fig');
        savefig(filename);
