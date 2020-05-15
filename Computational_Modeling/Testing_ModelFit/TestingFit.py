#%%
# import necessary packages
import pandas as pd # for python data frame
import time#calculate runtime
import numpy as np # for numeric calculations
import Agents as ag
import func as f
#%%
agent_list = [ag.RLWM_noneFree(),ag.RLWM_allFree(),ag.RLWM_noise(),ag.RLWM_modulation()]

#%%
for agent in agent_list:
    agent.te_IC()


