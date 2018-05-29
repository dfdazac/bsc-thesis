%% sOptimizeMotorBF.m
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

%% Counter for tests, remove later
global c;
c = 0;

%% Set up and run genetic algorithm
% Input variables (see motornn.m)
vars = [5.00, 12.00;
        5.00, 14.00;
        0.40, 0.700;
        2.00, 4.000;
        1.00, 5.000;
        25.0, 100.0];
    
% Algorithm parameters
params = [30, 40, 8, 4, 2, 0.25, 0.1, 0.3, 10, 0.1, 0.1];
bestMotor = runbf(@motornn, vars, params, 'Plot');
bestobjv = motornn(bestMotor);
% Additional info on plot
hold on;
plot([0, params(2)*params(3)*params(5)], [iniobjv, iniobjv], 'k', 'LineWidth', 2);
plot([0, params(2)*params(3)*params(5)], [bestobjv, bestobjv], 'r', 'LineWidth', 2);

%% Print results
disp(['Initial motor: ', num2str(iniobjv)]);
disp(['Optimized motor: ', num2str(bestobjv)]);
disp('Parameters of the best motor:');
disp(['- tau = ', num2str(bestMotor(1))]);
disp(['- L = ', num2str(bestMotor(2))]);
disp(['- bs2taus = ', num2str(bestMotor(3))]);
disp(['- hs = ', num2str(bestMotor(4))]);
disp(['- Im = ', num2str(bestMotor(5))]);
disp(['- nc = ', num2str(bestMotor(6))]);
disp(['Objective function evaluated ', num2str(c), ' times.']);