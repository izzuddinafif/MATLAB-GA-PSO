# Example Usage

## Problem Statement

Let's say we want to optimize three variables `x1`, `x2`, and `x3` using a custom formula to find the best values that meet a specific criterion.

## Custom Setup

1. Open `main_script.m`.
    
2. Set the following parameters:
```matlab
max_iterations = 1000;
population_size = 100;
gen_count = 3;
crossover_prob = 0.8;
mutation_prob = 0.01;
upper_bounds = [0.9, 12, 2.5];
lower_bounds = [0.7, 1, 1.0];
w = 0.5;
c1 = 1.0;
c2 = 1.0;
```
3. Define your custom fitness function:
```matlab
function total = calculate_total(variables, constant)
    % Custom logic for total calculation
    total = variables(1)^2 + 2*variables(2) + log(variables(3) + constant);
end

function fitness = calculate_fitness(total)
    % Custom logic for fitness calculation
    target = 50; % Example target value
    fitness = 1 / (1 + abs(total - target));
end
```
4. Run the script.
## Output Interpretation

After running the script, MATLAB will output:

- The best fitness value found.
- The corresponding optimized values for `x1`, `x2`, and `x3`.

This tells you the optimal set of parameters for your specific problem using your custom-defined functions.