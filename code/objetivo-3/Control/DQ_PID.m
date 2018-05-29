%% sDQ_PID.m
% Author: Daniel F. Daza
% This file is intended to study the transfer functions of the direct and
% quadrature axes.
clc, clear, close all;

%% Define transfer functions and simulate step
Gd = tf(0.1312, [0.0806, 1]);
Gq = tf(0.1312, [0.0168, 1]);

figure;
step(Gd, Gq);
legend('Gd', 'Gq', 'Location', 'SouthEast');

%% Synthetize controllers and simulate
Cd = zpk([-59.262, -59.262], 0, 1.672);
Cq = zpk([-40.597, -40.597], 0, 0.182);
Hd = (Cd * Gd)/(1 + Cd * Gd);
Hq = (Cq * Gq)/(1 + Cq * Gq);
figure;
step(Hd, Hq);
legend('Hd', 'Hq', 'Location', 'SouthEast');