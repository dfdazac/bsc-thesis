%% sPlotContours.m
% Author: Daniel F. Daza
% This script plots contour plots for every possible combination of the
% six design variables in the MLR surrogate model.
clc, clear, close all;

%% Set constraints and initial value
lb = [5, 5, 0.4, 2, 1, 25];
ub = [12, 14, 0.7, 4, 5, 100];

% Objective value of the initial design
tau = 6;
L = 7.1453;
bs2taus = 0.5;
hs = 2;
Im = 2.7;
nc = 57;
x0 = [tau, L, bs2taus, hs, Im, nc];
n = length(x0);

npoints = 50;
figure;
row = 1;
for i = 2:6
    col = 0;
    for j = 1:i-1
        xx = linspace(lb(j), ub(j), npoints);
        yy = linspace(lb(i), ub(i), npoints);
        [XX, YY] = meshgrid(xx, yy);
        
        X = repmat(x0, npoints^2, 1);
        X(:,j) = reshape(XX, npoints^2, 1);
        X(:,i) = reshape(YY, npoints^2, 1);
        X = X';
        
        Z = reshape(motornn(X)', npoints, npoints);
        %subplot(n-1,n-1,row+col);
        hold on;        
        col = col+1;
        contourf(XX,YY,Z,10);
        plot(x0(j), x0(i), 'ko', 'MarkerSize', 5, 'MarkerFaceColor','r');
        set(gca, 'xtick', []);
        set(gca, 'ytick', []);
        set(gca, 'Clim', [0, 30]);
    end
    row = row + 5;
end