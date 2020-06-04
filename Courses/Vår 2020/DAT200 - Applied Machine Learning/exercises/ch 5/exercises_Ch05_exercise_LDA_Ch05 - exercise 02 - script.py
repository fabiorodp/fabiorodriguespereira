# -*- coding: utf-8 -*-
"""
Created on Mon Mar 16 18:52:02 2020

@author: olto
"""


# =============================================================================
# Import modules
# =============================================================================
from myLDA import LDA # (you are supposed to code your own myPCA.py)
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
# Apply LDA for data analysis and access results
# =============================================================================

# Initialise LDA oject
lda_1 = LDA(n_components=2, scaled_S_W=True)

# Fit PCA
lda_1.fit(X_train_std, y_train)

# Compute cumulative dicriminability ratio
cum_discr_ratio = lda_1.get_cumulative_discriminability_ratio()
# You should get for cum_expl_var:
# array([0.66927956, 1.        ])

# LDA features for X_train_std and X_test_std
X_train_lda = lda_1.transform(X_train_std)
X_test_lda = lda_1.transform(X_test_std)


# You should get for X_train_lda (first five rows):
#  1.31763	-0.640405
# -1.41851	-1.21538
# -1.32931	-0.590063
# -1.14332	-0.894221
#  1.56039	-0.600522



# You should get for X_test_lda (first five rows):
# -1.43157	-1.78342
#  0.412832	 1.55724
# -1.86987	-1.90256
# -1.63519	-0.700469
# -0.818228	 1.8374

# Compare also with Jupyter notebook of chapter 5
# There are more results to compare against, like for example W
# https://github.com/rasbt/python-machine-learning-book-3rd-edition/blob/master/ch05/ch05.ipynb













