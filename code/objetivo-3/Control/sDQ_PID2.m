%% sDQ_PID2.m
% Author: Daniel F. Daza
% This file is intended to study the transfer functions of the direct and
% quadrature axes.
clc, clear, close all;

%% Define transfer functions
Gd = tf(0.1312, [0.0806, 1]);
Gq = tf(0.1312, [0.0168, 1]);

%% Synthetize controllers
Cd = zpk([-15.5680, -358.432], 0, 0.0500);
Cq = zpk([-124.531, -132.612], 0, 0.0175);
Hd = (Cd * Gd)/(1 + Cd * Gd);
Hq = (Cq * Gq)/(1 + Cq * Gq);

%% Simulate and compare
figure;
subplot(2,1,1);
step(Gd, Gq);
legend('Gd', 'Gq', 'Location', 'SouthEast');
xlim([0, 0.8]);

subplot(2,1,2);
step(Hd, Hq);
legend('Hd', 'Hq', 'Location', 'SouthEast');
xlim([0, 0.8]);