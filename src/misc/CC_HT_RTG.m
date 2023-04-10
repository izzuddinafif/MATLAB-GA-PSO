% Optimasi kerja peralatan CC, HT dan RTG

n;
demand;
FC;
C1;

% CC
a;
tk;
PCC = demand/((n*a)/tk);

% RTG
TEUs;   % Ton per ship hour at berth
DT;
slot;
Tier;
Container;
Slot;
days;
year;
YOR = TEUs*DT/(slot*Tier*(Container/Slot)*(days/year));

% HT
PHT;
BWT;
Wd;
UHT = demand/(n*PHT*BWT*Wd);

% Biaya
TotalCost = n*tk*C1*FC