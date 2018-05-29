%% sProcessLog.m
% Author: Daniel F. Daza

%% Prepare
%clc, clear, close all;

%% Import log file
[filename, pathname] = uigetfile('../SUMO Files/output/*.log');

if filename ~= 0
    filepath = [pathname, filename];
    logFile = importLoggingFile(filepath);

    %% Filter log file for scores
    scoresLog = char(logFile(not(...
        cellfun('isempty', strfind(logFile, 'New ordered measure scores')))));

    %% Convert to numeric array

    % Clean (I know this indexing is dirty...)
    scoresLog = scoresLog(:, 73:end-22);

    % Go back to cell to apply conversion from string to number
    scoresLog = cellstr(scoresLog);

    % Convert each cell to a number, transpose and convert to matrix
    scoresLog = cell2mat(cellfun(@str2num, scoresLog, 'UniformOutput', 0)');

    %% Obtain best, average and worst scores
    bestSc = min(scoresLog);
    averageSc = mean(scoresLog);
    worstSc = max(scoresLog);

    %% Plot
    axes(handles.axes1); hold on; grid on; drawnow;
    plot(bestSc, 'b');
    plot(averageSc, 'k');
    plot(worstSc, 'r');
    xlabel('Steps');
    ylabel('Score');
    xlim([1 length(bestSc)]);
    ylim([0 max(worstSc)]);
    legend(['Best      ' num2str(bestSc(end))], ['Average ' num2str(averageSc(end))], ['Worst    ' num2str(worstSc(end))]);
end