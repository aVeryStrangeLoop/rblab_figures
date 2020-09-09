
Ns = [250,300,350,400,450]
REPL = 10

for n in Ns:
    for repl in range(REPL): 
        ## Edit the avida.cfg file and change value of WORLD_Y to n
        ## Run avida
        ## mv test-env-scf/data saved_data/pop-%n/data-%repl
