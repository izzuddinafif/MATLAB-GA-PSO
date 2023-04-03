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


options = optimoptions('particleswarm', 'SwarmSize', nPop, 'MaxIterations', nGen, ...
    'HybridFcn', {@ga, nPop, [], [], [], [], lb, ub, [], optimoptions('ga', 'PopulationSize', nPop, 'MaxGenerations', nGen)});
[opt_val, opt_sol] = particleswarm(Opt, 13, lb, ub, options);
