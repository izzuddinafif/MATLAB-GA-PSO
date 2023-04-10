% Parameter GA-PSO
close all; clc; clear;
max_iterasi = 1000;
popsize = 100;
gen = 2;
pc = 0.8;
pm = 0.01;
ub_nCC = 1000;
lb_nCC = 1;
ub_UCC = 1.0;
lb_UCC = 0.8;
w = 0.5;
c1 = 1;
c2 = 1;

% Fungsi utama
populasi = init_populasi(popsize, gen, lb_nCC, ub_nCC, lb_UCC, ub_UCC);
partikel = init_pso(populasi, gen);
[~, idx] = min(partikel(:, end));
gbest = partikel(idx, :);

% Inisialisasi array untuk menyimpan nilai fitness terbaik di setiap iterasi
best_fitness = zeros(1, max_iterasi);

for iterasi = 1:max_iterasi
    % GA
    new_populasi = zeros(popsize, gen + 1);
    for i = 1:popsize
        orang_tua = seleksi_roulette_wheel(populasi, popsize);
        offspring = crossover(orang_tua, pc, lb_nCC, ub_nCC, lb_UCC, ub_UCC);
        offspring = mutasi(offspring, pm, lb_nCC, ub_nCC, lb_UCC, ub_UCC);
        new_populasi(i, 1:end-1) = offspring;
    end

    new_populasi = eval_fitness(new_populasi);
    populasi = new_populasi;

    % PSO
    kecepatan = update_velocity(partikel, w, c1, c2, gbest);
    partikel = update_position(partikel, kecepatan, lb_nCC, ub_nCC, lb_UCC, ub_UCC);
    partikel = eval_fitness(partikel);
    [~, idx] = min(partikel(:, end));
    gbest = partikel(idx, :);
    
    % Simpan nilai fitness terbaik
    best_fitness(iterasi) = gbest(end);
    disp(['Iterasi ' num2str(iterasi) ': nCC = ' num2str(gbest(1)) ', UCC = ' num2str(gbest(2)) ', PCC = ' num2str(gbest(3)) ', Fitness = ' num2str(gbest(4))]);
end

disp(['Hasil terbaik: nCC = ' num2str(gbest(1)) ', UCC = ' num2str(gbest(2)) ', PCC = ' num2str(gbest(3)) ', Fitness = ' num2str(gbest(4))]);

% Visualisasi grafik
figure;
plot(1:max_iterasi, best_fitness);
xlabel('Iterasi');
ylabel('Fitness Terbaik');
title('Grafik Fitness Terbaik GA-PSO');


% Fungsi-fungsi yang diperlukan:

function PCC = hitung_PCC(nCC, UCC, tCC)
    demand = 50;
    PCC = demand / ((nCC * UCC) / tCC);
end

function fitness = hitung_fitness(PCC)
    if 26 <= PCC && PCC <= 36
        fitness = 1 / PCC;
    else
        fitness = 0;
    end
end

function populasi = init_populasi(popsize, gen, lb_nCC, ub_nCC, lb_UCC, ub_UCC)
    populasi = zeros(popsize, gen + 1);
    for i = 1:popsize
        nCC = lb_nCC + (ub_nCC - lb_nCC) * randi([0, 9]) / 9;
        UCC = lb_UCC + (ub_UCC - lb_UCC) * rand();
        PCC = hitung_PCC(nCC, UCC, 21);
        fitness = hitung_fitness(PCC);
        populasi(i, :) = [nCC, UCC, fitness];
    end
end

function orang_tua = seleksi_roulette_wheel(populasi, popsize)
    total_fitness = sum(populasi(:, end));
    r = rand() * total_fitness;
    partial_sum = 0;
    idx = 1;

    for i = 1:popsize
        partial_sum = partial_sum + populasi(i, end);
        if partial_sum >= r
            idx = i;
            break;
        end
    end

    orang_tua = populasi(idx, 1:end-1);
end

function offspring = crossover(orang_tua, pc, lb_nCC, ub_nCC, lb_UCC, ub_UCC)
    r = rand();
    if r <= pc
        p = randi([1, numel(orang_tua)-1]);
        offspring = [orang_tua(1:p), orang_tua(end-p+1:end)];
    else
        offspring = orang_tua;
    end
    offspring(1) = min(max(offspring(1), lb_nCC), ub_nCC);
    offspring(2) = min(max(offspring(2), lb_UCC), ub_UCC);
end


function offspring = mutasi(offspring, pm, lb_nCC, ub_nCC, lb_UCC, ub_UCC)
    for i = 1:numel(offspring)
        r = rand();
        if r <= pm
            if i == 1
                offspring(i) = lb_nCC + (ub_nCC - lb_nCC) * randi([0, 9]) / 9;
            else
                offspring(i) = lb_UCC + (ub_UCC - lb_UCC) * rand();
            end
        end
    end
    offspring(1) = min(max(offspring(1), lb_nCC), ub_nCC);
    offspring(2) = min(max(offspring(2), lb_UCC), ub_UCC);
end


function populasi = eval_fitness(populasi)
    for i = 1:size(populasi, 1)
        PCC = hitung_PCC(populasi(i, 1), populasi(i, 2), 21);
        fitness = hitung_fitness(PCC);
        populasi(i, end) = fitness;
    end
end

function partikel = init_pso(populasi, gen)
    partikel = zeros(size(populasi, 1), 2 * gen + 1);
    partikel(:, 1:gen) = populasi(:, 1:gen);
    partikel(:, gen+1:2*gen) = rand(size(populasi, 1), gen);
    partikel(:, end) = populasi(:, end);
end

function kecepatan = update_velocity(partikel, w, c1, c2, gbest)
    gen = floor(size(partikel, 2) / 2) - 1;
    kecepatan = zeros(size(partikel, 1), gen);
    for i = 1:size(partikel, 1)
        kecepatan(i, :) = w * partikel(i, gen+1:2*gen) + ...
            c1 * rand() * (gbest(1:gen) - partikel(i, 1:gen)) + ...
            c2 * rand() * (partikel(i, 1:gen) - partikel(i, 1:gen));
    end
end

function partikel = update_position(partikel, kecepatan, lb_nCC, ub_nCC, lb_UCC, ub_UCC)
    gen = floor(size(partikel, 2) / 2) - 1; % Convert gen to an integer
    partikel(:, gen+1:2*gen) = kecepatan;
    partikel(:, 1:gen) = partikel(:, 1:gen) + kecepatan;
    
    % Constrain nCC and UCC within bounds
    partikel(:, 1) = min(max(partikel(:, 1), lb_nCC), ub_nCC);
    partikel(:, 2) = min(max(partikel(:, 2), lb_UCC), ub_UCC);
end
