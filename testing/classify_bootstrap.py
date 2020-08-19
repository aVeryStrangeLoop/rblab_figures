import sys
import random

BS_SAMPLES = 1000
BS_SAMPLE_SIZE = 30

POPs = [100,200,500]
RESs = ["8k","10k","100k","1000k"]
MUTs = ["l","h"]

bw_h = 0.5703911
bw_l = 0.2012893

l_max0 = 9.652167
l_max1 = 13.45673
l_max2 = 15.35901
l_max3 = 18.04171
l_max4 = 21.40728

h_max0 = 3.79
h_max1 = 10.34684
h_max2 = 18.00895
h_max3 = 21.65506

ofile = open("peak_fractions_bs.csv","w+")
ofile.write("res,mut,pop,bs_sample_n,p0,p1,p2,p3,p4\n")
# Lowmut
for bs_sample_n in range(BS_SAMPLES):
    mut = "l"
    print(mut,bs_sample_n)
    bs_resample_repls = random.choices(range(50),k=BS_SAMPLE_SIZE) # Choose resamples (repl) between 0 and 50
    for pop in POPs:
        for res in RESs:
            tot = 0.0
            p0 = 0.0
            p1 = 0.0
            p2 = 0.0
            p3 = 0.0
            p4 = 0.0
            with open("data_w_mech.csv") as ifile:
                for line in ifile:
                    words = line.split(",")
                    if words[0]==res and words[1]==mut and int(words[2])==pop and (int(words[3]) in bs_resample_repls) :
                        scf = float(words[8])
                        if scf!=0.0:
                            tot += 1.0
                        if scf > l_max0-bw_l and scf < l_max0+bw_l:
                            p0 +=1.0
                        elif scf > l_max1-bw_l and scf < l_max1+bw_l:
                            p1 +=1.0
                        elif scf > l_max2-bw_l and scf < l_max2+bw_l:
                            p2 +=1.0
                        elif scf > l_max3-bw_l and scf < l_max3+bw_l:
                            p3 +=1.0
                        elif scf > l_max4-bw_l and scf < l_max4+bw_l:
                            p4 +=1.0
            ofile.write("%s,%s,%d,%d,%f,%f,%f,%f,%f\n" % (res,mut,pop,bs_sample_n,p0/tot,p1/tot,p2/tot,p3/tot,p4/tot))

for bs_sample_n in range(BS_SAMPLES):
    print(mut,bs_sample_n)
    mut = "h"
    bs_resample_repls = random.choices(range(50),k=BS_SAMPLE_SIZE) # Choose resamples (repl) between 0 and 50
    for pop in POPs:
        for res in RESs:
            tot = 0.0
            p0 = 0.0
            p1 = 0.0
            p2 = 0.0
            p3 = 0.0
            with open("data_w_mech.csv") as ifile:
                for line in ifile:
                    words = line.split(",")
                    if words[0]==res and words[1]==mut and int(words[2])==pop and (int(words[3]) in bs_resample_repls):
                        scf = float(words[8])
                        if scf!=0.0:
                            tot += 1.0
                        if scf > h_max0-bw_h and scf < h_max0+bw_h:
                            p0 +=1.0
                        elif scf > h_max1-bw_h and scf < h_max1+bw_h:
                            p1 +=1.0
                        elif scf > h_max2-bw_h and scf < h_max2+bw_h:
                            p2 +=1.0
                        elif scf > h_max3-bw_h and scf < h_max3+bw_h:
                            p3 +=1.0
            ofile.write("%s,%s,%d,%d,%f,%f,%f,%f,\n" % (res,mut,pop,bs_sample_n,p0/tot,p1/tot,p2/tot,p3/tot))


ofile.close()
            


