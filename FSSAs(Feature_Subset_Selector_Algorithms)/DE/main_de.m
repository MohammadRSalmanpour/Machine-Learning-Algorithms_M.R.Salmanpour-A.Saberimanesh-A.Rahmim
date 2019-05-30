
% This Algorithm (Deferential Evolution;DE) can select optimal number of features.
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



clc;
clear;
close all;

%% Problem Definition
%%%Data file is a matfile included target and inputs
data=LoadData();

nf=18;

CostFunction=@(u) FeatureSelectionCost(u,nf,data);        % Cost Function

nVar=data.nx;       % Number of Decision Variables

VarSize=[1 nVar];   % Size of Decision Variables Matrix

VarMin=0;         % Lower Bound of Variables
VarMax=1;         % Upper Bound of Variables

%% DE Parameters

MaxIt=180;      % Maximum Number of Iterations

nPop=250;        % Population Size

beta_min=0.2;   % Lower Bound of Scaling Factor
beta_max=0.8;   % Upper Bound of Scaling Factor

pCR=0.2;        % Crossover Probability

%% Initialization

empty_individual.Position=[];
empty_individual.Cost=[];
empty_individual.Out=[];

BestSol.Cost=inf;

pop=repmat(empty_individual,nPop,1);

for i=1:nPop

    pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
    
    [pop(i).Cost, pop(i).Out]=CostFunction(pop(i).Position);
    
    if pop(i).Cost<BestSol.Cost
        BestSol=pop(i);
    end
    
end

BestCost=zeros(MaxIt,1);

%% DE Main Loop

for it=1:MaxIt
    
    for i=1:nPop
        
        x=pop(i).Position;
        
        A=randperm(nPop);
        
        A(A==i)=[];
        
        a=A(1);
        b=A(2);
        c=A(3);
        
        % Mutation
        %beta=unifrnd(beta_min,beta_max);
        beta=unifrnd(beta_min,beta_max,VarSize);
        y=pop(a).Position+beta.*(pop(b).Position-pop(c).Position);
        
        % Crossover
        z=zeros(size(x));
        j0=randi([1 numel(x)]);
        for j=1:numel(x)
            if j==j0 || rand<=pCR
                z(j)=y(j);
            else
                z(j)=x(j);
            end
        end
        
        NewSol.Position=z;
        [NewSol.Cost, NewSol.Out]=CostFunction(NewSol.Position);
        
        if NewSol.Cost<pop(i).Cost
            pop(i)=NewSol;
            
            if pop(i).Cost<BestSol.Cost
               BestSol=pop(i);
            end
        end
        
    end
    
    % Update Best Cost
    BestCost(it)=BestSol.Cost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
end

%% Show Results

figure;
plot(BestCost);


% saving
mkdir('ResulDE');

        filename=strcat('ResulDE/','DE.mat');
        save(filename);

        

        filename=strcat('ResulDE/','DE.fig');
        savefig(filename)


