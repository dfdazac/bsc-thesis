function best = runga(f, vars, popSize, nGen, spress, pcross, pmut, varargin)
%%RUNGA Run the Genetic Algorithm for a maximization problem. This version 
%assumes that f is a vectorized objective function to be maximized.

%% Prepare
% Number of variables
n = size(vars, 1);
plotFlag = false;
arg = strcmpi(varargin, 'Plot');
if any(arg), plotFlag = true; end;

%% Create data structures
% Initial population
pop = repmat(vars(:,2) - vars(:,1), 1, popSize).*rand(n, popSize) + repmat(vars(:,1), 1, popSize);
% Intermediate population
ipop = zeros(n, popSize);
% Fitness history
minH = zeros(1, nGen);
maxH = zeros(1, nGen);

%% Initiate evolution
for i = 1:nGen
    %% Individuals live and are put to test.
    % Objective function values vector
    objf = f(pop);
    % Efficiency vector
    fmax = max(objf);
    fmin = min(objf);
    minH(i) = fmin;
    maxH(i) = fmax;
    eff = (1-spress)*(objf-fmin)/max([fmax-fmin, eps]) + spress;
    % Roulette wheel
    wheel = cumsum(eff);
    
    %% Then, the fittest get greater chances to reproduce.
    % Generate mating pool
    for j = 1:popSize
        spin = max(wheel) * rand(1);        
        ipop(:,j) = pop(:,find(wheel >= spin, 1));
    end
    
    % Proceed to mate and cross
    for j = 1:2:popSize-1
        if rand(1) < pcross
            child = 0.5* ipop(:,j) + 0.5*ipop(:,j+1);
            pop(:,j) = child;
            pop(:,j+1) = child;
        else
            pop(:,j) = ipop(:,j);
            pop(:,j+1) = ipop(:,j+1);
        end
    end
    
    %% Some of the children might undergo mutation
    for j = 1:popSize
        if rand(1) < pmut
            idx = randi(n);
            pop(idx, j) = (vars(idx,2) - vars(idx,1))*rand(1) + vars(idx,1);
        end
    end    
end

%% Select the best individual
[~, idx] = max(objf);
best = pop(:, idx);

%% Plot history
if plotFlag
    figure; hold on;
    plot(minH);
    plot(maxH, 'r');
    legend('J_{min}', 'J_{max}', 'location', 'SouthEast');
    xlabel('Generations');
    ylabel('Fitness function value');
    grid on;
end
end