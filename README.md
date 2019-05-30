# Machine-Learning-Algorithms_M.R.Salmanpour-A.Saberimanesh-A.Rahmim
Machine Learning Algorithms for prediction tasks and feature subset selctor tasks for Parkinson Disease progression (Motor and Non_Motor symptoms)

This project consists of two parts, one is Feature Subset Selection tasks, another is prediction tasks.
For Feature Subset Selection tasks(FSSA), 6 FSSAs were employed and compared to select the most effective features: 1) GA (Genetic Algorithm)2) ACO (Ants Colony Optimization) ,3) PSO (Particle Swarm Optimization), 
4) SA (Simulated Annealing) ,5) DE (Deferential Evolution), and 6) NSGAII (Non-dominated Sorting Genetic Algorithm). All algorithms aimed to minimize the prediction error by selecting the best combination of features,
while NSGAII additionally aimed to reduce number of features. So NSGAII is able to select several optimal combinations.
FSSA codes all implemented in matlab. 
for usage, everyone can load data in LoadData function and perform main for each FSSA from its folder.
For prediction task, we employed 11 algorithms included:
1) LOLIMOT (Local Linear Model Trees)
2) RBF (Radial basis Function), 
3) MLP-BP (Multilayer Perceptron-Back propagation) 
4) LASSOLAR (Least Absolute Shrinkage and Selection Operator – Least Angle Regression) 
5) RFA (Random Forest Algorithm)
6) RNN (Recurrent Neural Network) 
7) BRR (Bayesian Ridge Regression)
8) DTC (Decision Tree Classification) 
9) PAR (Passive Aggressive Regression)
10) Thiel-Sen Regression 
11) ANFIS (Adaptive neuro fuzzy inference system)

-------------------------------------------------------------------------

For predictor algorithms, we implemented them in 2 software, Matlab and Phyton.

 -------------------------------------------------------------------------
 
For implementation by Matlab:
This codes are included 6 predictor algorithms (LOLIMOT (Local Linear Model Trees), RBF (Radial basis Function), Random Forest, MLP_BP (Multilayer Perceptron_ Back propagation), RNN (Recurrent Neural Network) and ANFIS (Adaptive neuro fuzzy inference system)). Automated Machine Learning
Hyperparameter Tuning is applied to some algorithms so that some parameters such as number of neurons for some machines (such as RBF, LOLIMOT and ANFIS and for Random Forest tunes depth) will tune automatically. This code needs a feature table which shows various combinations between features.
So this code is able to work with each combination introduced in Feature table automatically. Also, this code is able to work with various datasheets automatically. Results of each combination for each datasheet will save finally.
They all perform from MAINALL. 

INPUTS:
This code is able to work with various input combinations. it must be loaded in top of program namely Feature_Table.
Be Careful!!! number of each column of Feature_Table must be similar to number of inputs features and target for each datasheet.
This code is able to simultaneously work with several datasheets accompanied with various combinations. Each datasheet should name similarly data1, data2, data3, etc.
Target should add last column of each datasheet. It can be useful for datasheets that are as time series, for example data at year 1, data year 2 and etc. So number of columns of each dataset must be similar to number of inputs and target.

OUTPUTS:
For each function (predictor algorithm), fitting curve of true outcome and predicted outcome draws and saves.
The workspace for each datasheet and for each combination will saved.
Fitting curves of each run (True outcome VS predicted outcome) will save.
Results of each datasheet accompanied with various combinations will save separately.
For other algorithms such as LASSOLAR, BRR (Bayesian Ridge Regression), DTC (Decision Tree Classification), PAR (Passive Aggressive Regression), and Thiel-Sen Regression implemented in Python. 
This code is included 6 predictor algorithms (LASSOLAR, BRR (Bayesian Ridge Regression), DTC (Decision Tree Classification) , PAR (Passive Aggressive Regression), and Thiel-Sen Regression). 
This code needs a feature table which shows various combinations between features. So this code is able to work with each combination in table automatically. Also, this code is able to work with various datasheets automatically. Results of each combination for each datasheet will save finally.

 -------------------------------------------------------------------------
For implementation by Python:
This code is included 6 predictor algorithms(LASSOLAR, BRR (Bayesian Ridge Regression) ,DTC (Decision Tree Classification, Passive Aggressive Regressor,TheilSen Regressor,Linear Regression) 
PAR (Passive Aggressive Regression) , and  Thiel-Sen Regression ). 
This code needs a feature table which shows various combinations between
features. So this code is able to work with each combination 
in  table automatically. Also, this code is able to work with
various datasheets automatically. Results of each combination for each
datasheet will save finally.

-------------------------------------------------------------------------
INPUTS:
This code is able to work with various input combinations. it must be loaded .
Be Careful!!! number of each column of  Feature_Table must be similar to number of inputs features and target for each datasheet.
This code is able to simultaneously work with several datasheets acompanied with various combinations. Each datasheet should name similarely data1, data2, data3, etc.
Target should add last column of each datasheet.It can be useful for
datasheets that are as timeseties, for example data at year 1, data year
2 and etc. So number of columns of each dataseet must be similar to number
of inputs and target.

-------------------------------------------------------------------------
OUTPUTS:
For each function (predictor algorithm), 
True outcome as predicted Outcome will save as mat.file.
Results of each datasheet accompanied with various combinations will save saparately.
Performances (Mean Absolote Errors)for each datasheet (also for each combination) save in Excel finally.

 -------------------------------------------------------------------------
 Datasets:
 There are 2 kinds ogf dataset:
 1) Motor datasets included 4 randomized arrangements.
 2) Non_Motor datasets included:
 I) Main datasets included 10 randomized arrangements of the dataset (included 184 patients).
 II) Independent test datasets that patients selections are based on results of FSSAs for selecting more patients.
 
 Tables:
 All required tables placed in Datasets.
 
  -------------------------------------------------------------------------

AUTHOR(S):
- Mohammad Reza Salmanpour Paeen Afrakati, Abdollah Saberimanesh
-------------------------------------------------------------------------
STATEMENT:
This files are part of prediction tasks and optimal feature selection for Parkinson disease progression (Prediction task). Package by Mohammad Reza Salmanpour, Abdollah Saberimanesh and Arman Rahmim.
--> Copyright (C) 2018-2019 Mohammad Reza Salmanpour ,Amirkabir University of Technology (Tehran Polytechnic) 
All rights reserved for Mohammad Reza Salmanpour Paeen Afrakati, Abdollah Saberimanesh and Arman Rahmim.
This package is distributed in the hope that it will be useful,

Any feedback welcome!!!
m.salmanpoor66@gmail.com, mohamad91@aut.ac.ir
