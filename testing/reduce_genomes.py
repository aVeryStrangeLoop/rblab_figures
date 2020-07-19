import sys
import os

filename = sys.argv[1]

outfilename = filename.split(".")[0]+"_reduced.csv"
ofile = open(outfilename,"w+")
ofile.write("reduced_genome,scf\n")

def GetEmpFitness(genome):
    os.chdir("test-env-scf/")
    ## Get lines from event file
    event_lines = []
    with open("events_bkup.cfg") as efile:
        for line in efile:
            event_lines.append(line)

    ## Write genome to event file
    for i in range(len(event_lines)):
        words = event_lines[i].split()
        if len(words)>2 and words[2] == "InjectSequence":
            event_lines[i] = "u begin InjectSequence "+genome+" 0 200\n"

    with open("events.cfg","w+") as efile:
        for line in event_lines:
            efile.write(line)

    ## Run avida
    os.system("./avida >/dev/null 2>&1")
    os.chdir("..")

    filename = "./test-env-scf/data/count.dat"

    BIRTHS = []
    with open(filename) as ifile:
        for line in ifile:
            words = line.split()
            if line[0]!="#" and line[0]!="\n":
                if int(words[0])>100: # Update after which to start counting (to let it stabilize)
                    birth_this_upd = int(words[9])
                    BIRTHS.append(birth_this_upd)
    #print BIRTHS
    if len(BIRTHS)==0:
        return 0.
        
    B = float(sum(BIRTHS))/len(BIRTHS)
    # B is now average births per update

    return B

def ReduceAndTest(genome):
    vitals = ["E","v"]
    new_genome = list(genome)
    for i in range(6,len(new_genome)-10):
        if new_genome[i] not in vitals:
            new_genome[i] = "A"

    new_genome = "".join(new_genome)
    new_scf = GetEmpFitness(new_genome)
    return new_genome,new_scf

    
with open(filename) as ifile:
    for line in ifile:
        words = line.split(",")
        words = [w.strip("\"") for w in words]
        if words[0]!="res_ab":
            genome = words[6]
            new_genome,new_scf = ReduceAndTest(genome)
            ofile.write("%s,%f\n" % (new_genome,new_scf))


ofile.close()
