%% sPlotMagCurves
% Author: Daniel F. Daza
%
%% Prepare
clc, clear, close all;

%% Import
[Im, LambdaD] = importMagCurvefile('DirectAxisMagCurve.csv',6,31);
[~, LambdaQ] = importMagCurvefile('QuadratureAxisMagCurve.csv',6,31);
[~, LambdaD2] = importMagCurvefile('DirectAxisMagCurve2.csv',6,31);
[~, LambdaQ2] = importMagCurvefile('QuadratureAxisMagCurve2.csv',6,31);

%% Plot
figure; hold on;
plot(Im, LambdaD, 'k'); grid on;
plot(Im, LambdaD2, 'k', 'LineWidth', 1.5);
legend('Diseño inicial','Diseño mejorado');
plot(1.779, 0.2128, 'k.', 'MarkerSize', 16);
plot(2.333, 0.5, 'k.', 'MarkerSize', 16);
xlabel('I_a (A)'); ylabel('Flujo de enlace (Wb)');
ylim([-0.6 0.6]);

figure; hold on;
plot(Im, LambdaQ, 'k'); grid on;
plot(Im, LambdaQ2, 'k', 'LineWidth', 1.5);
legend('Diseño inicial','Diseño mejorado');
plot(1.779, 0.0577, 'k.', 'MarkerSize', 16);
plot(2.333, 0.0977, 'k.', 'MarkerSize', 16);
xlabel('I_a (A)'); ylabel('Flujo de enlace (Wb)');
ylim([-0.15 0.15]);
