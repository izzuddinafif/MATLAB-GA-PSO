% Parameter
% nCC = ...; % nilai nCC
% UCC = ...; % nilai UCC
% BWT = ...; % nilai BWT
% Wd = ...; % nilai Wd
% DT = ...; % nilai DT
% YOR = ...; % nilai YOR
% nRTG = ...; % nilai nRTG
% Tier = ...; % nilai Tier
% Cslot = ...; % nilai Cslot
% nHT = ...; % nilai nHT
% UHT = ...; % nilai UHT
% PHT = ...; % nilai PHT
% 
% Fungsi optimasi
% Opt = @(PCC) (PCC*nCC*UCC*BWT*Wd*DT)/(YOR*nRTG*Tier*Cslot*nHT*UHT*PHT);

% Fungsi optimasi dengan semua variabel
Opt = @(x) (x(1)*x(2)*x(3)*x(4)*x(5)*x(6))/(x(7)*x(8)*x(9)*x(10)*x(11)*x(12)*x(13));

% Batasan untuk masing-masing variabel
lb = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; % Batas bawah
ub = [100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100]; % Batas atas

% Parameter untuk algoritma GA
nPop = 100; % Ukuran populasi
nGen = 100; % Jumlah iterasi maksimum

% Jalankan algoritma GA
options_ga = optimoptions('ga', 'PopulationSize', nPop, 'MaxGenerations', nGen);
[opt_sol_ga, opt_val_ga] = ga(Opt, 13, [], [], [], [], lb, ub, [], options_ga);

% Parameter untuk algoritma PSO
swarmSize = 100;
maxIterations = 100;

% Jalankan algoritma PSO dengan solusi GA sebagai titik awal
options_pso = optimoptions('particleswarm', 'SwarmSize', swarmSize, 'MaxIterations', maxIterations, 'InitialSwarmMatrix', repmat(opt_sol_ga, swarmSize, 1));
[opt_sol_pso, opt_val_pso] = particleswarm(Opt, 13, lb, ub, options_pso);

% Gabungkan hasil GA dan PSO
if opt_val_pso < opt_val_ga
    opt_val = opt_val_pso;
    opt_sol = opt_sol_pso;
else
    opt_val = opt_val_ga;
    opt_sol = opt_sol_ga;
end
