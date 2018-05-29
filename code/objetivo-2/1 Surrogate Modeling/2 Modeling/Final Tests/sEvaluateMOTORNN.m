%% sEvaluateMOTORNN
% Author: Daniel F. Daza

%% Prepare
clc, clear, close all;

%% Import data
Import1_simData;
simData = simData';

% Inputs
X = simData(1:6,:);
% Outputs
F = simData(7,:);

%% Simulate using neural network
disp(['Simulating ', num2str(size(X, 2)), ' samples...']);
tic;
Y = motornn(X);
toc;

%% Plot
figure; hold on; grid on;
plot(Y, F, 'x');
plot([min(F), max(F)*1.05], [min(F), max(F)*1.05], 'r')
xlabel('Simulated Output');
ylabel('Actual Output');
legend('Results', 'Ideal', 'Location', 'SouthEast');

%% Print
disp('It works!');