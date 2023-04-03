%% Genetic Algorithm-Particle Swarm Optimization untuk mencari nilai optimum dari fungsi Produktivitas Crane CC %%
% PCC		=    Produktivitas Container Crane (CC)
% nCC		=    Jumlah CC (integer antara 1-10)
% UCC		=    Utilitas CC (double antara 0.8-1)
% tCC		=    waktu crane bekerja jam / hari (21 jam)
% PCC   	=    Demand/((nCC*UCC)/tCC) (box/hari) (fungsi yang akan dicari nilai optimumnya)
% Mencari nilai optimum dari fungsi PCC sebagai fungsi fitness yaitu minimal 26 box/hari dan maksimal 36 box/hari dengan 2 variable nCC dengan batasan bilangan bulat 1-10 dan UCC dengan batasan bilangan pecahan 0.8-1.0
% Prosesnya adalah menentukan  menentukan fungsi fitness serta variabel-variabel yang dibutuhkan, inisialisasi populasi, lalu dimulai iterasi GA-PSO yang berupa: seleksi orang tua dengan roulette wheel selection, crossover, mutasi, sehingga didapatkan populasi baru, lalu dilakukan Proses PSO untuk mendapatkan nilai fitness terbaik dari populasi baru, lalu dilakukan iterasi selanjutnya sampai iterasi maksimum tercapai.
%{
% Menentukan nilai fitness sebagai fungsi objektif
if (PCC >= 26 && PCC <= 36)
    fitness = 1/PCC;
else
    fitness = 0; % Jika nilai PCC di luar range, fitness = 0
end
%}

clc; clear; close all;

% Parameter GA-PSO
max_iterasi = 100;   % Maksimum iterasi
popsize = 100;        % Ukuran populasi
gen = 2;            % Jumlah gen/variable
pc = 0.25;          % Probabilitas crossover
pm = 0.01;           % Probabilitas mutasi
ub_nCC = 10;        % Batas atas nCC
lb_nCC = 1;       % Batas bawah nCC
ub_UCC = 1.0;        % Batas atas UCC
lb_UCC = 0.8;       % Batas bawah UCC
w = 0.5;            % Inersia
c1 = 1;             % Faktor kognitif
c2 = 1;             % Faktor sosial


%% Inisialisasi

% Inisialisasi populasi
populasi = zeros(popsize, gen);
for i = 1:popsize
    populasi(i, 1) = randi([lb_nCC ub_nCC]); % Inisialisasi nCC
    populasi(i, 2) = (ub_UCC-lb_UCC)*rand + lb_UCC; % Inisialisasi UCC
end


%% Iterasi GA-PSO

% Inisialisasi variabel-variabel
iterasi = 1;
best_fitness = 0;
best_posisi = zeros(1, gen);
best_fitness_iterasi = zeros(1, max_iterasi);
best_posisi_iterasi = zeros(max_iterasi, gen);

% Iterasi GA-PSO

while iterasi <= max_iterasi
    % Evaluasi fitness
    fitness = zeros(popsize, 1);
    for i = 1:popsize
        nCC = populasi(i, 1);
        UCC = populasi(i, 2);
        tCC = 21; % jam
        PCC = 100/((nCC*UCC)/tCC); % box/hari
        if (PCC >= 26 && PCC <= 36)
            fitness(i) = 1/PCC;
        else
            fitness(i) = 0; % Jika nilai PCC di luar range, fitness = 0
        end
    end
    
    % Seleksi orang tua dengan roulette wheel selection
    fitness = fitness/sum(fitness);
    prob = cumsum(fitness);
    populasi_baru = zeros(popsize, gen);
    for i = 1:popsize
        r = rand;
        for j = 1:popsize
            if r <= prob(j)
                populasi_baru(i, :) = populasi(j, :);
                break;
            end
        end
    end
    
    % Crossover
    for i = 1:2:popsize
        r = rand;
        if r <= pc
            % Pilih titik crossover
            titik_crossover = randi([1 gen-1]);
            % Lakukan crossover
            anak1 = [populasi_baru(i, 1:titik_crossover) populasi_baru(i+1, titik_crossover+1:end)];
            anak2 = [populasi_baru(i+1, 1:titik_crossover) populasi_baru(i, titik_crossover+1:end)];
            % Ganti populasi lama dengan anak-anak
            populasi_baru(i, :) = anak1;
            populasi_baru(i+1, :) = anak2;
        end
    end
    
    % Mutasi
    for i = 1:popsize
        r = rand;
        if r <= pm
            % Pilih titik mutasi
            titik_mutasi = randi([1 gen]);
            % Lakukan mutasi
            if titik_mutasi == 1
                populasi_baru(i, titik_mutasi) = randi([lb_nCC ub_nCC]);
            else
                populasi_baru(i, titik_mutasi) = (ub_UCC-lb_UCC)*rand + lb_UCC;
            end
        end
    end

    % Proses PSO
    % Inisialisasi variabel-variabel
    v = zeros(popsize, gen); % Kecepatan
    pbest_posisi = populasi_baru; % Posisi terbaik
    pbest_fitness = zeros(popsize, 1); % Fitness terbaik
    gbest_posisi = zeros(1, gen); % Posisi terbaik global
    gbest_fitness = 0; % Fitness terbaik global

    % Evaluasi fitness
    for i = 1:popsize
        nCC = populasi_baru(i, 1);
        UCC = populasi_baru(i, 2);
        tCC = 21; % jam
        PCC = 100/((nCC*UCC)/tCC); % box/hari
        if (PCC >= 26 && PCC <= 36)
            pbest_fitness(i) = 1/PCC;
        else
            pbest_fitness(i) = 0; % Jika nilai PCC di luar range, fitness = 0
        end
    end

    % Cari nilai fitness terbaik global
    [gbest_fitness, idx] = max(pbest_fitness);
    gbest_posisi = pbest_posisi(idx, :);

    % Iterasi PSO
    iterasi_pso = 1;
    max_iterasi_pso = 100;

    while iterasi_pso <= max_iterasi_pso
        