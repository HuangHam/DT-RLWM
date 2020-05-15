
import numpy as np # for numeric calculations
import time#calculate runtime
import Agents as ag
import func as f

#%%
agent_list = [ag.RLWM_noneFree(),ag.RLWM_allFree(),ag.RLWM_noise(),ag.RLWM_modulation(), ag.RLWM_actionSoftmax()]
start_time = time.time()
AICs, BICs = f.modRec(agent_list, initSample=22, endSample=33)
print("--- %s seconds ---" % (time.time() - start_time))
np.savez('Model_Recovery', AICs = AICs, BICs = BICs) # save the file as "outfile_name.npy"