%% sGABFHistograms.m
% Author: Daniel F. Daza
clc, clear, close all;

%% Load data
load('Genetic Algorithm/garesults.mat');
load('Bacterial Foraging/bfresults.mat');
fminconresult = 78.5628;

figure; hold on;
hist(garesults,15);
hist(bfresults,15);
h = findobj(gca,'Type','patch');
set(h(2),'FaceColor','b','EdgeColor','w','LineWidth',1.0,'facealpha',0.75);
set(h(1),'FaceColor','r','EdgeColor','w','LineWidth',1.0,'facealpha',0.75);
grid on;
plot([fminconresult, fminconresult], [0, 25], 'k', 'LineWidth', 2);
xlim([74, 80]);
xlabel('f(x)');
ylabel('Frecuencia');
legend('AG', 'AFB', 'PCS', 'Location', 'NorthWest');