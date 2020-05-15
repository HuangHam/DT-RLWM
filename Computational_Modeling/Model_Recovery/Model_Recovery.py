import matplotlib.pyplot as plt # for plotting. Make sure use ggplot style for consistency
import numpy as np # for numeric calculations
import func as f
import Agents as ag
#%%
agent_list = [ag.RLWM_noneFree(),ag.RLWM_allFree(),ag.RLWM_noise(),ag.RLWM_modulation(), ag.RLWM_actionSoftmax()]
nSample = 33
AICs, BICs = np.empty((len(agent_list), len(agent_list), nSample)), np.empty((len(agent_list), len(agent_list), nSample))

for i in range(nSample):
    ModRec = np.load('Model_Recovery_Sub'+str(i+1)+'.npz', allow_pickle=True)
    AIC, BIC = ModRec['AICs'], ModRec['BICs']
    AICs[:,:,i], BICs[:,:,i] = AIC[:,:,i], BIC[:,:,i]

np.savez('Model_Recovery', AICs = AICs, BICs = BICs) # save the file as "outfile_name.npy"

lab = ['noneFree', 'allFree', 'noise', 'modulation', 'action confusion']
#fig, (ax1,ax2) = plt.subplots(1, 2, figsize=(13, 6))
x, y = 'recovering model', 'simulating model'

im, _ = f.heatmap(np.mean(AICs==0,2), lab, lab, x, y,#ax=ax1,
                cmap="PuBu")#, cbarlabel='simulating model')
f.annotate_heatmap(im, valfmt="{x:.1f}", size=20)
plt.show()

im, _ = f.heatmap(np.mean(BICs==0,2), lab, lab, x, y,#ax=ax2,
                cmap="Wistia")#, cbarlabel='simulating model')
f.annotate_heatmap(im, valfmt="{x:.1f}", size=20)

#plt.tight_layout()
plt.show()