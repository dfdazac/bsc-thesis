%% sOptimizeMotorfmincon.m
% Author: Daniel F. Daza
%% Prepare
clc, clear, close all;

%% Initialize parameters
lb = [5, 5, 0.4, 2, 1, 25];
ub = [12, 14, 0.7, 4, 5, 100];
% Objective value of the initial design
tau = 6;
L = 7.1453;
bs2taus = 0.5;
hs = 2;
Im = 2.7;
nc = 57;
x = [tau; L; bs2taus; hs; Im; nc];
iniobjv = motornn2(x);

%% Counter for tests, remove later
global c;
c = 0;

%% Optimize
options = optimoptions(@fmincon,'Algorithm','sqp');
[bestMotor,fval,exitflag,output,lambda,grad] = fmincon(@motornn2, x, [], [], [], [], lb, ub, [], options);

%% Print results
disp(['Initial motor: ', num2str(-iniobjv)]);
disp(['Optimized motor: ', num2str(-fval)]);
disp('Parameters of the best motor:');
disp(['- tau = ', num2str(bestMotor(1))]);
disp(['- L = ', num2str(bestMotor(2))]);
disp(['- bs2taus = ', num2str(bestMotor(3))]);
disp(['- hs = ', num2str(bestMotor(4))]);
disp(['- Im = ', num2str(bestMotor(5))]);
disp(['- nc = ', num2str(bestMotor(6))]);
disp(['Objective function evaluated ', num2str(c), ' times.']);