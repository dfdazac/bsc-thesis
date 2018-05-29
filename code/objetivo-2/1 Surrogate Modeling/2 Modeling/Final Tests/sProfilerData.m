%% sProfilerData.m
% Author: Daniel F. Daza
% This script visualizes the data produced by the profiler when training
% the best surrogate model for the motor.
clc, clear, close all;

%% Import data
Import2_ann_profiler;
Import3_rbf_profiler;
Import4_rat_profiler;
Import5_svm_profiler;

%% Plot
xann = annData(:,1);
yann = annData(:,2);
xrbf = rbfData(:,1);
yrbf = rbfData(:,2);
xrat = ratData(:,1);
yrat = ratData(:,2);
xsvm = svmData(:,1);
ysvm = svmData(:,2);

figure; hold on;
plot(xann, yann, 'r');
plot(xrbf, yrbf, 'g');
plot(xrat, yrat, 'b');
plot(xsvm, ysvm, 'k');
xlabel('Iteraciones');
ylabel('AEE');
xlim([min(xann), max(xann)]);
ylim([0, 5]);
legend('ANN', 'RBF', 'Racional', 'SVM');
grid on;