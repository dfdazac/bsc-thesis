%% sOptimizeMotorGA_hist.m
% Author: Daniel F. Daza
%% Prepare
clc, clear, close all;
    
% Objective value of the initial design
tau = 6;
L = 7.1453;
bs2taus = 0.5;
hs = 2;
Im = 2.7;
nc = 57;
x = [tau; L; bs2taus; hs; Im; nc];
iniobjv = motornn(x);

%% Experiments setup
nExper = 100;
results = zeros(nExper,1);

%% Set up and run genetic algorithm
% Input variables (see motornn.m)
vars = [5.00, 12.00;
        5.00, 14.00;
        0.40, 0.700;
        2.00, 4.000;
        1.00, 5.000;
        25.0, 100.0];
    
% Algorithm parameters
popSize = 200;
nGen = 2000;

%% Start experiments
for i = 1:nExper
    bestMotor = runga(@motornn,vars,popSize,nGen,0.01,0.6,0.002);
    results(i) = motornn(bestMotor);
    disp(['Experiment ', num2str(i), ': ', num2str(results(i))]);
end