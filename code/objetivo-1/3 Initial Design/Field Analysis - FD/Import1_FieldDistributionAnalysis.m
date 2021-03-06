%% Import data from text file.
% Script for importing data from the following text file:
%
%    D:\Google Drive\My Docs\UD\Proyecto de Grado\Trabajo\Objetivo 1\Dise�o
%    inicial\Field Analysis - FD\MFDwoutCore_FD.csv
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2015/09/28 21:38:05

%% Initialize variables.
filename = 'F:\Google Drive\My Docs\UD\Proyecto de Grado\Trabajo\Objetivo 1\Dise�o inicial\Field Analysis - FD\MFDwoutCore_FD.csv';
delimiter = ',';

%% Format string for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
x = dataArray{:, 1};
y = dataArray{:, 2};
Bxwo = dataArray{:, 3};
Bywo = dataArray{:, 4};

%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans;