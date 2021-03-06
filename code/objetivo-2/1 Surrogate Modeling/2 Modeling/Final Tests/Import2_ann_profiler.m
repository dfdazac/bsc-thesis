%% Import data from text file.
% Script for importing data from the following text file:
%
%    F:\Google Drive\My Docs\UD\Proyecto de Grado\Trabajo\Objetivo
%    2\Intento 2\1 Surrogate Modeling\2 Modeling\SUMO
%    Files\output\anngenetic__2016.03.03_00-31-07\profilers\BestModelScore_out.txt
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2016/05/28 08:46:28

%% Initialize variables.
filename = 'F:\Google Drive\My Docs\UD\Proyecto de Grado\Trabajo\Objetivo 2\Intento 2\1 Surrogate Modeling\2 Modeling\SUMO Files\output\anngenetic__2016.03.03_00-31-07\profilers\BestModelScore_out.txt';
delimiter = '\t';
startRow = 12;

%% Format string for each line of text:
%   column1: double (%f)
%	column2: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%*s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
textscan(fileID, '%[^\n\r]', startRow-1, 'ReturnOnError', false);
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
annData = [dataArray{1:end-1}];
%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;