%% Inductances.m
% Author: Daniel F. Daza
% This scripts plots the direct and quadrature axis inductances for several
% values of the phase current. Four cases are considered: 
% - Thin teeth, unsaturated core
% - Thin teeth, saturated core
% - Thick teeth, saturated core
% - Final design

%% Prepare
clc, clear, close all;

%% Import

[Im, Ld] = importInductanceVsImFile('LdVsIm.csv', 6, 15);
[~, Lq] = importInductanceVsImFile('LqVsIm.csv', 6, 15);
[~, Ldu] = importInductanceVsImFile('LdVsIm_unsaturated.csv', 6, 15);
[~, Lqu] = importInductanceVsImFile('LqVsIm_unsaturated.csv', 6, 15);
[~, Ldt] = importInductanceVsImFile('LdVsIm_thick.csv', 6, 15);
[~, Lqt] = importInductanceVsImFile('LqVsIm_thick.csv', 6, 15);

[~, Ldf] = importInductanceVsImFile('LdVsIm_f.csv', 6, 15);
[~, Lqf] = importInductanceVsImFile('LqVsIm_f.csv', 6, 15);

%% Plot saturated vs unsaturated results
figure; hold on;

plot(Im, Ld);
plot(Im, Ldu, 'b--');
plot(Im, Ldt, 'LineWidth', 2);
plot(Im, Lq, 'r');
plot(Im, Lqu, 'r--');
plot(Im, Lqt, 'r', 'LineWidth', 2);

legend('Ld','Ld (no saturation)','Ld (thick)','Lq','Lq (no saturation)','Lq (thick)');
ylim([0 0.35]);
xlabel('Phase Current (A)');
ylabel('Inductance (H)');
title('Direct and Quadrature Axis Inductances');

%% Plot initial vs final design
figure; hold on;
plot(Im, Ld, '--b');
plot(Im, Ldf, 'b', 'LineWidth', 2);
plot(Im, Lq, '--r');
plot(Im, Lqf, 'r', 'LineWidth', 2);

plot(2.338,0.2134,'k.','MarkerSize',20);
plot([0, 2.338, 2.338], [0.2134, 0.2134, 0], '--k');
plot(2.338,0.04186,'k.','MarkerSize',20);
plot([0, 2.338, 2.338], [0.04186, 0.04186, 0], '--k');

legend('Ld (initial)','Ld (final)','Lq (initial)','Lq (final)', 'Operating points');
ylim([0 0.35]);
xlabel('Phase Current (A)');
ylabel('Inductance (H)');
title('Direct and Quadrature Axis Inductances');