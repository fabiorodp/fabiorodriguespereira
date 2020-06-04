# -*- coding: utf-8 -*-

"""
Helper functions to download historical quotation data of companies listed
at B3 (BMF/BOVESPA).
"""

__author__ = "Fábio Rodrigues Pereira"
__email__ = "fabio@fabiorodriguespereira.com"


# docstring example:
"""
    Downloads tickers' codes from Fundamentus website

    Parameters
    ----------
    params : array_like
        The parameter estimates.

    Returns
    -------
    pd.DataFrame
        Pandas DataFrame with three columns:
            'Papel':            Ticker
            'Nome Comercial':   Trade Name
            'Razão Social':     Corporate Name

    Notes
    --------
    .. math:: -\frac{n}{2}\log SSR
              -\frac{n}{2}\left(1+\log\left(\frac{2\pi}{n}\right)\right)
              -\frac{1}{2}\log\left(\left|W\right|\right)

    where :math:`W` is a diagonal weight matrix matrix and
    :math:`SSR=\left(Y-\hat{Y}\right)^\prime W \left(Y-\hat{Y}\right)` is
    the sum of the squared weighted residuals.
"""
