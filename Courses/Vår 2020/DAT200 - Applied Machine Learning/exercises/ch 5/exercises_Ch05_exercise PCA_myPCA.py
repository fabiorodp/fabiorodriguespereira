# -*- coding: utf-8 -*-
"""
Created on Mon Mar 16 13:30:49 2020

@author: olto
"""

# =============================================================================
# Import modules
# =============================================================================

import numpy as np


# =============================================================================
# Code for PCA class
# =============================================================================

class PCA(object):
    """
    Principal Component Analysis
    
    Parameters
    ----------
    n_components : int 
        number of components to compute
    """
    def __init__(self, n_components=None):
        self.n_components = n_components
        

    def fit(self, X):
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
        # Compute covariance matrix for input data. Note that numpy's 
        # np.linalg.eig function already does the sorting eigenvectors for you 
        # by size of the eigenvalues. 
        # If we had used SVD on cov_mat, we would need to do the sorting 
        # ourselves.
        cov_mat = np.cov(X.T)
        self.eigen_vals, eigen_vecs = np.linalg.eig(cov_mat)
        
        # Make a list of (eigenvalue, eigenvector) tuples
        eigen_pairs = [(np.abs(self.eigen_vals[i]), eigen_vecs[:, i])
                       for i in range(len(self.eigen_vals))]

        # Sort the (eigenvalue, eigenvector) tuples from high to low (if the
        # eigenpairs were not sorted for some reason)
        eigen_pairs.sort(key=lambda k: k[0], reverse=True)
        
        # Construct transformation matrix W depending on how many components
        # have been selected by the user.
        if self.n_components is None:
            self.n_components = np.shape(X)[1]
        
        w_list = []
        for comp in range(self.n_components):
            w_list.append(eigen_pairs[comp][1][:, np.newaxis])
        
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


    def get_cumulative_explained_variances(self):
        """
        Compute cumulative explained variance in X.
        
        Returns
        -------
        cumulative explained variance : {array-like}, shape = [1, n_components]
        """
        tot = sum(self.eigen_vals)
        var_exp = [(i / tot) for i in sorted(self.eigen_vals, reverse=True)]
        selected_var_exp = var_exp[:self.n_components]
        
        return np.cumsum(selected_var_exp)
