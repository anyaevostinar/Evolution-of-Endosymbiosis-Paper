#a script to run several replicates of several treatments locally

directory = "" #set this to whichever directory you would like data files stored in
seeds = range(10,22)
vts = [0.0,0.1,0.2,0.4,0.5,0.6,0.8,0.9,1.0]

import subprocess

def cmd(command):
    '''This wait causes all executions to run in sieries.                          
    For parralelization, remove .wait() and instead delay the                      
    R script calls unitl all neccesary data is created.'''
    return subprocess.Popen(command, shell=True).wait()

def silent_cmd(command):
    '''This wait causes all executions to run in sieries.                          
    For parralelization, remove .wait() and instead delay the                      
    R script calls unitl all neccesary data is created.'''
    return subprocess.Popen(command, shell=True, stdout=subprocess.PIPE).wait()

#needs executable ./symbulation

for a in seeds:        
    for vt in vts:
        command_str = './symbulation -VERTICAL_TRANSMISSION '+str(vt)+' -SEED '+str(a)+' -START_MOI 1 -FILE_PATH '+directory+' -FILE_NAME SM1_Seed'+str(a)+'_VT'+str(vt) 
        print(command_str)
        cmd(command_str)
