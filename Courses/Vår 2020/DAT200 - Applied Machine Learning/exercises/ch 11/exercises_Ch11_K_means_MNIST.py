# -*- coding: utf-8 -*-
"""
Use the MNIST data of hand-written digits from: https://scikit-learn.org/stable/modules/generated/sklearn.datasets.load_digits.html

Cluster the first 1000 digits using 2-100 clusters and K-means/Fuzzy c-means.

Monitor the development of the distortion as you vary the number of clusters,
and inspect the purity of the clusters 
(proportion of most common digit, e.g. through scipy.stats.mode).
Plot relative distortions (divide by first/highest value) and purity together.

Bonus: Create a cluster-based classifier from the "best" clustering and assess its
performance on the remaining digits.
"""

from sklearn import datasets
from sklearn.cluster import KMeans
import numpy as np
from scipy.stats import mode

# Get MNIST data from scikit-learn
digits = datasets.load_digits()

# Define data and targets, create dummy matrix for target
data = digits['data']
target = digits['target']

# Split the all data into training and test set
train_data = data[:1000, :]
test_data  = data[1000:, :]

train_target = target[:1000]
test_target  = target[1000:]

distortions = []
purity = []
ks = range(2,101)
for k in ks:
    km = KMeans(n_clusters=k,  
                n_init=10,     
                max_iter=300,
                tol=1e-04,     
                random_state=0)
    y_km = km.fit_predict(train_data)
    distortions.append(km.inertia_)
    pur = []
    for j in range(k):
        pur.append(mode(train_target[y_km==j])[1][0]/sum(y_km==j))
    purity.append(np.mean(pur))
distortions = np.array(distortions)

import matplotlib.pyplot as plt
plt.plot(list(ks), purity, label="Purity")
plt.plot(list(ks), distortions/distortions[0], label="Distortion")
plt.legend(loc = "center right")
plt.grid()
plt.show()

##############
# Bonus:
k = 100
km = KMeans(n_clusters=k,  
            n_init=10,     
            max_iter=300,
            tol=1e-04,     
            random_state=0)
y_km = km.fit_predict(train_data)

# Find mode of each cluster
cl = []
for j in range(k):
    cl.append(mode(train_target[y_km==j])[0][0])

# Predict cluster of test data
ypred_km = km.predict(test_data)
ypred_target = []

# Convert cluster number to digit through cluster modes
for pred in ypred_km:
    ypred_target.append(cl[pred])
accuracy = sum(ypred_target==test_target)/len(test_target)
print(accuracy)

#from sklearn.neighbors import KNeighborsClassifier
#nbrs = KNeighborsClassifier(1).fit(train_data, train_target)
#ypred_1NN = nbrs.predict(test_data)
#accuracy = sum(ypred_1NN==test_target)/len(test_target)
#print(accuracy)
