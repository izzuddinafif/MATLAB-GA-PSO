# Example Usage of Hybrid-GA-PSO-MATLAB

This example demonstrates how to use the Hybrid-GA-PSO-MATLAB code for optimizing a given problem.

## Step 1: Set up problem parameters

Set the problem parameters according to your specific problem:

```matlab
max_iterasi = 1000;
popsize = 100;
gen = 3;
pc = 0.8;
pm = 0.01;
ub_a = 0.9;
lb_a = 0.7;
ub_q = 12;
lb_q = 1;
ub_l = 2.5;
lb_l = 1.0;
w = 0.5;
c1 = 1;
c2 = 1;
b = 21; % constant
```

## Step 2: Run the main script

Execute the main script with the specified parameters:

```matlab
[best_fitness, best_gen] = hybrid_ga_pso(max_iterasi, popsize, gen, pc, pm, lb_a, ub_a, lb_q, ub_q, lb_l, ub_l, w, c1, c2, b);
```

## Step 3: Interpret the results

After running the code, you will obtain the `best_fitness` and `best_gen` as outputs. These represent the best fitness value achieved and the corresponding best gen values (parameters) found by the Hybrid-GA-PSO-MATLAB algorithm.

Print the results:

```matlab
disp(['Best fitness: ', num2str(best_fitness)]);
disp(['Best gen values: ', num2str(best_gen)]);
```

This example demonstrates how to use the Hybrid-GA-PSO-MATLAB code to optimize a given problem by setting appropriate parameters and running the main script. The output will display the best fitness value and corresponding best gen values (parameters) found by the algorithm.
