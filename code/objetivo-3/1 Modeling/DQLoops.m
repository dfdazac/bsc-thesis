%% sDQLoops.m
% Author: Daniel F. Daza
% This file is intended to study the transfer functions of the direct and
% quadrature axes.
clc, clear, close all;

%% Define transfer functions and simulate step
Gd = tf(0.1312, [0.0806, 1]);
Gq = tf(0.1312, [0.0168, 1]);

figure; hold on;
step(Gd, Gq);
legend('Gd', 'Gq', 'Location', 'SouthEast');