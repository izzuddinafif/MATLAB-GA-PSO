# User Guide
## Overview

This guide will help you understand how to use the GA-PSO hybrid optimization algorithm implemented in MATLAB. This algorithm combines Genetic Algorithm (GA) and Particle Swarm Optimization (PSO) to optimize a set of parameters.

## Getting Started

### Prerequisites

- MATLAB installed on your computer.
- Basic knowledge of MATLAB and optimization algorithms.

### Files Overview

- `main_script.m`: The main script that runs the GA-PSO optimization.

### Running the Algorithm

1. Open MATLAB.
2. Load the script `main_script.m`.
3. Modify the parameters at the top of the script as needed.
4. Run the script.

### Parameters Description

- `max_iterations`: Maximum number of iterations for the optimization.
- `population_size`: Number of individuals/particles in the population.
- `gen_count`: Number of genes/variables to optimize.
- `crossover_prob`: Probability of crossover in GA.
- `mutation_prob`: Probability of mutation in GA.
- `upper_bounds`: Array of upper bounds for each variable.
- `lower_bounds`: Array of lower bounds for each variable.
- `w`: Inertia weight for PSO.
- `c1`: Cognitive coefficient for PSO.
- `c2`: Social coefficient for PSO.

## Using Custom Fitness Functions

To optimize the genes using your own functions, follow these steps:

1. **Define Your Custom Functions**: Modify the `calculate_total` and `calculate_fitness` functions to reflect your specific optimization problem.
    
    Example:
```matlab
function total = calculate_total(variables, constant)
    % Your custom calculation here
    total = custom_calculation(variables, constant);
end

function fitness = calculate_fitness(total)
    % Your custom fitness calculation here
    fitness = custom_fitness_calculation(total);
end
```
1. **Update `main_script.m`**: Ensure that the `gen_count`, `upper_bounds`, and `lower_bounds` parameters match the number of variables in your custom functions.
    
2. **Run the Algorithm**: Execute the script with your custom-defined functions to optimize the parameters according to your problem.