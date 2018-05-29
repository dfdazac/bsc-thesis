%% FieldDistributionAnalysis.m
% Author: Daniel F. Daza
% This file perform post-processing on the data obtained by the simulation
% of the initial design in COMSOL. The magnetic flux density (MFD) under for
% continuous duty thrust is analyzed along the airgap, with presence and
% absence of a ferromagnetic core. This data is obtained from a frequency
% domain analysis.

%% Prepare
clear, clc, close all;

% Length of the primary (cm)
Lp = 16.907;

%% Import data

% Import MFD without core
Import1_FieldDistributionAnalysis;
% Import MFD with core
Import2_FieldDistributionAnalysis;
% Import MFD with reaction rail, continuous duty
Import3_FieldDistributionAnalysis;
% Import MFD with reaction rail, peak duty
Import4_FieldDistributionAnalysis;
% Airgap line
zeroag = zeros(size(x));
% Spatial sampling frequency (samples/cm)
Fs = length(x)/Lp;

%% Plot (data without reaction rail)
figure;

% MFDs without core
subplot(2,3,1); hold on;
plot(x, zeroag, 'k'); plot(x, Bxwo);
xlim([0 max(x)]);
legend('Bx');
xlabel('x (cm)'); ylabel('Flux Density (T)');
fundamental = buildFundamental(x,Bxwo,Fs);
plot(x,fundamental,'r'); 

subplot(2,3,2); hold on;
plot(x, zeroag, 'k'); plot(x, Bywo);
xlim([0 max(x)]);
legend('By'); xlabel('x (cm)'); ylabel('Flux Density (T)');
fundamental = buildFundamental(x,Bywo,Fs);
plot(x,fundamental,'r');
title('Magnetic Flux Densities Without Core');

subplot(2,3,3); hold on;
plot(x, sqrt(Bxwo.^2+Bywo.^2));
xlim([0 max(x)]);
legend('|B|'); xlabel('x (cm)'); ylabel('Flux Density (T)');

% MFDs with core
subplot(2,3,4); hold on;
plot(x, zeroag, 'k'); plot(x, Bxw);
xlim([0 max(x)]);
legend('Bx'); xlabel('x (cm)'); ylabel('Flux Density (T)');
fundamental = buildFundamental(x,Bxw,Fs);
plot(x,fundamental,'r'); 

subplot(2,3,5); hold on;
plot(x, zeroag, 'k'); plot(x, Byw);
xlim([0 max(x)]);
legend('By'); xlabel('x (cm)'); ylabel('Flux Density (T)');
fundamental = buildFundamental(x,Byw,Fs);
plot(x,fundamental,'r'); 
title('Magnetic Flux Densities With Core');

subplot(2,3,6);
plot(x, sqrt(Bxw.^2+Byw.^2));
xlim([0 max(x)]);
legend('|B|'); xlabel('x (cm)'); ylabel('Flux Density (T)');

%% Plot (data with reaction rail)
figure;

% Continous duty data
subplot(2,2,1); hold on;
plot(xrr, zeroag, 'k'); plot(xrr, Bxrr);
xlim([min(xrr) max(xrr)]);
legend('Bx'); xlabel('x (cm)'); ylabel('Flux Density (T)');
fundamental = buildFundamental(xrr,Bxrr,Fs);
plot(xrr,fundamental,'r'); 

subplot(2,2,2); hold on;
plot(xrr, zeroag, 'k'); plot(xrr, Byrr);
xlim([min(xrr) max(xrr)]);
legend('By'); xlabel('x (cm)'); ylabel('Flux Density (T)');
fundamental = buildFundamental(xrr,Byrr,Fs);
plot(xrr,fundamental,'r');

subplot(2,2,[3,4]); hold on;
plot(xrr, sqrt(Bxrr.^2+Byrr.^2));
xlim([min(xrr) max(xrr)]);
legend('|B|'); xlabel('x (cm)'); ylabel('Flux Density (T)');

% Peak duty data
subplot(2,2,1);
fundamental = buildFundamental(xrr,Bxrrp,Fs);
plot(xrr,fundamental,'k'); 

subplot(2,2,2);
fundamental = buildFundamental(xrr,Byrrp,Fs);
plot(xrr,fundamental,'k');

subplot(2,2,[3,4]); hold on;
plot(xrr, sqrt(Bxrrp.^2+Byrrp.^2), 'k');
xlim([min(xrr) max(xrr)]);
xlabel('x (cm)'); ylabel('Flux Density (T)');
title('Airgap flux density magnitude under continuous (blue) and peak (black) duty');