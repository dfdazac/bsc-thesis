%% sSaliencyCoefficients
% Author: Daniel F. Daza
% This script is intended to reproduce the saliency coefficient curves as
% shown in Boldea's articles.
clc, clear, close all;
%% Generate data for the direct axis and plot

x = 0.02:0.02:0.4;
kqm1 = 0.1./(x/0.02);
kqm2 = 0.24./(x/0.02);
kqm3 = 0.33./(x/0.02);

figure; hold on;
plot(x, kqm1, 'o-');
plot(x, kqm2, '^-');
plot(x, kqm3, 's-');
ylim([0, 0.4]);
legend('g = 0.2 mm', 'g = 0.6 mm', 'g = 1 mm');
xlabel('Paso polar (m)');
ylabel('K_{qm}');

%% Generate data for the quadrature axis and plot
x = 0.02:0.08:2;
kqm1 = -0.35./(x/0.02) + 1;
kqm2 = -0.35./(x/0.02) + 1.001;
kqm3 = -0.35./(x/0.02) + 1.002;

figure; hold on;
plot(x, kqm1, 'o-');
plot(x, kqm2, '^-');
plot(x, kqm3, 's-');
ylim([0.6, 1.02]);
legend('g = 0.2 mm', 'g = 0.6 mm', 'g = 1 mm', 'Location', 'SouthEast');
xlabel('Paso polar (m)');
ylabel('K_{dm}');