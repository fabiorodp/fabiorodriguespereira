# -*- coding: utf-8 -*-
"""
Created on Mon Mar 16 13:38:02 2020

@author: olto
"""


# =============================================================================
# Import modules
# =============================================================================
from myPCA import PCA # (you are supposed to code your own myPCA.py)
import pandas as pd

from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler


# =============================================================================
# Load data. Here we use wine data as example.
# =============================================================================

df_wine = pd.read_csv('https://archive.ics.uci.edu/ml/'
                      'machine-learning-databases/wine/wine.data',
                      header=None)

df_wine.columns = ['Class label', 'Alcohol', 'Malic acid', 'Ash',
                   'Alcalinity of ash', 'Magnesium', 'Total phenols',
                   'Flavanoids', 'Nonflavanoid phenols', 'Proanthocyanins',
                   'Color intensity', 'Hue',
                   'OD280/OD315 of diluted wines', 'Proline']

df_wine.head()


# =============================================================================
# Prepare data for analysis
# =============================================================================

# Split up into independent data X and target y
X, y = df_wine.iloc[:, 1:].values, df_wine.iloc[:, 0].values

# Split up data into training and test
X_train, X_test, y_train, y_test = \
    train_test_split(X, y, test_size=0.3, 
                     stratify=y,
                     random_state=0)

# Scale data before analysis
sc = StandardScaler()
X_train_std = sc.fit_transform(X_train)
X_test_std = sc.transform(X_test)


# =============================================================================
# Apply PCA for data analysis and access results
# =============================================================================

# Initialise PCA new PCA object
pca_1 = PCA(n_components=4)

# Fit PCA
pca_1.fit(X_train_std)

# Compute cumulative explained variances
cum_expl_var = pca_1.get_cumulative_explained_variances()
# You should get for cum_expl_var:
# array([0.36951469, 0.55386396, 0.67201555, 0.74535807])

# Get scores for X_train_std and X_test_std
X_train_pca = pca_1.transform(X_train_std)
X_test_pca = pca_1.transform(X_test_std)


# You should get for X_train_pca (first five rows):
#  2.38299	0.454585 	-0.227032	  0.579884
# -1.96578	1.65377 	 1.38709	 -1.9422
# -2.53908	1.02909 	 1.32552	 -0.0678108
# -1.43011	0.602401 	 0.555308	 -1.05216
#  3.14147	0.66215	-1.08393	 -0.64089


# You should get for X_test_pca (first five rows):
# -2.23575	 1.86181	 0.489149	 -0.854216
#  0.537318	-1.66134	 0.48085	 -2.18286
# -2.36204	 1.14767	-1.00866	  0.0316635
# -2.09772	-0.15572	-2.14691	 -0.501083
# -2.17164	-1.44365	-0.680643	  0.747605


# Compare also with Jupyter notebook of chapter 5
# There are more results to compare against, like for example W
# https://github.com/rasbt/python-machine-learning-book-3rd-edition/blob/master/ch05/ch05.ipynb




