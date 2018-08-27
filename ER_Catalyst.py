
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
from datetime import datetime, timedelta
from dateutil.parser import parse
from pandas.tseries.offsets import Day
from sklearn import linear_model
# import warnings; warnings.simplefilter('ignore')
pd.set_option("display.max_columns", 100)
pd.set_option('display.max_rows', 500)
get_ipython().run_line_magic('matplotlib', 'inline')


# In[ ]:


## function that loops through each ER event, and then loops through relevent claims and sums total cost by types.
def find_claims_associated_with_ER(ER_visits, claims):
    sum_in_window = list(np.zeros(programs.shape[0]))
    for index, row in ER_visits.iterrows():
        pat_claims = claims[claims['EMPI']==row['EMPI']]
        sum_of_claims = 0
        for index2, row2 in pat_claims.iterrows():
            if (row2['date'] < row['end_date']) & (row2['date'] > row['begin_date']):
                sum_of_claims+=row2['HCP_Cost']
        sum_in_window[index] = sum_of_claims
    return sum_in_window

