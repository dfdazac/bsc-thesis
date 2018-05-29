%% sAnalyzeFResponse
% Author: Daniel F. Daza
% This script shows a histogram of the output values. The idea is to
% observe the range of the output and its distribution in order to get a
% criteria when an error function is chosen.

%% Prepare
clc, clear, close all;

%% Load data
Import1_SplitExportData;

% Design variables
X = samples(:,1:6);
% Objective function 
f = samples(:,7);

%% Plot histogram
% Number of bins
b = 20;

figure;
hist(f,b);
%title('Histogram of output values');
xlabel('Valor');
ylabel('Frecuencia');

% Add the output value for the initial design
hold on;
plot([11.6 11.6], [0,max(hist(f,b))],'r','LineWidth',2);

%% Extra data
disp('Red line in Fig. 1 shows the output value for the initial design.');
disp(['min(f) = ', num2str(min(f))]);
disp(['max(f) = ', num2str(max(f))]);
