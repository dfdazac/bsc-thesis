%% sTestBF.m
clc, clear, close all;

%% Unimodal convex function
f1 = @(x)(-x.^2 + 0.5);
vars = [-1, 1];
params = [6, 5, 4, 4, 2, 0, 0.1, 0.2, 10, 0.01, 0.01];
best = runbf(f1, vars, params);

subplot(2,3,1); hold on;
x = linspace(vars(1), vars(2), 100);
plot(x, f1(x));
plot(best, f1(best), 'r.', 'MarkerSize', 20);

%% Multimodal function
f1 = @(x)(sinc(x));
vars = [-5, 5];
params = [10, 5, 4, 4, 2, 0.25, 0.1, 0.2, 10, 0.01, 0.01];
best = runbf(f1, vars, params);

subplot(2,3,2); hold on;
x = linspace(vars(1), vars(2), 100);
plot(x, f1(x));
plot(best, f1(best), 'r.', 'MarkerSize', 20);

%% Multiple-frequencies periodical function
f1 = @(x)(sin(x) + 0.5*cos(5*x));
vars = [0, 5];
params = [10, 6, 4, 4, 2, 0.25, 0.1, 0.2, 10, 0.01, 0.01];
best = runbf(f1, vars, params);

subplot(2,3,3); hold on;
x = linspace(vars(1), vars(2), 100);
plot(x, f1(x));
plot(best, f1(best), 'r.', 'MarkerSize', 20);

%% Multimodal convex-shaped function
f1 = @(x)(-x.^2 + 0.25*sin(30*x));
vars = [-1, 1];
params = [30, 12, 4, 4, 2, 0.25, 0.1, 0.25, 10, 0.01, 0.01];
best = runbf(f1, vars, params);

subplot(2,3,4); hold on;
x = linspace(vars(1), vars(2), 200);
plot(x, f1(x));
plot(best, f1(best), 'r.', 'MarkerSize', 20);

%% Piecewise-continuous multimodal convex-shaped function
f1 = @(x)(-x.^2 + 0.1*sawtooth(40*x));
vars = [-1, 1];
params = [10, 12, 4, 4, 2, 0.25, 0.1, 0.25, 10, 0.01, 0.01];
best = runbf(f1, vars, params);

subplot(2,3,5); hold on;
x = linspace(vars(1), vars(2), 200);
plot(x, f1(x));
plot(best, f1(best), 'r.', 'MarkerSize', 20);

%% Maximum in the boundary
f1 = @(x)(x.^3 + 2*x.^2);
vars = [-3, 1];
params = [10, 12, 4, 4, 2, 0.25, 0.1, 0.25, 10, 0.01, 0.01];
best = runbf(f1, vars, params);

subplot(2,3,6); hold on;
x = linspace(vars(1), vars(2), 200);
plot(x, f1(x));
plot(best, f1(best), 'r.', 'MarkerSize', 20);