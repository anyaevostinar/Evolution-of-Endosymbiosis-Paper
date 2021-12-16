#a script to run several replicates of several treatments locally
# Assumes that symbulation-default and SymSettings.cfg are already in this folder
import sys

start_range = 10
end_range = 41
if(len(sys.argv) > 1):
    start_range = int(sys.argv[1])
    end_range = int(sys.argv[2])
else:
    print("Using default seeds " + str(start_range) + " " + str(end_range))

seeds = range(start_range, end_range)

host_resources = [10, 50, 100, 500, 1000]
free_sym_resources = [10, 50, 100, 500, 1000]
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
    for hr in host_resources:
        for sr in free_sym_resources:
            command_str = './symbulation_default -RES_DISTRIBUTE '+str(hr)+' -FREE_SYM_RES_DISTRIBUTE '+str(sr)+' -SEED '+str(a)+' -FILE_NAME Seed'+str(a)+'_HR'+str(hr)+'_SR'+str(sr)
            settings_filename = 'Output_Seed'+str(a)+'_HR'+str(hr)+'_SR'+str(sr)+".data"
            print(command_str)
            cmd(command_str+" > "+settings_filename)
