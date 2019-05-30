function [z, out]=FeatureSelectionCost(s,data)

    % Read Data Elements
    x=data.x;
    t=data.t;
    
    % Selected Features
    S=find(s~=0);

    % Number of Selected Features
    nf=numel(S);
    
    % Ratio of Selected Features
    rf=nf/numel(s);
    
    % Selecting Features
    xs=x(S,:);
    
    % Weights of Train and Test Errors
    wTrain=0.8;
    wTest=1-wTrain;
    
    

    
    % Number of Runs
    
    nRun=150; %%%%%%%%%%important%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    EE=zeros(1,nRun);
    for r=1:nRun
        % Create and Train ANN
        results=CreateAndTrainANN(xs,t);

        % Calculate Overall Error
        EE(r) = wTrain*results.TrainData.E + wTest*results.TestData.E;
    end
    
    E=mean(EE);
    if isinf(E)
       E=100;
    end
    
    % Calculate Final Cost
    z=[nf
       E];

    % Set Outputs
    out.S=S;
    out.nf=nf;
    out.rf=rf;
    out.E=E;
    out.z=z;
    %out.net=results.net;
    %out.Data=results.Data;
    %out.TrainData=results.TrainData;
    %out.TestData=results.TestData;
    
end