% Main Script for Hybrid Genetic Algorithm - Particle Swarm Optimization (GA-PSO)
% This script combines Genetic Algorithm (GA) and Particle Swarm Optimization (PSO)
% to optimize a set of parameters based on defined fitness criteria.

% Clear workspace and figures
close all; clc; clear;

%% Parameter Initialization

% GA Parameters
max_iterations = 1000;            % Maximum number of iterations
population_size = 100;            % Number of individuals in the population
num_genes = 3;                     % Number of genes (parameters) to optimize
crossover_prob = 0.8;              % Probability of crossover
mutation_prob = 0.01;              % Probability of mutation

% Define lower and upper bounds for each gene
% Each element corresponds to a gene. For example:
% Gene 1: Lower bound = 0.7, Upper bound = 0.9
% Gene 2: Lower bound = 1,   Upper bound = 12
% Gene 3: Lower bound = 1.0, Upper bound = 2.5
lower_bounds = [0.7, 1, 1.0];       % Lower bounds for genes
upper_bounds = [0.9, 12, 2.5];      % Upper bounds for genes

% PSO Parameters
inertia_weight = 0.5;              % Inertia weight (w)
cognitive_coeff = 1;               % Cognitive coefficient (c1)
social_coeff = 1;                  % Social coefficient (c2)

% Additional Constants
constant_b = 21;                    % Constant used in fitness calculation

%% Initialization

% Initialize the population for the Genetic Algorithm
population = init_population(population_size, num_genes, lower_bounds, upper_bounds, constant_b);

% Initialize the particles for Particle Swarm Optimization
particles = init_pso(population, num_genes);

% Identify the initial Global Best (gbest) from particles
[initial_best_fitness, idx] = min(particles.personal_best_fitness);
gbest_position = particles.personal_best_position(idx, :);
gbest_fitness = initial_best_fitness;

% Initialize array to store the best fitness value at each iteration
best_fitness = zeros(1, max_iterations);

%% Main Optimization Loop

for iter = 1:max_iterations
    %% Genetic Algorithm Operations
    
    % Perform selection, crossover, and mutation to create a new population
    new_population = zeros(population_size, num_genes + 1); % Last column for fitness
    for i = 1:population_size
        % Selection: Roulette Wheel Selection
        parent = select_roulette_wheel(population, population_size);
        
        % Crossover
        offspring = crossover(population, parent, crossover_prob, lower_bounds, upper_bounds, population_size, num_genes, constant_b);
        
        % Mutation
        offspring = mutate(offspring, mutation_prob, lower_bounds, upper_bounds, num_genes, constant_b);
        
        % Assign offspring to the new population
        new_population(i, :) = offspring;
    end
    population = new_population; % Update population
    
    %% Particle Swarm Optimization Operations
    
    % Update Personal Bests and Global Best based on the new population
    for i = 1:population_size
        genes = population(i, 1:num_genes);
        fitness = population(i, end);
        
        % Update personal best if current fitness is better
        if fitness < particles.personal_best_fitness(i)
            particles.personal_best_position(i, :) = genes;
            particles.personal_best_fitness(i) = fitness;
            
            % Update global best if current fitness is better than the global best
            if fitness < gbest_fitness
                gbest_fitness = fitness;
                gbest_position = genes;
            end
        end
    end
    
    % Update particles' velocities and positions
    particles = update_pso(particles, inertia_weight, cognitive_coeff, social_coeff, gbest_position, lower_bounds, upper_bounds, num_genes);
    
    % Evaluate fitness for particles after position update
    particles = evaluate_pso_fitness(particles, constant_b, num_genes);
    
    % Update personal bests again after PSO position update
    for i = 1:population_size
        fitness = particles.current_fitness(i);
        if fitness < particles.personal_best_fitness(i)
            particles.personal_best_position(i, :) = particles.position(i, :);
            particles.personal_best_fitness(i) = fitness;
            
            % Update global best if necessary
            if fitness < gbest_fitness
                gbest_fitness = fitness;
                gbest_position = particles.position(i, :);
            end
        end
    end
    
    % Store the best fitness value of this iteration
    best_fitness(iter) = gbest_fitness;
    
    % (Optional) Display progress
    if mod(iter, 100) == 0 || iter == 1
        fprintf('Iteration %d/%d, Best Fitness: %.4f\n', iter, max_iterations, gbest_fitness);
    end
end

%% Results

% Display the best fitness value found
disp(['Best Fitness Value: ' num2str(gbest_fitness)]);

% Display the best gene values found
disp(['Best Gene Values: ' num2str(gbest_position)]);

