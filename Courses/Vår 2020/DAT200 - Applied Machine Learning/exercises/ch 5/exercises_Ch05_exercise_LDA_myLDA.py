# -*- coding: utf-8 -*-
"""
Created on Mon Mar 16 18:52:33 2020

@author: olto
"""


# =============================================================================
# Import modules
# =============================================================================

import numpy as np


# =============================================================================
# Code for PCA class
# =============================================================================

class LDA(object):
    """
    Linear Discriminant Analysis
    
    Parameters
    ----------
    n_components : int 
        number of components to compute
    """
    def __init__(self, n_components=None, scaled_S_W=False):
        self.n_components = n_components
        self.scaled_S_W = scaled_S_W
        

    def fit(self, X, y):
        """
        Fit training data.
        
        Parameters
        ----------
        X : {array-like}, shape = [n_samples, n_features]
            n_examples is the number of samples
            n_features is the number of features
        
        Returns
        -------
        self : object
        """  
        
        # Identify number and label of classes in y.
        unique_labels = list(np.unique(y))
        
        # Compute feature means for each class
        mean_vecs = []
        for ind, label in enumerate(unique_labels):
            mean_vecs.append(np.mean(X[y == label], axis=0))        
        
        # Check whether user requests scaling of within-class scatter matrices
        # or not and compute correspondingly
        d = np.shape(X)[1] # number of features
        if self.scaled_S_W == False:
        
            # Compute within-class scatter matrices
            S_W = np.zeros((d, d))
            for label, mv in zip(unique_labels, mean_vecs):
                class_scatter = np.zeros((d, d))  # scatter matrix for each class
                for row in X[y == label]:
                    row, mv = row.reshape(d, 1), mv.reshape(d, 1)  # make column vectors
                    class_scatter += (row - mv).dot((row - mv).T)
                S_W += class_scatter                          # sum class scatter matrices
        
        else:            
            # Compute scaled within-class scatter matrices that take into 
            # account sample distribution across classes
            d = 13  # number of features
            S_W = np.zeros((d, d))
            for label, mv in zip(unique_labels, mean_vecs):
                class_scatter = np.cov(X[y == label].T)
                S_W += class_scatter
                    
        # Compute between-classes scatter matrix
        mean_overall = np.mean(X, axis=0)
        S_B = np.zeros((d, d))
        for i, mean_vec in enumerate(mean_vecs):
            n = X[y == i + 1, :].shape[0]
            mean_vec = mean_vec.reshape(d, 1)  # make column vector
            mean_overall = mean_overall.reshape(d, 1)  # make column vector
            S_B += n * (mean_vec - mean_overall).dot((mean_vec - mean_overall).T)
                
        # Decompose Sw-1Sb
        self.eigen_vals, eigen_vecs = np.linalg.eig(np.linalg.inv(S_W).dot(S_B))
        
        # Make a list of (eigenvalue, eigenvector) tuples
        eigen_pairs = [(np.abs(self.eigen_vals[i]), eigen_vecs[:, i])
                       for i in range(len(self.eigen_vals))]

        # Sort the (eigenvalue, eigenvector) tuples from high to low
        eigen_pairs.sort(key=lambda k: k[0], reverse=True)
        
        # Construct transformation matrix W depending on how many components
        # have been selected by the user.
        if self.n_components is None:
            self.n_components = len(unique_labels) - 1
        
        w_list = []
        for comp in range(self.n_components):
            w_list.append(eigen_pairs[comp][1][:, np.newaxis].real)
        
        self.w = np.hstack(w_list)
            
        return self


    def transform(self, X):
        """
        Transforms the features and its values in X to principal components
        (PC) and scores. 
        
        Paramters
        ---------
        X : {array-like}, shape = [n_samples, n_features]
            n_samples is the number of examples
            n_features is the number of features.
        
        Returns
        -------
        transformed X : {array-like}, shape = [n_examples, n_components]
            n_examples is the number of examples
            n_components is the number of components holding scores
        """
        return X @ self.w


    def get_cumulative_discriminability_ratio(self):
        """
        Compute cumulative discriminability ratio.
        
        Returns
        -------
        cumulative dicriminability ratio : {array-like}, shape = [1, n_components]
        """
        tot = sum(self.eigen_vals.real)
        discr = [(i / tot) for i in sorted(self.eigen_vals.real, reverse=True)]
        selected_discr = discr[:self.n_components]
        
        return np.cumsum(selected_discr)


