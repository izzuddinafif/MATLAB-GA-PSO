% Main script
close all; clc; clear;
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

% Fungsi utama
populasi = init_populasi(popsize, gen, lb_a, ub_a, lb_q, ub_q, lb_l, ub_l);
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
        offspring = crossover(populasi, orang_tua, pc, lb_a, ub_a, lb_q, ub_q, lb_l, ub_l, popsize, gen);
        offspring = mutasi(offspring, pm, lb_a, ub_a, lb_q, ub_q, lb_l, ub_l, gen);
        new_populasi(i, :) = offspring;
    end
    populasi = new_populasi;

    % PSO
    partikel = eval_fitness(partikel, b);
    for i = 1:popsize
        if partikel(i, end) > partikel(i, gen+1:2*gen)
            partikel(i, gen+1:2*gen) = partikel(i, 1:gen);
        end
    end
    [~, idx] = min(partikel(:, end));
    if partikel(idx, end) < gbest(end)
        gbest = partikel(idx, :);
    end
    partikel = update_pso(partikel, w, c1, c2, gbest, lb_a, ub_a, lb_q, ub_q, lb_l, ub_l, gen);

    % Simpan nilai fitness terbaik di setiap iterasi
    best_fitness(iterasi) = gbest(end);

    % Tampilkan nilai fitness terbaik di setiap iterasi
    %disp(['Iterasi ke-' num2str(iterasi) ': ' num2str(gbest(end))]);

end

% Tampilkan nilai fitness terbaik
disp(['Nilai fitness terbaik: ' num2str(gbest(end))]);

% Tampilkan nilai gen terbaik
disp(['Nilai gen terbaik: ' num2str(gbest(1:gen))]);



% Plot nilai fitness terbaik di setiap iterasi
plot(best_fitness);
xlabel('Iterasi');
ylabel('Fitness');
title('Nilai Fitness Terbaik di Setiap Iterasi');



% Functions required

function total = hitung_total(a, q, l, b)
    total = a * q * l * b;
end

function fitness = hitung_fitness(total)
    target_min = 26;
    target_max = 36;

    if target_min <= total && total <= target_max
        fitness = 1 / total;
    else
        fitness = 1 / (1 + abs(min(target_min - total, total - target_max)));
    end
end


function populasi = init_populasi(popsize, gen, lb_a, ub_a, lb_q, ub_q, lb_l, ub_l)
    populasi = zeros(popsize, gen + 1);
    for i = 1:popsize
        a = lb_a + (ub_a - lb_a) * rand();
        q = lb_q + (ub_q - lb_q) * rand();
        l = lb_l + (ub_l - lb_l) * rand();
        total = hitung_total(a, q, l, 21);
        fitness = hitung_fitness(total);
        populasi(i, :) = [a, q, l, fitness];
    end
end

function partikel = init_pso(populasi, gen)
    partikel = zeros(size(populasi, 1), 2 * gen + 1); % change the size of the 'partikel' array to be 2 * gen + 1
    for i = 1:size(populasi, 1)
        partikel(i, :) = [populasi(i, 1:gen), populasi(i, 1:gen), populasi(i, end)];
    end
end


function orang_tua = seleksi_roulette_wheel(populasi, popsize)
    fitness = populasi(:, end);
    fitness = fitness / sum(fitness);
    r = rand();
    i = 1;
    while r > 0
        r = r - fitness(i);
        i = i + 1;
    end
    orang_tua = populasi(i-1, :);
end

function offspring = crossover(populasi, orang_tua, pc, lb_a, ub_a, lb_q, ub_q, lb_l, ub_l, popsize, gen)
    if rand() < pc
        orang_tua2 = seleksi_roulette_wheel(populasi, popsize);
        offspring = zeros(1, gen + 1);
        for i = 1:gen
            if rand() < 0.5
                offspring(i) = orang_tua(i);
            else
                offspring(i) = orang_tua2(i);
            end
        end
        a = offspring(1);
        q = offspring(2);
        l = offspring(3);
        total = hitung_total(a, q, l, 21);
        fitness = hitung_fitness(total);
        offspring(end) = fitness;
    else
        offspring = orang_tua;
    end
end

function offspring = mutasi(offspring, pm, lb_a, ub_a, lb_q, ub_q, lb_l, ub_l, gen)
    if rand() < pm
        i = randi(gen);
        if i == 1
            offspring(i) = lb_a + (ub_a - lb_a) * rand();
        elseif i == 2
            offspring(i) = lb_q + (ub_q - lb_q) * rand();
        else
            offspring(i) = lb_l + (ub_l - lb_l) * rand();
        end
        a = offspring(1);
        q = offspring(2);
        l = offspring(3);
        total = hitung_total(a, q, l, 21);
        fitness = hitung_fitness(total);
        offspring(end) = fitness;
    end
end

function partikel = eval_fitness(partikel, b)
    for i = 1:size(partikel, 1)
        a = partikel(i, 1);
        q = partikel(i, 2);
        l = partikel(i, 3);
        total = hitung_total(a, q, l, b);
        fitness = hitung_fitness(total);
        partikel(i, end) = fitness;
    end
end

function partikel = update_pso(partikel, w, c1, c2, gbest, lb_a, ub_a, lb_q, ub_q, lb_l, ub_l, gen)
    for i = 1:size(partikel, 1)
        partikel(i, 1:gen) = w * partikel(i, 1:gen) + ...
            c1 * rand() * (partikel(i, gen+1:2*gen) - partikel(i, 1:gen)) + ...
            c2 * rand() * (gbest(1:gen) - partikel(i, 1:gen));
        for j = 1:gen
            if partikel(i, j) < lb_a
                partikel(i, j) = lb_a;
            elseif partikel(i, j) > ub_a
                partikel(i, j) = ub_a;
            end
        end
        a = partikel(i, 1);
        q = partikel(i, 2);
        l = partikel(i, 3);
        total = hitung_total(a, q, l, 21);
        fitness = hitung_fitness(total);
        partikel(i, end) = fitness;
    end
end

