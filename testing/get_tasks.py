import os
import sys

filename = sys.argv[1]
ofilename = (filename.split("/")[-1]).split(".")[0]+"_tasks.csv"
outfile = open(ofilename,"w+")
outfile.write("genome,merit,task.0,task.1,task.2,task.3,task.4,task.5,task.6,task.7,task.8\n")

def GetTasks(genome):
    with open("test-env-scf/analyze.cfg","w+") as afile:
        afile.write("LOAD_SEQUENCE "+genome+"\n")
        afile.write("RECALCULATE\n")
        afile.write("DETAIL tasks.csv sequence merit task.0 task.1 task.2 task.3 task.4 task.5 task.6 task.7 task.8")
    
    os.chdir("test-env-scf/")
    os.system("./avida -a")
    os.chdir("..")

    with open("test-env-scf/data/tasks.csv") as tfile:
        for line in tfile:
            if line[0]!="#" and line[0]!="\n":
                words = line.split()
                return ",".join(words[2:]),float(words[1])


with open(filename) as ifile:
    for line in ifile:
        words = line.split(",")
        genome = words[6]
        tasks,merit = GetTasks(genome)
        outfile.write("%s,%f,%s\n" % (genome,merit,tasks))

outfile.close()
