import numpy as np

# Parameter GA-PSO
max_iterasi = 10
popsize = 20
gen = 2
pc = 0.9
pm = 0.1
ub_nCC = 10
lb_nCC = 1
ub_UCC = 1.0
lb_UCC = 0.8 
w = 0.9
c1 = 2
c2 = 2


def hitung_PCC(nCC, UCC, tCC):
    demand = 40
    PCC = demand / ((nCC * UCC) / tCC)
    return PCC


def hitung_fitness(PCC):
    if 26 <= PCC <= 36:
        fitness = 1 / PCC
    else:
        fitness = 0
    return fitness


def init_populasi(popsize, gen, lb_nCC, ub_nCC, lb_UCC, ub_UCC):
    populasi = np.zeros((popsize, gen + 1))

    for i in range(popsize):
        nCC = np.random.randint(lb_nCC, ub_nCC + 1)
        UCC = lb_UCC + np.random.rand() * (ub_UCC - lb_UCC)
        PCC = hitung_PCC(nCC, UCC, 21)
        fitness = hitung_fitness(PCC)

        populasi[i, :] = [nCC, UCC, fitness]

    return populasi


def seleksi_roulette_wheel(populasi, popsize):
    total_fitness = np.sum(populasi[:, -1])
    r = np.random.rand() * total_fitness
    partial_sum = 0
    idx = 0

    for i in range(popsize):
        partial_sum += populasi[i, -1]
        if partial_sum >= r:
            idx = i
            break

    return populasi[idx, 0:-1]


def crossover(orang_tua, pc, lb_nCC, ub_nCC, lb_UCC, ub_UCC):
    r = np.random.rand()
    if r <= pc:
        p = np.random.randint(1, len(orang_tua))
        offspring = np.concatenate((orang_tua[0:p], orang_tua[-p:]), axis=0)
    else:
        offspring = orang_tua
    offspring[0] = max(min(offspring[0], ub_nCC), lb_nCC)
    offspring[1] = max(min(offspring[1], ub_UCC), lb_UCC)
    return offspring


def mutasi(offspring, pm, lb_nCC, ub_nCC, lb_UCC, ub_UCC):
    for i in range(len(offspring)):
        r = np.random.rand()
        if r <= pm:
            if i == 0:
                offspring[i] = np.random.randint(lb_nCC, ub_nCC + 1)
            else:
                offspring[i] = lb_UCC + np.random.rand() * (ub_UCC - lb_UCC)

    return offspring


def eval_fitness(populasi):
    popsize = populasi.shape[0]
    for i in range(popsize):
        nCC = populasi[i, 0]
        UCC = populasi[i, 1]
        PCC = hitung_PCC(nCC, UCC, 21)
        fitness = hitung_fitness(PCC)

        populasi[i, -1] = fitness

    return populasi


def init_pso(populasi, gen):
    partikel = np.zeros((populasi.shape[0], 2 * gen + 1))
    partikel[:, :gen] = populasi[:, :gen]
    partikel[:, gen:2 * gen] = np.random.rand(populasi.shape[0], gen)
    partikel[:, -1] = populasi[:, -1]
    return partikel

def update_velocity(partikel, w, c1, c2, gbest):
    kecepatan = np.zeros((partikel.shape[0], partikel.shape[1] // 2))
    for i in range(partikel.shape[0]):
        kecepatan[i, :] = w * partikel[i, partikel.shape[1] // 2 : -1] + c1 * np.random.rand() * (gbest[:gen] - partikel[i, :gen]) + c2 * np.random.rand() * (partikel[i, :gen] - partikel[i, gen:-1])
    return kecepatan

def update_position(partikel, kecepatan, lb_nCC, ub_nCC, lb_UCC, ub_UCC):
    for i in range(partikel.shape[0]):
        partikel[i, :gen] += kecepatan[i, :]
        partikel[i, 0] = max(min(partikel[i, 0], ub_nCC), lb_nCC)
        partikel[i, 1] = max(min(partikel[i, 1], ub_UCC), lb_UCC)
    return partikel

def main():
    populasi = init_populasi(popsize, gen, lb_nCC, ub_nCC, lb_UCC, ub_UCC)
    partikel = init_pso(populasi, gen)
    gbest = partikel[np.argmin(partikel[:, -1]), :]
    
    for iterasi in range(max_iterasi):
        # GA
        new_populasi = np.zeros((popsize, gen + 1))
        for i in range(popsize):
            orang_tua = seleksi_roulette_wheel(populasi, popsize)
            offspring = crossover(orang_tua, pc, lb_nCC, ub_nCC, lb_UCC, ub_UCC)
            offspring = mutasi(offspring, pm, lb_nCC, ub_nCC, lb_UCC, ub_UCC)
            new_populasi[i, :-1] = offspring

        new_populasi = eval_fitness(new_populasi)
        populasi = new_populasi

        # PSO
        kecepatan = update_velocity(partikel, w, c1, c2, gbest)
        partikel = update_position(partikel, kecepatan, lb_nCC, ub_nCC, lb_UCC, ub_UCC)
        partikel = eval_fitness(partikel)
        gbest = partikel[np.argmin(partikel[:, -1]), :]

        print("Iterasi", iterasi + 1, ": nCC =", gbest[0], "UCC =", gbest[1], "PCC =", gbest[2], "Fitness =", gbest[3])

    print("\nHasil terbaik: nCC =", gbest[0], "UCC =", gbest[1], "PCC =", gbest[2], "Fitness =", gbest[3])
    
if __name__ == "__main__":
    main()