%% sSpeedControl.m
% Author: Daniel F. Daza
% This file simulates the open loop physical system of the linear motor,
% represented by a system with a pole in the origin, and also a closed loop
% system for speed control in which a proportional controller guarantees
% zero position error, zero overshoot and a settling time of two seconds.
clc, clear, close all;

%% Plant parameters and system
 
% Mass (kg)
m = 6.6; 
% Plant
sys = tf(1, [m, 0]);
% Proportional constant
K = 13.2;
% Closed loop system
closed = K*sys/(1 + K*sys);

%% Simulate
figure;
step(sys, closed);
xlim([0, 10]);
legend('Open Loop', 'Closed Loop', 'Location', 'SouthEast');