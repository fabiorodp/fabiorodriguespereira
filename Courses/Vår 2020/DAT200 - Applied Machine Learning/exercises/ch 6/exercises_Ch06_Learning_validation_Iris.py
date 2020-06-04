# -*- coding: utf-8 -*-
"""
Created on Mon Mar 19 12:55:10 2018

@author: kristl
"""

from sklearn.model_selection import learning_curve
import numpy as np
import matplotlib.pyplot as plt
from sklearn.model_selection import validation_curve
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression
from sklearn.pipeline import make_pipeline
import pandas as pd

df = pd.read_csv('https://archive.ics.uci.edu/ml/'
        'machine-learning-databases/iris/iris.data', header=None)
X = df.iloc[:,0:3].values
y = df.iloc[:,4].values

# Simple pipeline with variable scaling and L2 penalized Logistic Regression
pipe_lr = make_pipeline(StandardScaler(),
                        LogisticRegression(penalty='l2', random_state=1, \
                                           solver='lbfgs', multi_class='auto'))

# Indexes for data set to avoid single class selection
idx = []
for i in range(50):
    sub = list(range(i,150,50))
    for elem in sub:
        idx.append(elem)

######################################################
# Calculate learning curves for training and test sets
train_sizes, train_scores, test_scores =\
                learning_curve(estimator=pipe_lr,
                               X=X[idx,:],
                               y=y[idx],
                               train_sizes=np.linspace(0.1, 1.0, 10),
                               cv=10, # Stratified KFold by default
                               n_jobs=1)

train_mean = np.mean(train_scores, axis=1) # Predict training data
train_std = np.std(train_scores, axis=1)
test_mean = np.mean(test_scores, axis=1)   # Cross-validation
test_std = np.std(test_scores, axis=1)

plt.plot(train_sizes, train_mean,
         color='blue', marker='o',
         markersize=5, label='training accuracy')

plt.fill_between(train_sizes,
                 train_mean + train_std,
                 train_mean - train_std,
                 alpha=0.15, color='blue')

plt.plot(train_sizes, test_mean,
         color='green', linestyle='--',
         marker='s', markersize=5,
         label='validation accuracy')

plt.fill_between(train_sizes,
                 test_mean + test_std,
                 test_mean - test_std,
                 alpha=0.15, color='green')

plt.grid()
plt.xlabel('Number of training samples')
plt.ylabel('Accuracy')
plt.legend(loc='lower right')
plt.ylim([0.8, 1.03])
plt.tight_layout()
plt.show()


#########################################################
# Calculate validation curves for training and test sets
param_range = [0.001, 0.01, 0.1, 1.0, 10.0, 100.0, 1000.0, 10000.0, 100000.0]
train_scores, test_scores = validation_curve(
                estimator=pipe_lr, 
                X=X, 
                y=y, 
                param_name='logisticregression__C', # The parameter to vary
                param_range=param_range,            # ... and its values
                cv=10) # Stratified KFold by default

train_mean = np.mean(train_scores, axis=1)
train_std = np.std(train_scores, axis=1)
test_mean = np.mean(test_scores, axis=1)
test_std = np.std(test_scores, axis=1)

plt.plot(param_range, train_mean, 
         color='blue', marker='o', 
         markersize=5, label='training accuracy')

plt.fill_between(param_range, train_mean + train_std,
                 train_mean - train_std, alpha=0.15,
                 color='blue')

plt.plot(param_range, test_mean, 
         color='green', linestyle='--', 
         marker='s', markersize=5, 
         label='validation accuracy')

plt.fill_between(param_range, 
                 test_mean + test_std,
                 test_mean - test_std, 
                 alpha=0.15, color='green')

plt.grid()
plt.xscale('log')
plt.legend(loc='lower right')
plt.xlabel('Parameter C')
plt.ylabel('Accuracy')
plt.ylim([0.8, 1.0])
plt.tight_layout()
plt.show()


######################################################
# Repeat learning curve with selected paramter value
pipe_lr = make_pipeline(StandardScaler(),
                        LogisticRegression(penalty='l2', random_state=1, \
                                           solver='lbfgs', multi_class='auto'))
pipe_lr.named_steps['logisticregression'].set_params(C=1000)
train_sizes, train_scores, test_scores =\
    learning_curve(estimator=pipe_lr,
                   X=X[idx,:],
                   y=y[idx],
                   train_sizes=np.linspace(0.1, 1.0, 10),
                   cv=10, # Stratified KFold by default
                   n_jobs=1)

# Calculate learning curves for training and test sets
train_mean = np.mean(train_scores, axis=1) # Predict training data
train_std = np.std(train_scores, axis=1)
test_mean = np.mean(test_scores, axis=1)   # Cross-validation
test_std = np.std(test_scores, axis=1)

plt.plot(train_sizes, train_mean,
         color='blue', marker='o',
         markersize=5, label='training accuracy')

plt.fill_between(train_sizes,
                 train_mean + train_std,
                 train_mean - train_std,
                 alpha=0.15, color='blue')

plt.plot(train_sizes, test_mean,
         color='green', linestyle='--',
         marker='s', markersize=5,
         label='validation accuracy')

plt.fill_between(train_sizes,
                 test_mean + test_std,
                 test_mean - test_std,
                 alpha=0.15, color='green')

plt.grid()
plt.xlabel('Number of training samples')
plt.ylabel('Accuracy')
plt.legend(loc='lower right')
plt.ylim([0.8, 1.03])
plt.tight_layout()
plt.show()
