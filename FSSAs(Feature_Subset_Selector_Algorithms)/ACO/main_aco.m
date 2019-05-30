
% This Algorithm (Ants Colony Optimization;ACO) can select optimal number of features.
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

nVar=data.nx;


%% ACO Parameters

MaxIt=180;      % Maximum Number of Iterations

nAnt=250;        % Number of Ants (Population Size)

Q=1;

tau0=1;	% Initial Phromone

alpha=1;        % Phromone Exponential Weight
beta=1;         % Heuristic Exponential Weight

rho=0.05;       % Evaporation Rate


%% Initialization

eta=ones(nVar,nVar);        % Heuristic Information Matrix

tau=tau0*ones(nVar,nVar);   % Phromone Matrix

BestCost=zeros(MaxIt,1);    % Array to Hold Best Cost Values

% Empty Ant
empty_ant.Tour=[];
empty_ant.Cost=[];
empty_ant.Out=[];

% Ant Colony Matrix
ant=repmat(empty_ant,nAnt,1);

% Best Ant
BestAnt.Cost=inf;


%% ACO Main Loop

for it=1:MaxIt
    
    % Move Ants
    for k=1:nAnt
        
        ant(k).Tour=randi([1 nVar]);
        
        for l=2:nVar
            
            i=ant(k).Tour(end);
            
            P=tau(i,:).^alpha.*eta(i,:).^beta;
            
            P(ant(k).Tour)=0;
            
            P=P/sum(P);
            
            j=RouletteWheelSelection(P);
            
            ant(k).Tour=[ant(k).Tour j];
            
        end
        
        [ant(k).Cost, ant(k).Out]=CostFunction(ant(k).Tour);
        
        if ant(k).Cost<BestAnt.Cost
            BestAnt=ant(k);
        end
        
    end
    
    % Update Phromones
    for k=1:nAnt
        
        tour=ant(k).Tour;
        
        tour=[tour tour(1)];
        
        for l=1:nVar
            
            i=tour(l);
            j=tour(l+1);
            
            tau(i,j)=tau(i,j)+Q/ant(k).Cost;
            
        end
        
    end
    
    % Evaporation
    tau=(1-rho)*tau;
    
    % Store Best Cost
    BestCost(it)=BestAnt.Cost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
end

%% Results

figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
% saving
mkdir('ResulASO');

        filename=strcat('ResulASO/','ACO.mat');
        save(filename);

        

        filename=strcat('ResulASO/','ASO.fig');
        savefig(filename)