% Plot the best fitness over iterations
figure;
plot(1:max_iterations, best_fitness, 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Fitness');
title('Best Fitness over Iterations');
grid on;

%% Function Definitions

% Function to calculate the total value based on genes and a constant
function total = calculate_total(genes, b)
    % PRODUCT OF ALL GENES MULTIPLIED BY CONSTANT B
    total = prod(genes) * b;
end

% Function to calculate fitness based on the total value
function fitness = calculate_fitness(total)
    % FITNESS FUNCTION
    target_min = 26;
    target_max = 36;

    if target_min <= total && total <= target_max
        fitness = 1 / total;
    else
        fitness = 1 / (1 + abs(min(target_min - total, total - target_max)));
    end
end

% Function to initialize the population for GA
function population = init_population(pop_size, num_genes, lb, ub, b)
    % INITIALIZE POPULATION WITH RANDOM GENES WITHIN BOUNDS
    % Each row represents an individual: [gene1, gene2, ..., geneN, fitness]
    population = zeros(pop_size, num_genes + 1);
    for i = 1:pop_size
        genes = lb + (ub - lb) .* rand(1, num_genes); % Random genes within bounds
        total = calculate_total(genes, b);           % Calculate total
        fitness = calculate_fitness(total);          % Calculate fitness
        population(i, :) = [genes, fitness];         % Assign to population
    end
end

% Function to initialize PSO particles
function particles = init_pso(population, num_genes)
    % INITIALIZE PARTICLES FOR PSO
    % Particles Structure:
    % particles.position: Current positions of particles
    % particles.velocity: Current velocities of particles
    % particles.personal_best_position: Personal best positions
    % particles.personal_best_fitness: Personal best fitness values
    particles.position = population(:, 1:num_genes);
    particles.velocity = zeros(size(population, 1), num_genes); % Initialize velocities to zero
    particles.personal_best_position = population(:, 1:num_genes);
    particles.personal_best_fitness = population(:, end);
end

% Function for Roulette Wheel Selection
function parent = select_roulette_wheel(population, pop_size)
    % SELECT_PARENT_ROULETTE_WHEEL SELECTS A PARENT BASED ON FITNESS PROPORTIONATE SELECTION
    fitness = population(:, end);
    total_fitness = sum(fitness);
    
    % Handle case where total fitness is zero
    if total_fitness == 0
        probabilities = ones(pop_size,1) / pop_size;
    else
        probabilities = fitness / total_fitness;
    end
    
    % Generate a random number and select parent
    r = rand();
    cumulative = 0;
    for i = 1:pop_size
        cumulative = cumulative + probabilities(i);
        if r <= cumulative
            parent = population(i, :);
            return;
        end
    end
    parent = population(pop_size, :); % In case of numerical issues
end

% Function to perform Crossover
function offspring = crossover(population, parent, crossover_prob, lb, ub, pop_size, num_genes, b)
    % CROSSOVER GENERATES OFFSPRING BY COMBINING GENES FROM TWO PARENTS
    if rand() < crossover_prob
        parent2 = select_roulette_wheel(population, pop_size); % Select second parent
        offspring = zeros(1, num_genes + 1);
        for j = 1:num_genes
            if rand() < 0.5
                offspring(j) = parent(j);
            else
                offspring(j) = parent2(j);
            end
        end
        % Ensure genes are within bounds
        offspring(1:num_genes) = max(min(offspring(1:num_genes), ub), lb);
        % Calculate total and fitness
        total = calculate_total(offspring(1:num_genes), b);
        fitness = calculate_fitness(total);
        offspring(end) = fitness;
    else
        offspring = parent; % No crossover; offspring is identical to parent
    end
end

% Function to perform Mutation
function offspring = mutate(offspring, mutation_prob, lb, ub, num_genes, b)
    % MUTATION INTRODUCES RANDOM CHANGES TO AN OFFSPRING'S GENES
    if rand() < mutation_prob
        gene_index = randi(num_genes); % Select a random gene to mutate
        offspring(gene_index) = lb(gene_index) + (ub(gene_index) - lb(gene_index)) * rand(); % Assign new random value within bounds
        % Ensure gene is within bounds
        offspring(gene_index) = max(min(offspring(gene_index), ub(gene_index)), lb(gene_index));
        % Recalculate total and fitness after mutation
        total = calculate_total(offspring(1:num_genes), b);
        fitness = calculate_fitness(total);
        offspring(end) = fitness;
    end
end

% Function to Update PSO
function particles = update_pso(particles, w, c1, c2, gbest, lb, ub, num_genes)
    % UPDATE_PSO UPDATES THE VELOCITIES AND POSITIONS OF PARTICLES BASED ON PSO FORMULAS
    r1 = rand(size(particles.position)); % Random coefficients for cognitive component
    r2 = rand(size(particles.position)); % Random coefficients for social component
    
    % Update velocities
    particles.velocity = w * particles.velocity ...
                         + c1 * r1 .* (particles.personal_best_position - particles.position) ...
                         + c2 * r2 .* (gbest - particles.position);
    
    % Update positions
    particles.position = particles.position + particles.velocity;
    
    % Ensure particles stay within bounds and reset velocity if they exceed
    for i = 1:size(particles.position, 1)
        for j = 1:num_genes
            if particles.position(i, j) < lb(j)
                particles.position(i, j) = lb(j);
                particles.velocity(i, j) = 0;
            elseif particles.position(i, j) > ub(j)
                particles.position(i, j) = ub(j);
                particles.velocity(i, j) = 0;
            end
        end
    end
end

% Function to Evaluate Fitness for PSO Particles
function particles = evaluate_pso_fitness(particles, b, num_genes)
    % EVALUATE_PSO_FITNESS CALCULATES THE FITNESS OF EACH PARTICLE AFTER POSITION UPDATE
    particles.current_fitness = zeros(size(particles.position, 1), 1);
    for i = 1:size(particles.position, 1)
        genes = particles.position(i, :);
        total = calculate_total(genes, b);
        fitness = calculate_fitness(total);
        particles.current_fitness(i) = fitness;
    end
end
