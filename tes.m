%% Genetic Algorithm-Particle Swarm Optimization untuk mencari nilai optimum dari fungsi Produktivitas Crane CC %%
%% Izzuddin Ahmad Afif %%

% PCC		=    Produktivitas Container Crane (CC) (25 container/jam)
% nCC		=    Jumlah CC yang digunakan (1-10)
% UCC		=    Utilitas CC (0.5-1)
% tCC		=    waktu crane bekerja jam / hari (21 jam)
% PCC   	=    Demand/((nCC*UCC)/tCC)
% Demand	=    Jumlah container yang harus diangkut
% PCC       =    Demand/((nCC*UCC)/tCC) % Fungsi Produktivitas Crane CC
% variabel  =    [nCC UCC]
% Maksimasi PCC hingga range 25-35 container/jam (25<=PCC<=35) menggunakan Genetic Algorithm-Particle Swarm Optimization (GA-PSO) %

clc; clear all; close all;

%% Inisialisasi
nCC = 1; % Jumlah CC yang digunakan (1-10)
UCC = 0.5; % Utilitas CC (0.5-1)
tCC = 21; % waktu crane bekerja jam / hari (21 jam)
Demand = 1000; % Jumlah container yang harus diangkut
PCC = Demand/((nCC*UCC)/tCC); % Fungsi Produktivitas Crane CC
variabel = [nCC UCC]; % variabel

%% Genetic Algorithm-Particle Swarm Optimization (GA-PSO)
% Parameter GA
populasi = 10; % Jumlah populasi
generasi = 100; % Jumlah generasi
pc = 0.8; % Probabilitas crossover
pm = 0.2; % Probabilitas mutasi
ub = [10 1]; % Batas atas
lb = [1 0.5]; % Batas bawah

% Parameter PSO
w = 0.5; % Inersia
c1 = 1; % Faktor kognitif
c2 = 1; % Faktor sosial
iterasi = 100; % Jumlah iterasi
populasi_pso = 10; % Jumlah populasi

% Generate populasi awal
for i = 1:populasi
    for j = 1:2
        x(i,j) = lb(j) + (ub(j)-lb(j))*rand;
    end
end

% Evaluasi populasi awal
for i = 1:populasi
    f(i) = PCC;
end

