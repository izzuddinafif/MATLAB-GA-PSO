clear all; close all; clc;
% GA-PSO optimization

% Definitions

% Parameters
PCC=0;    % Produktivitas Container Crane (CC)
UCC=0;    % Utilitas CC
PHT=0;    % Produktivitas Head Truck (HT)
UHT=0;    % Utilitas HT

% Constants
BWT=0;      % Berth Working Time / Jumlah waktu kapal beroperasi
Wd = 360    % Jumlah hari kerja (hari)
COT = 21    % Waktu operasional crane (jam)
DT=0;       % Dwelling Time / Waktu petikemas di lapangan penumpukan

% Variables
YOR=0;    % Kapasitas lapangan kontainer
nRTG=0;   % Jumlah Rubber Tyred Gantry Crane (RTG)
Tier=0;   % Jumlah tingkatan kontainer
Cslot=0;  % Jumlah kontainer dalam satu slot
nHT=0;    % Jumlah HT
nCC=0;    % Jumlah CC

% Constraints
YOR >= 65;      % Persen
DT <= 2.83;     % Hari
Cslot <= 1.990; % Kontainer
Tier <= 4;      % Kontainer

% Objective Function
Opt=(PCC*nCC*UCC*BWT*Wd*DT)/(YOR*nRTG*Tier*Cslot*nHT*UHT*PHT);