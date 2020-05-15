import numpy as np # for numeric calculations
import Agents as ag
import func as f
#%%
model = ag.RLWM_actionSoftmax()
#genrec, optimcurve, bounds = f.genRec(model)
#np.savez('genRec'+model.name, genrec = genrec, optimcurve = optimcurve, bounds = bounds)
#%%
agent = ag.RLWM_actionSoftmax()
genRec = np.load('genRec'+model.name+'.npz')
#genrec = np.log(genRec['genrec'])
f.recPlot(['\u03B1', '\u03C6', '\u03C1', '\u03B5', '\u03B3', '\u03BB TS', '\u03BB DT' ], genRec['bounds'], genRec['genrec'])
