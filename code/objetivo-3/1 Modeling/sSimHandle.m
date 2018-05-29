clc, clear, close all;

sim('LMOpenLoop');

figure;
plot(simout.Time, simout.Data);
legend('Position (m)', 'Speed (m/s)', 'Location', 'SouthEast');