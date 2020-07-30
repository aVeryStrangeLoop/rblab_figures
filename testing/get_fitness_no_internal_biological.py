import sys
import os

filename = sys.argv[1]
ofilename = (filename.split("/")[-1]).split(".")[0]+"_no_int_bio.csv"
outfile = open(ofilename,"w+")
outfile.write("genome,scf,scf_no_int_bio\n")

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

def RemoveIntBio(genome):
    bio_inst = ["v","x","z"]
    new_genome = list(genome)
    for i in range(6,len(new_genome)-11):
        if new_genome[i] in bio_inst:
            new_genome[i] = "A"
    return "".join(new_genome)

with open(filename) as ifile:
    for line in ifile:
        words = line.split(",")
        genome = words[6].strip("\"")
        scf = GetEmpFitness(genome)
        scf_no_int_bio = GetEmpFitness(RemoveIntBio(genome))
        outfile.write("%s,%f,%f\n" % (genome,scf,scf_no_int_bio))

outfile.close()
