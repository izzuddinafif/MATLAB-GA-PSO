# Developer Guide

This developer guide will provide an overview of the MATLAB-004 scripts' structure and how to modify the code for different optimization problems or algorithms.

## Script Structure

The main script `main.m` contains the core algorithm and calls functions for initialization, selection, crossover, mutation, evaluation, and updating the particle swarm. These functions are defined in the same script for simplicity.

### Functions

- `init_populasi()`: Initializes the population for the genetic algorithm.
- `init_pso()`: Initializes the particles for particle swarm optimization.
- `seleksi_roulette_wheel()`: Selects parents for crossover using the roulette wheel selection method.
- `crossover()`: Performs crossover between two parents to create offspring.
- `mutasi()`: Applies mutation to the offspring.
- `eval_fitness()`: Evaluates the fitness of particles.
- `update_pso()`: Updates the particle swarm based on the best position and global best position.

## Customizing the Problem

To customize the optimization problem, you need to modify the following functions:

1. `hitung_total(a, q, l, b)`: This function calculates the objective function using the given parameters (a, q, l, and b). Replace the existing calculation with your problem's objective function.
2. `hitung_fitness(total)`: This function calculates the fitness value based on the total value computed by `hitung_total()`. Modify this function to fit your problem's fitness criteria.
3. `init_populasi()`: This function initializes the population for the genetic algorithm. Modify the `populasi` variable to fit your problem's constraints.
4. etc.

## Adding New Algorithms

To add new optimization algorithms to the script, follow these steps:

1. Define a new function for the algorithm in the main script or create a separate script for the algorithm.
2. In the main script, call the new function where appropriate, e.g., during the initialization, evaluation, or updating phases.
3. Modify the `hitung_total()` and `hitung_fitness()` functions to accommodate the new algorithm if necessary.

## Tips for Extending the Code

- Keep functions modular and focused on specific tasks to make it easier to modify and debug the code.
- Add comments to explain the purpose and behavior of each function and variable.
- Test the new algorithm independently before integrating it with the existing code.
