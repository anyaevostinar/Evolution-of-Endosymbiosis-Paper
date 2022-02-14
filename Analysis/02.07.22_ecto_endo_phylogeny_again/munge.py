import os.path
import gzip
#from itertools import izip

metafolder = 'ecto/'
folder = metafolder + 'rpts/'

treatment_postfixes = [1]#[0, 0.001, 0.005, 0.01, 0.05, 0.1, 0.5, 1]
#[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 30, 40, 60, 80, 100]
#vts = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]
#sym_ints = [-1, -0.9, -0.8, -0.7, -0.6, -0.5, -0.4, -0.3, -0.2, -0.1, 0]
#treatment_postfixes = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]
slrs = [10]
partners = ["Host", "Sym"]
reps = range(10,41)
#reps = range(1001, 1021)
final_update = 3
header = "uid smoi rep sym_res_dis update host_count sym_count free_sym_count hosted_sym_count sym_infectchance free_sym_infectchance hosted_sym_infectchance sym_val free_sym_val hosted_sym_val host_val cfu\n"

ecto_on = [0]#,5,10,15,20,25,30,35,40] 
ecto_im = [0]
#vts = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]
srs = [500, 1000]
outputFileName = "../endoEcto_phylo_munged_data.dat"

outFile = open(outputFileName, 'w')
outFile.write(header)

#for t in treatment_postfixes:
for var in srs:
    for r in reps:
        host_fname = "HostValsSeed"+str(r)+"_SR" + str(var)+"_SEED"+str(r)+".data"
        fls_fname = "FreeLivingSyms_Seed"+ str(r) + "_SR"+str(var)+"_SEED" + str(r)+".data"
        t = 1
        uid = str(t) + "_" + str(r)
        s = 10
        try:
            host_file = open(host_fname, 'r')
            fls_file = open(fls_fname, 'r')
            with open(host_fname) as host_file, open(fls_fname) as fls_file:
                for host_line, fls_line in zip(host_file, fls_file):
                    if (host_line[0] != "u"):
                        host_line.strip()
                        fls_line.strip()
                        splitline = host_line.split(',')
                        flsline = fls_line.split(',')
                        outstring1 = "{} {} {} {} {} {} {} {} {} {} {} {} {} {} {} {} {}\n".format(uid, t, r, var, splitline[0], splitline[2], flsline[1], flsline[2], flsline[3], flsline[7], flsline[8], flsline[9].strip(), flsline[4], flsline[5],flsline[6], splitline[1], splitline[3])
                        outFile.write(outstring1)
        except IOError:
	    print "error"            
outFile.close()
