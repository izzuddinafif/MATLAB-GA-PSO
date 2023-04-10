# User Guide

This user guide will walk you through using the MATLAB-004 scripts for the Hybrid Genetic Algorithm and Particle Swarm Optimization.

## Running the Script

1. Open the main script `main.m` in MATLAB.
2. Modify the parameters as needed for your optimization problem. The parameters include population size, number of generations, crossover probability, mutation probability, and variable bounds.
3. Run the script by clicking the "Run" button or pressing `F5`.

## Customizing the Problem

To customize the optimization problem, you need to modify the following functions:

1. `hitung_total(a, q, l, b)`: This function calculates the objective function using the given parameters (a, q, l, and b). Replace the existing calculation with your problem's objective function.
2. `hitung_fitness(total)`: This function calculates the fitness value based on the total value computed by `hitung_total()`. Modify this function to fit your problem's fitness criteria.

## Interpreting the Results

After running the script, the best fitness value and corresponding variable values will be displayed in the MATLAB command window. You can analyze the results to determine the optimal solution for your problem based on the best fitness value and corresponding variable values.
