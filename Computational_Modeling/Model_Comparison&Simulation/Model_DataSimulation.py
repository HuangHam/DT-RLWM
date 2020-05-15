#%%
# import necessary packages
import pandas as pd # for python data frame
import time#calculate runtime
import numpy as np # for numeric calculations
import Agents as ag
import func as f
m = np.load('../Model_Recovery/Model_Recovery_Sub1.npz') # save the file as "outfile_name.npy"
print(m['AICs'][:,:,1])
#%%
agent_list = [ag.RLWM_modulation(), ag.RLWM_actionSoftmax()]

#%%


'''
for agent in agent_list:
    agent.Sim_agent()
    data = f.actBias(pd.read_csv("../Learning_Validation/"+agent.name+".csv"))
    data.to_csv(r'../Action_Bias/'+agent.name+'.csv', index=False, header=True)

data = f.actBias(pd.read_csv("../Subject_Data/DT-RLWM-version4.csv"))
data.to_csv(r'../Action_Bias/DT-RLWM-version4.csv',index=False, header=True)
'''