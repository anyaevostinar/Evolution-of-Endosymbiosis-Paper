import os.path
import gzip
#from itertools import izip

partners = ["Host", "Sym"]
reps = range(10,41)

header = "uid smoi rep vt update host_count sym_count free_sym_count hosted_sym_count sym_infectchance free_sym_infectchance hosted_sym_infectchance sym_val free_sym_val hosted_sym_val host_val cfu\n"

vts = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]
outputFileName = "vtsweep_munged_data.dat"

outFile = open(outputFileName, 'w')
outFile.write(header)

for var in vts:
    for r in reps:
        host_fname = "HostValsSeed"+str(r)+"_VT" + str(var)+"_SEED"+str(r)+".data"
        fls_fname = "FreeLivingSyms_Seed"+ str(r) + "_VT"+str(var)+"_SEED" + str(r)+".data"
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
