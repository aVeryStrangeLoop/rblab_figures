from get_fitness import *

def remove_msg(genome):
    msg_inst = ["B","C","D"]
    new_genome = list(genome)
    for i in range(len(new_genome)):
        if new_genome[i] in msg_inst:
            new_genome[i] = "A"
    return "".join(new_genome)
            

def get_mu_msg(genome):
    no_msg_genome = remove_msg(genome)
    fitness = get_fitness(genome)
    fitness_no_msg = get_fitness(no_msg_genome)
    if fitness>0.0:
        mum = (fitness-fitness_no_msg)/fitness
        return mum
    else:
        return 0.0
