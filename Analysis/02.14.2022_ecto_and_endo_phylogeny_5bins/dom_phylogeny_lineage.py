#modify these variables according to experimental settings!
seeds = range(10, 41) #range of reps
last_update = 20001 #manually set this to the final update count
srs = [500,1000]
file_prefix = "../ecto_endo"

#ideally, don't need to modify anything below
#set up files
partners = ["Host", "Sym"]
dom_file_name = file_prefix+"_dom_stateseq.data"
dom_file = open(dom_file_name, "w")
dom_file.write("partner rep sr id info origin_time destruction_time time_in_state parent_id num_orgs\n")

#for every snapshot file, open it, extract the dom lineage and how long it spent in each state
for partner in partners:
    for r in seeds:
        for sr in srs:
        #start tab if adding loop over var here

            file = partner+"Snapshot_Phylogeny_Seed"+str(r)+"_SR"+str(sr)+"_SEED" + str(r) + ".data"
            #           0         1            2            3                  4          5                6              7             8     9
            #         ['id','ancestor_list','origin_time','destruction_time','num_orgs','tot_orgs','num_offspring','total_offspring','depth','info']
            try:
                id_dictionary = {}
                dom_id = -1
                dom_count = 0
                count = 0

                #GRAB FINAL BEST TAXON
                for line in open(file):
                    if count == 0: count = count + 1 #skip the first line
                    else:
                        line = line.strip()
                        line = line.split(',')
                        if int(line[4]) > dom_count:
                            dom_id = line[0]
                            dom_count = int(line[4])
                        parent = line[1].replace('[', '')
                        parent = parent.replace(']', '')

                        des_time = line[3]
                        if(des_time == 'inf'): des_time = last_update
                        else: des_time = int(des_time)
                                                 #  0                1      2       3            4
                                                # num orgs at end, info, parent, orig time, destruction_time
                        id_dictionary[line[0]] = [line[4],        line[9], parent, int(line[2]), des_time]

                #RECONSTRUCT BEST TAXON LINEAGE
                #time in state is the length that the dominant lineage spent in each state
                #so time_in_state <= destruction_time - origin_time (it could persist independently of lin)
                parent_id = id_dictionary[dom_id][2]
                cur_id = dom_id
                origin_time = id_dictionary[cur_id][3]
                new_state_time = id_dictionary[cur_id][4]
                #from when it was constructed to when its child was constructed?
                time_in_state = int(new_state_time) - int(origin_time)

                while cur_id != 'NONE':                                 #partner rep sr id info origin_time destruction_time time_in_state parent_id num_orgs
                    outstring = "{} {} {} {} {} {} {} {} {} {}\n".format(partner, r, sr, cur_id, id_dictionary[cur_id][1], id_dictionary[cur_id][3], id_dictionary[cur_id][4], time_in_state, parent_id, id_dictionary[cur_id][0])
                    dom_file.write(outstring)
                    cur_id = parent_id
                    if cur_id != 'NONE':
                        parent_id = id_dictionary[cur_id][2]
                        new_state_time = origin_time
                        origin_time = id_dictionary[cur_id][3]
                        if origin_time == -1: origin_time = 0
                        time_in_state = new_state_time - origin_time
                    else: break
            except IOError: print("couldn't open", file)
        #end tab if adding loop over var here
dom_file.close()
