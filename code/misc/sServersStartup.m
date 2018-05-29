%% sServersStartup.m
% Author: Daniel F. Daza
% This script prepares two COMSOL servers executed in parallel. They must
% have been already opened.

%% Initialize SUMO
cd 'D:\Software\Work\MATLAB Toolboxes\SUMO\sumo-toolbox\';
startup

%% Start COMSOL servers
% First server running on port 2036
system('start "" "C:\Program Files\COMSOL\COMSOL43\bin\win64\comsolserver.exe"');
pause(0.5);
% Second server running on port 2037
system('start "" "C:\Program Files\COMSOL\COMSOL43\bin\win64\comsolserver.exe"');

%% Load COMSOL server framework
cd 'C:\Program Files\COMSOL\COMSOL43\mli\';
servers = [2036, 2037];
parfor i=1:2
    mphstart(servers(i));
end

%% Return to SUMO
cd 'D:\Software\Work\MATLAB Toolboxes\SUMO\sumo-toolbox\';