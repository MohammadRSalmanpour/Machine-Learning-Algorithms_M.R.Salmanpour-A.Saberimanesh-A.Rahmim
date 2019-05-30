  
# Multi algorithms for outcome prediction task In Python.
# -------------------------------------------------------------------------
# DESCRIPTION:
# This code is included 6 predictor algorithms(LASSOLAR, BRR (Bayesian Ridge Regression) ,DTC (Decision Tree Classification, Passive Aggressive Regressor,TheilSen Regressor,Linear Regression) 
#PAR (Passive Aggressive Regression) , and  Thiel-Sen Regression ). 
#This code needs a feature table which shows various combinations between
#features. So this code is able to work with each combination 
#in  table automatically. Also, this code is able to work with
#various datasheets automatically. Results of each combination for each
#datasheet will save finally.
#-------------------------------------------------------------------------
#INPUTS:
#This code is able to work with various input combinations. it must be loaded .
#Be Careful!!! number of each column of  Feature_Table must be similar to number of inputs features and target for each datasheet.
#This code is able to simultaneously work with several datasheets acompanied with various combinations. Each datasheet should name similarely data1, data2, data3, etc.
#Target should add last column of each datasheet.It can be useful for
#datasheets that are as timeseties, for example data at year 1, data year
#2 and etc. So number of columns of each dataseet must be similar to number
#of inputs and target.
#-------------------------------------------------------------------------
#OUTPUTS:
#For each function (predictor algorithm), 
#True outcome as predicted Outcome will save as mat.file.
#Results of each datasheet accompanied with various combinations will save saparately.
#Performances (MEan Absolote Errors)for each datasheet (also for each combination) save in Excel finally.
#-------------------------------------------------------------------------
#AUTHOR(S):
#Abdollah Saberimanesh, Mohammad Reza Salmanpour Paeen Afrakati
#-------------------------------------------------------------------------
#-------------------------------------------------------------------------
#STATEMENT:
#This file is part of prediction task for Parkinson disease progression. Package by Mohammad Reza Salmanpour, Abdollah Saberimanesh and Arman Rahmim.
#--> Copyright (C) 2018-2019  Mohammad Reza Salmanpour ,Amirkabir University of Technology (Tehran Polytechnic) 
#All rights reserved for Mohammad Reza Salmanpour Paeen Afrakati, Abdollah Saberimanesh and Arman Rahmim.
#This package is distributed in the hope that it will be useful,

#Any feedback welcome!!!
#m.salmanpoor66@gmail.com, mohamad91@aut.ac.ir
#########################################################################################################################################  
  
  #AUTHOR(S):
#- Mohammad Reza Salmanpour Paeen Afrakati, Abdollah Saberimanesh
#-------------------------------------------------------------------------
#-------------------------------------------------------------------------
#STATEMENT:
#This file is part of prediction task for Parkinson disease progression. Package by Mohammad Reza Salmanpour, Abdollah Saberimanesh and Arman Rahmim.
#--> Copyright (C) 2018-2019  Mohammad Reza Salmanpour ,Amirkabir University of Technology (Tehran Polytechnic) 
#All rights reserved for Mohammad Reza Salmanpour Paeen Afrakati, Abdollah Saberimanesh and Arman Rahmim.
#This package is distributed in the hope that it will be useful,

#Any feedback welcome!!!
#m.salmanpoor66@gmail.com, mohamad91@aut.ac.ir

from sklearn import tree
#from sklearn import svm
import random
import numpy as np
from sklearn import linear_model
import os, errno
import scipy.io as spio

classifiers = []
	
classistr=['DecisionTreeClassifier','BayesianRidge','LassoLars','PassiveAggressiveRegressor','TheilSenRegressor','LinearRegression']

file='4'
folder1='data'
folder=folder1+file
fin=folder1+file+'.mat'

print(fin)


#arr=np.genfromtxt(fin,delimiter=',')
arr1=spio.loadmat(fin,squeeze_me =True)
arrfeatures1=spio.loadmat('Tablefeature.mat',squeeze_me =True)
print(arr1.keys())
print(arr1['AllSelextdataXY'])
arrOrg = np.array(list(arr1['AllSelextdataXY']),dtype=float)
arrfeatures = np.array(list(arrfeatures1['TableFeatures']),dtype=float)
#arr2 = np.fromiter(arr1['data'], dtype=buffer)
#arr = np.fromiter(arr1['data'], dtype=float)
print(arrOrg)

