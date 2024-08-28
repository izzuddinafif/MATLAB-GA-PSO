# Developer Guide

## Overview

This guide is intended for developers who want to understand, modify, or extend the GA-PSO hybrid optimization algorithm.

## Code Structure

- **`main_script.m`**: Contains the main loop for the GA-PSO algorithm and the initialization of parameters.

## Function Descriptions

### Initialization Functions

- `init_population`: Initializes the population for the genetic algorithm.
- `init_pso`: Initializes the particles for the PSO.

### Genetic Algorithm Functions

- `roulette_wheel_selection`: Selects parents based on their fitness.
- `crossover`: Performs crossover between two parents to produce offspring.
- `mutation`: Mutates the offspring with a given probability.

### Particle Swarm Optimization Functions

- `evaluate_fitness`: Evaluates the fitness of particles.
- `update_pso`: Updates the position of particles.

### Fitness Calculation

- `calculate_total`: Calculates the total value based on the input variables.
- `calculate_fitness`: Calculates the fitness based on the total value.

### Using Custom Functions

To use your own functions for optimization:

1. **Define Custom Calculation Functions**:
    
    - Update the `calculate_total` function to use your custom formula or logic.
    - Modify the `calculate_fitness` function to calculate the fitness based on your specific criteria.
2. **Example Customization**:
```matlab
function total = calculate_total(variables, constant)
    % Replace this with your custom logic
    total = sum(variables) + constant;
end

function fitness = calculate_fitness(total)
    % Replace this with your custom fitness logic
    fitness = 1 / (1 + abs(total - target));
end
```
3.  **Adapt the `main_script.m`**:
    
    - Ensure `gen_count`, `upper_bounds`, and `lower_bounds` are set according to the number of variables your custom functions require.
4. **Testing**: Run the script and verify the results based on your specific problem.