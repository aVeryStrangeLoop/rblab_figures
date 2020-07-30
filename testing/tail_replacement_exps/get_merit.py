import os
import sys

def get_merit(genome):
    with open("test-chamber/analyze.cfg","w+") as afile:
        afile.write("LOAD_SEQUENCE "+genome+"\n")
        afile.write("RECALCULATE\n")
        afile.write("DETAIL tasks.csv sequence merit task.0 task.1 task.2 task.3 task.4 task.5 task.6 task.7 task.8")
    
    os.chdir("test-chamber/")
    os.system("./avida -a >/dev/null 2>&1")
    os.chdir("..")

    merit = -1.0
    with open("test-chamber/data/tasks.csv") as tfile:
        for line in tfile:
            if line[0]!="#" and line[0]!="\n":
                words = line.split()
                merit = float(words[1])
    return merit
