%% sSimFinal.m
% Author: Daniel F. Daza
% This script is the last one written for my final project. It consists of
% a simulation of the complete system with a speed controller.
clc, clear, close all;

%% Simulate
sim('SimFinal');

%% Process and plot results
t = simout.Time;
x = simout.Data(:,1);
v = simout.Data(2362:end, 2);
r = simout.Data(2362:end, 3);

figure;
subplot(2,1,1);
plot(t, x);
title('Position Response');
xlabel('t (s)');
ylabel('x (m)');


t = linspace(0, max(t), length(v));
subplot(2,1,2); hold on;
plot(t, r, 'b--');
plot(t, v, 'k');
title('Speed Response');
xlabel('t (s)');
ylabel('v (m/s)');
legend('V_{ref}', 'V');