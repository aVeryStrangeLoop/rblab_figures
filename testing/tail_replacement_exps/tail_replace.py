import os
import sys
from get_merit import *
from get_fitness import *
from get_mu_msg import *

REPLs = range(5)
UPDs = range(0,5001,1000)
sample_file = sys.argv[1]
tail_sequence = "zvvvvxgab"
ofilename = sample_file.split("/")[-1].split(".")[0] + "_tra.csv" #Tail replace analysis
ofile = open(ofilename,"w+")
ofile.write("init_genome,repl,update,evolved_genome,scf,merit,mum\n")

genomes = []
no_mod_scfs = []
no_mod_merits = []
no_mod_mums = []

with open(sample_file) as ifile:
    for line in ifile:
        words = line.split(",")
        words = [w.strip("\"") for w in words]
        if words[0]!="res_ab":
            genome = words[6]
            scf = float(words[8])
            del_msg_scf = float(words[13])
            mum = (scf-del_msg_scf) / scf
            merit = get_merit(genome)
            
            genomes.append(genome)
            no_mod_scfs.append(scf)
            no_mod_merits.append(merit)
            no_mod_mums.append(mum)


# Write non-modified data
for i in range(len(genomes)):
    ofile.write("%s,%d,%d,%s,%f,%f,%f\n" % (genomes[i],0,-1,genomes[i],no_mod_scfs[i],no_mod_merits[i],no_mod_mums[i]))

def replace_tail(genome,tail_sequence):
    tlen = len(tail_sequence)
    length = len(genome)
    new_genome = list(genome)
    for i in range(length-tlen,length):
        new_genome[i] = tail_sequence[i-length+tlen]

    return "".join(new_genome)
        
def do_evo_run(genome):
    os.chdir("evo-chamber/")
    event_lines = []
    with open("events_bkup.cfg") as efile:
        for line in efile:
            event_lines.append(line)

    ## Write genome to event file
    for i in range(len(event_lines)):
        words = event_lines[i].split()
        if len(words)>2 and words[2] == "InjectSequence":
            event_lines[i] = "u begin InjectSequence "+genome+"\n"

    with open("events.cfg","w+") as efile:
        for line in event_lines:
            efile.write(line)

    ## Run avida
    os.system("./avida >/dev/null 2>&1")
    os.chdir("..")

def get_evol_genomes(upd):
    evol_genomes = []
    try:
        with open("evo-chamber/data/detail-"+str(upd)+".spop") as ufile:
            for line in ufile:
                words = line.split()
                if line[0]!="#" and line[0]!="\n" and len(words)==21:
                    genome = words[16]
                    evol_genomes.append(genome)
    except:
        print("Could not find detail file at update %d, skipping..." % upd)
    return evol_genomes

counter = 1
for init_genome in genomes:
    mod_genome = replace_tail(init_genome,tail_sequence)
    for repl in REPLs:
        do_evo_run(mod_genome)
        for upd in UPDs:
            print("processing genome num %d, repl %d, upd %d" % (counter,repl,upd))
            evolved_genomes = get_evol_genomes(upd)
            for genome in evolved_genomes:
                ofile.write("%s,%d,%d,%s,%f,%f,%f\n" % (init_genome,repl,upd,genome,get_fitness(genome),get_merit(genome),get_mu_msg(genome)))
    counter += 1
ofile.close()