COLS=0
X1=1
X2=0
TrainPercent=0.65
TrainRows=130
ROWS=0
#Test=140
arrout=[]


def mainfunc(alg):


	#labelsAll[labelsAll>1]=2

	#labels = labelsAll[0:TrainRows]

	#print(labels)
	#print(arr[Test:Test+1,X2:X2+1])

	#clf = svm.SVC(decision_function_shape='ovo',probability=True)

	#clf = tree.DecisionTreeClassifier()
	#for item in classifiers:
	#	item = item.fit(features, labels)


	#print(clf.predict(arr[Test:Test+1,X1:X2]))

	mOk=0
	mErr=0
	global arrout
	arrout=[]
	#row=[0,0]
	
	clf = classifiers[alg]
	
	clf.fit(features, labels)
	for x in range(0,len(testData)-1,1):
		#print(x);
		m=(clf.predict(testData[x:x+1,X1:X2-1])/1000)
		#row[i+1]=m
		l=testData[x:x+1,X2-1:X2]
		#row[0]=l
		arrout.append([m,l])
		#if m==labelsAll[x]:
		#	mOk+=m
		#else:
		#	mErr+=1
		mOk+=abs(m-l)
		mErr+=1
		#print('Error X:',x,' M:',m)
		

	print('-----------------------------------------')
	#print(mOk)
	#print(mErr)
	ret=mOk/(mErr);
	#print(len(arrout))
	#print('Mean Absolute Error',ret)
	return ret;

	
	




i=0;
absout=[]#np.zeros([1, len(classifiers)])

print("arrOrg ",arrOrg)
print("arrfeatures ",arrfeatures)

while i<len(arrfeatures):
	i+=1;
	classifiers = [
		tree.DecisionTreeClassifier(),
		linear_model.BayesianRidge(),
		linear_model.LassoLars(),
		linear_model.PassiveAggressiveRegressor(),
		linear_model.TheilSenRegressor(),
		linear_model.LinearRegression()]
	curFea=arrfeatures[i-1]
	arrtemp=[]#arrOrg[:,0:1];
	for c in range(0, len(curFea)):
		print("curFea[c] ",curFea[c])
		if curFea[c]>0:
			#print("Adding ",arrOrg[:,c:c+1].reshape(-1))
			arrtemp.append(c)
	#print("arr ",arr)
	arr=arrOrg[:,arrtemp]
	COLS=len(arr[0])
	X2=COLS-1
	ROWS=len(arr)
	TrainRows=int(ROWS*TrainPercent)
	print("COLS ",COLS)
	print("ROWS ",ROWS)
	print("TrainRows ",TrainRows)
	trainData =arr[0:TrainRows-1,X1:X2+1] 
	testData = arr[TrainRows:ROWS-1,X1:X2+1]
	#print("trainData ",trainData)
	#print("testData ",testData)
	features =trainData[0:(len(trainData)-1),X1:X2-1] 
	labels =(trainData[0:len(trainData)-1,X2-1:X2].reshape(-1)*1000).astype(int)
	#print('features ',features)
	#print('labels ',labels)  




	for x in range(0,len(classifiers)-1,1):
		res=15
		#while res>12:
		res=mainfunc(x)
		print('New Mean abs error '+classistr[x]+' ',res)
		#if res<15:
		if not os.path.exists(folder):
			os.makedirs(folder)
		fl=folder+'/'+classistr[x]
		if not os.path.exists(fl):
			os.makedirs(fl)
			
		fname=fl+'/'+'Set_{:d}.mat'.format(i)
		dataname='data'
		spio.savemat(fname, {dataname:arrout})
		#np.savetxt(fname, arrout, delimiter=",")
		fname=fl+'/MEAN_ABS.csv'
		if i==1 and os.path.isfile(fname):
			os.remove(fname)
		fout='{0:d},{1:f}\n'.format(i,res[0][0])		
		filew = open(fname,"a") 
		filew.write(fout) 
		filew.close() 

#absout.append([classistr[x],str(x),str(res)])

#fout='M_OUT{0:d}-ABS.csv'.format(file)		
#np.savetxt(fout, absout, delimiter=",")
		