import os.path
import gzip

folder = "../../Data/12.16.21_control_no_infect/"

treatment_postfixes_HR = ["HR10", "HR50", "HR100", "HR500", "HR1000"]
sym_res_postfixes = ["SR10", "SR50", "SR100", "SR500", "SR1000"]
reps = range(10, 41)
#reps = range(1001, 1021)
header = "uid HR SR HRSR rep update symFreeCount symHostedCount symFreeDonate symHostedDonate \n"

outputFileName = "munged_sym_average.dat"

outFile = open(outputFileName, 'w')
outFile.write(header)

for t in treatment_postfixes_HR:
    for v in sym_res_postfixes:
        for r in reps:
            fname = folder +"FreeLivingSyms_Seed"+str(r)+"_"+t+"_"+v+"_SEED" + str(r) + ".data"
            uid = t + "_" + str(r)
            curFile = open(fname, 'r')
            for line in curFile:
                if (line[0] != "u"):
                    splitline = line.split(',')
                    #if int(splitline[0]) == final_update:
                    outstring1 = "{} {} {} {} {} {} {} {} {} {}\n".format(uid, t, v, t+v, r, splitline[0], splitline[2], splitline[3], splitline[5], splitline[6] )
                    outFile.write(outstring1)
            curFile.close()
outFile.close()