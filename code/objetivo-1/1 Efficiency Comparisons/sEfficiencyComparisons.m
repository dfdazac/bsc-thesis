%% Efficiency Comparisons
% Author: Daniel F. Daza
% This script takes efficiency and power factor values from references
% cited in the book, taking into account the LIM, LSM and LRM types of
% linear motors, and compares them using two charts.

%% Prepare
clc, clear, close all;

%% Load efficiencies data (see Refs_effs.xlsx)
LIMeffs = [0.55
            0.327
            0.5484
            0.62
            0.74
            0.6365
            0.5539
            0.5447
            0.5316
            0.7049
            0.2022
            0.7069
            0.6886
            0.72
            0.44
            0.8];

LSMeffs = [0.78
            0.796
            0.778
            0.801
            0.73
            0.619
            0.639
            0.7127
            0.7089
            0.9
            0.92
            0.9
            0.85
            0.81
            0.9];

LRMeffs = [0.93
            0.92
            0.915
            0.91
            0.9
            0.85
            0.525];

%% Plot data points
figure; hold on;
plot(LIMeffs,'o','LineWidth', 2, 'MarkerFaceColor', 'b');
plot(LSMeffs,'or','LineWidth', 2, 'MarkerFaceColor', 'r');
plot(LRMeffs,'ok','LineWidth', 2, 'MarkerFaceColor', 'k');
xlim([0 16]); ylim([0 1]);
set(gca,'XtickLabel',[]);
ylabel('Eficiencia');
legend('MLI', 'MLS', 'MLR', 'Location', 'SouthEast');
grid on;

%% Plot data bands
figure; hold on;
patch([0 1 1 0],[min(LIMeffs) min(LIMeffs) max(LIMeffs) max(LIMeffs)], ...
    'b', 'FaceAlpha', 0.5);
patch([2 3 3 2],[min(LSMeffs) min(LSMeffs) max(LSMeffs) max(LSMeffs)], ...
    'r', 'FaceAlpha', 0.5);
patch([4 5 5 4],[min(LRMeffs) min(LRMeffs) max(LRMeffs) max(LRMeffs)], ...
    'k', 'FaceAlpha', 0.5);
xlim([-1 6]); ylim([0 1]);
set(gca,'XtickLabel',[]);
ylabel('Eficiencia');
legend('MLI', 'MLS', 'MLR', 'Location', 'SouthEast');
grid on;

%% Load power factor data (see Refs_effs.xlsx)
LIMpfs = [0.7
        0.415
        0.4844
        0.8
        0.4641
        0.608
        0.5916
        0.6071
        0.4718
        0.4657
        0.4778
        0.5188
        0.46
        0.42
        0.7];
    
LSMpfs = [0.766
        0.762
        0.85
        0.67
        0.55
        0.45];
    
LRMpfs = [0.48
        0.55
        0.59
        0.5
        0.4
        0.25
        0.89];

%% Plot data points
figure; hold on;
plot(LIMpfs,'o','LineWidth', 2, 'MarkerFaceColor', 'b');
plot(LSMpfs,'or','LineWidth', 2, 'MarkerFaceColor', 'r');
plot(LRMpfs,'ok','LineWidth', 2, 'MarkerFaceColor', 'k');
xlim([0 16]); ylim([0 1]);
set(gca,'XtickLabel',[]);
ylabel('Factor de potencia');
legend('MLI', 'MLS', 'MLR', 'Location', 'SouthEast');
grid on;

%% Plot data bands
figure; hold on;
patch([0 1 1 0],[min(LIMpfs) min(LIMpfs) max(LIMpfs) max(LIMpfs)], ...
    'b', 'FaceAlpha', 0.5);
patch([2 3 3 2],[min(LSMpfs) min(LSMpfs) max(LSMpfs) max(LSMpfs)], ...
    'r', 'FaceAlpha', 0.5);
patch([4 5 5 4],[min(LRMpfs) min(LRMpfs) max(LRMpfs) max(LRMpfs)], ...
    'k', 'FaceAlpha', 0.5);
xlim([-1 6]); ylim([0 1]);
set(gca,'XtickLabel',[]);
ylabel('Factor de potencia');
legend('MLI', 'MLS', 'MLR', 'Location', 'SouthEast');
grid on;