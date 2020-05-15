#%%

# import necessary packages
import numpy as np # for numeric calculations
import pandas as pd
import func as f
import Agents as ag
agent_list = [ag.RLWM_noneFree(),ag.RLWM_allFree(),ag.RLWM_noise(),ag.RLWM_modulation(), ag.RLWM_actionSoftmax()]
numMod, numBlocks = len(agent_list), len(agent_list[0].Sub)
ModOrder = iter(range(numMod))
AICs, BICs, Mods = np.zeros((numBlocks, numMod)), np.zeros((numBlocks, numMod)), np.empty(numMod, dtype="object")
AICs_te, BICs_te = np.zeros((numBlocks, numMod)), np.zeros((numBlocks, numMod))

#%%

for i in agent_list:
    Order = next(ModOrder)
    agent = agent_list[Order]
    ModFit = np.load('../ModelFit/ModFit'+agent.name+'.npz',allow_pickle=True) # loads your saved array into variable a.
    te_ModFit = np.load('../Testing_ModelFit/Testing_ModelFit' + agent.name + '.npz', allow_pickle=True)
    f.ParamBar(agent.name,agent.pname, ModFit['Params'], ModFit['Ks'])
    AICs[:, Order], BICs[:, Order], Mods[Order] = ModFit['AICs'], ModFit['BICs'], ModFit['agtName']
    AICs_te[:, Order], BICs_te[:, Order] = te_ModFit['AICs'], te_ModFit['BICs']

#%%
Mods = ['noneFree', 'allFree', 'noise', 'modulation', 'action confusion']
f.ICBar(AICs, BICs, Mods, degree = 10)
