import pandas as pd # for python data frame
import numpy as np # for numeric calculations
import Agents as ag
import func as f
#%%
agent_list = [ag.RLWM_modulation(), ag.RLWM_actionSoftmax()]

#%%
agent = ag.RLWM_actionSoftmax()
lambdaST, lambdaDT = agent.pname.index('lambdaST'), agent.pname.index('lambdaDT')  # wrong credit assignment weight
ModFit = np.load('../ModelFit/ModFit' + agent.name + '.npz', allow_pickle=True)  # if no error returned
Params =ModFit['Params']
lambdaST = np.array([p[lambdaST] for p in Params])
lambdaDT = np.array([p[lambdaDT] for p in Params])
dataset = pd.DataFrame({'lambdaST': lambdaST, 'lambdaDT': lambdaDT})
dataset.to_csv(r'lambda.csv', index=False, header=True)
'''
for agent in agent_list:
    agent.Sim_agent()
    data = f.actBias(pd.read_csv("../Learning_Validation/"+agent.name+".csv"))
    data.to_csv(r'../Action_Bias/'+agent.name+'.csv', index=False, header=True)

data = f.actBias(pd.read_csv("../Subject_Data/DT-RLWM-version4.csv"))
data.to_csv(r'../Action_Bias/DT-RLWM-version4.csv',index=False, header=True)
'''