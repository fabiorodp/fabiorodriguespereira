"""
Excercises for Kernels:

(1) Simple: Test the effect of using the Laplacian kernel with SVM on previously used datasets.
	http://scikit-learn.org/stable/modules/metrics.html

(2) Technical: Create your own estimator in scikit-learn format where you
    combine a chosen kernel with the Perceptron (or even better, any kernel). 
Follow the framework in scikit learn such that the esimator can be used in a pipeline:
	http://scikit-learn.org/stable/developers/contributing.html#rolling-your-own-estimator
The code below corresponds to the code from around line 64 here:
	https://github.com/scikit-learn-contrib/project-template/
Change the name of TemplateClassifier into something sensible, e.g. kernelPerceptron
    and adapt it to perform kernel Perceptron (or more general).

Add a working example as a comment.
"""

"""
# My example:      <---------------------
#    sensible code that uses the class below on the make_moon data or similar
# e.g. import kernelPerceptron as kp, and so on
"""

import numpy as np
from sklearn.base import BaseEstimator, ClassifierMixin
from sklearn.utils.validation import check_X_y, check_array, check_is_fitted
from sklearn.utils.multiclass import unique_labels
from sklearn.metrics import euclidean_distances


# Change my name, please!
class TemplateClassifier(BaseEstimator, ClassifierMixin):
    """ Example documentation that can be updated if you want to.
    For more information regarding how to build your own classifier, read more
    in the :ref:`User Guide <user_guide>`.
    Parameters
    ----------
    demo_param : str, default='demo'       <---------------------
        A parameter used for demonstation of how to pass and store paramters.
    Attributes
    ----------
    X_ : ndarray, shape (n_samples, n_features)
        The input passed during :meth:`fit`.
    y_ : ndarray, shape (n_samples,)
        The labels passed during :meth:`fit`.
    classes_ : ndarray, shape (n_classes,)
        The classes seen at :meth:`fit`.
    """
    def __init__(self, demo_param='demo'):
        # Exchange demo_param in call and usage, e.g. to the RBF kernel     <-----------------
        # parameter or similar.
        self.demo_param = demo_param

    def fit(self, X, y):
        """A reference implementation of a fitting function for a classifier.
        Parameters
        ----------
        X : array-like, shape (n_samples, n_features)
            The training input samples.
        y : array-like, shape (n_samples,)
            The target values. An array of int.
        Returns
        -------
        self : object
            Returns self.
        """
        # Check that X and y have correct shape
        X, y = check_X_y(X, y)
        # Store the classes seen during fit
        self.classes_ = unique_labels(y)

        self.X_ = X
        self.y_ = y
        
        # Insert your classifier code here    <------------------
        
        # Return the classifier
        return self

    def predict(self, X):
        """ A reference implementation of a prediction for a classifier.
        Parameters
        ----------
        X : array-like, shape (n_samples, n_features)
            The input samples.
        Returns
        -------
        y : ndarray, shape (n_samples,)
            The label for each sample is the label of the closest sample
            seen during fit.
        """
        # Check is fit had been called
        check_is_fitted(self, ['X_', 'y_'])

        # Input validation
        X = check_array(X)

        # Exchange the following line with code that performs prediction:  <---------------------
        closest = np.argmin(euclidean_distances(X, self.X_), axis=1)
        return self.y_[closest]

