
% This Algorithm (Non-dominated Sorting Genetic Algorithm; NSGAII) can
% select optimal numbers (several optimal combinations) of features. 
% AUTHOR(S):
% - Mohammad Reza Salmanpour Paeen Afrakati
% -------------------------------------------------------------------------
% INPUTS:
%Input data and target should be loaded in LoadData function.

% -------------------------------------------------------------------------
% OUTPUTS:
% Optimal combinations of input features.
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

CostFunction=@(s) FeatureSelectionCost(s,data);      % Cost Function

nVar=data.nx;             % Number of Decision Variables

VarSize=[1 nVar];   % Size of Decision Variables Matrix

% Number of Objective Functions
nObj=numel(CostFunction(randi([0 1],VarSize)));


%% NSGA-II Parameters

MaxIt=10;      % Maximum Number of Iterations

nPop=20;        % Population Size

pCrossover=0.7;                         % Crossover Percentage
nCrossover=2*round(pCrossover*nPop/2);  % Number of Parnets (Offsprings)

pMutation=0.4;                          % Mutation Percentage
nMutation=round(pMutation*nPop);        % Number of Mutants

mu=0.1;                    % Mutation Rate


%% Initialization

empty_individual.Position=[];
empty_individual.Cost=[];
empty_individual.Out=[];
empty_individual.Rank=[];
empty_individual.DominationSet=[];
empty_individual.DominatedCount=[];
empty_individual.CrowdingDistance=[];

pop=repmat(empty_individual,nPop,1);

for i=1:nPop
    
    if i~=1
        pop(i).Position=randi([0 1],VarSize);
    else
        pop(i).Position=ones(VarSize);
    end
    
    [pop(i).Cost, pop(i).Out]=CostFunction(pop(i).Position);
    
end

% Non-Dominated Sorting
[pop, F]=NonDominatedSorting(pop);

% Calculate Crowding Distance
pop=CalcCrowdingDistance(pop,F);

% Sort Population
[pop, F]=SortPopulation(pop);


%% NSGA-II Main Loop

for it=1:MaxIt
    
    % Crossover
    popc=repmat(empty_individual,nCrossover/2,2);
    for k=1:nCrossover/2
        
        i1=randi([1 nPop]);
        p1=pop(i1);
        
        i2=randi([1 nPop]);
        p2=pop(i2);
        
        [popc(k,1).Position, popc(k,2).Position]=Crossover(p1.Position,p2.Position);
        
        [popc(k,1).Cost, popc(k,1).Out]=CostFunction(popc(k,1).Position);
        [popc(k,2).Cost, popc(k,2).Out]=CostFunction(popc(k,2).Position);
        
    end
    popc=popc(:);
    
    % Mutation
    popm=repmat(empty_individual,nMutation,1);
    for k=1:nMutation
        
        i=randi([1 nPop]);
        p=pop(i);
        
        popm(k).Position=Mutate(p.Position,mu);
        
        [popm(k).Cost, popm(k).Out]=CostFunction(popm(k).Position);
        
    end
    
    % Merge
    pop=[pop
         popc
         popm]; %#ok
     
    % Non-Dominated Sorting
    [pop, F]=NonDominatedSorting(pop);

    % Calculate Crowding Distance
    pop=CalcCrowdingDistance(pop,F);

    % Sort Population
    [pop, F]=SortPopulation(pop); %#ok
    
    % Truncate
    pop=pop(1:nPop);
    
    % Non-Dominated Sorting
    [pop, F]=NonDominatedSorting(pop);

    % Calculate Crowding Distance
    pop=CalcCrowdingDistance(pop,F);

    % Sort Population
    [pop, F]=SortPopulation(pop);
    
    % Store F1
    F1=pop(F{1});
    F1=GetUniqueMembers(F1);
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Number of F1 Members = ' num2str(numel(F1))]);
    
    % Plot F1 Costs
    figure(1);
    PlotCosts(F1);
    pause(0.1);
    
end


%% Results

 mkdir('ResultMultigoal');

        filename=strcat('ResultMultigoal/','Multigoal.mat');
        save(filename);

        

        filename=strcat('ResultMultigoal/','Multigoal.fig');
        savefig(filename);
            