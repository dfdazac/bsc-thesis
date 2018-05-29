function result = motorSimulator(inputs)
%MOTORSIMULATOR Evaluate two motor models using two separate cores. This
%function uses the batch functionality of the SUMO toolbox to speed up
%motor evaluation. The core functions to evaluate a model are evalMotor1
%and evalMotor2.

% Author: Daniel F. Daza

%% Notify
disp([getTime, ' ', '[INFO]', ' ', num2str(size(inputs,1)), ' inputs received in simulator:']);
disp(num2str(inputs));

%% Some useful declarations
functions = cell(2,1);
functions{1} = str2func('evalMotor1');
functions{2} = str2func('evalMotor2');
outputs = zeros(size(inputs,1),1);

%% Evaluate
parfor i = 1:size(inputs,1)
    outputs(i) = functions{i}(inputs(i,:));
end

%% Return
result = [inputs outputs];

end