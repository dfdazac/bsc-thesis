function best = runbf(f, vars, params, varargin)
%%RUNBF Run Bacterial Foraging for a maximization problem. This version 
%assumes that f is a vectorized objective function to be maximized. The
%parameters are defined by the params vector of length 10, as follows:
%   params(1): Population size (should be odd)
%   params(2): Number of chemotactic steps
%   params(3): Swim length
%   params(4): Number of reproduction steps
%   params(5): Number of dispersion events
%   params(6): Probability of dispersion
%   params(7): Strength of attractant/repellant
%   params(8): Width of attractant
%   params(9): Width of repellant
%   params(10): Run length unit
%   params(11): Selective pressure
%This is a big list of free parameters intented to allow experimentation
%with the algorithm. However, here is an initial set of parameters that
%can be used to test it:
%   params = [50, 100, 4, 4, 2, 0.25, 0.1, 0.2, 10, 0.1, 0.01];

%% Prepare and extract parameters

% Number of dimensions
n = size(vars, 1);
% Population size
S = params(1);
% Number of chemotactic steps
Nc = params(2);
% Swim length
Ns = params(3);
% Number of reproduction steps
Nre = params(4);
% Number of dispersion events
Ned = params(5);
% Probability of dispersion
ped = params(6);
% Strength of attractant/repellant
Sar = params(7);
% Width of attractant
Wa = params(8);
% Width of repellant
Wr = params(9);
% Run length unit
ru = params(10);
% Selective pressure
spress = params(11);

plotFlag = false;
arg = strcmpi(varargin, 'Plot');
if any(arg), plotFlag = true; end;

%% Create data structures
% Positions of the population of bacteria
P = repmat(vars(:,2) - vars(:,1), 1, S).*rand(n, S) + repmat(vars(:,1), 1, S);
% Nutrient function history
Jhmin = zeros(Ned*Nre*Nc, 1);
Jhmax = zeros(Ned*Nre*Nc, 1);
simStep = 1;

%% Initiate simulation
% Dispersion loop start
for i = 1:Ned
    % Reproduction loop start
    for j = 1:Nre
        %% Chemotactic loop start
        for k = 1:Nc
            % Compute the nutrient concentration
            J = f(P);
            
            % Save history
            Jhmin(simStep) = min(J);
            Jhmax(simStep) = max(J);
            simStep = simStep + 1;
            
            % Add cell-to-cell signaling
            J = J + cell2cell(J);                       
            % Swimming loop
            for m = 1:Ns
                % Store current nutrient landscape
                Jp = J; 
                % Compute the next position of the bacteria (in an
                % intermediate population matrix) using a random unit vector
                Pi = P + ru * randuv(n, S);
                % Initialize the next positions with the current positions
                Pnext = P;
                % Logical vector that contains the indices of the bacteria
                % whose movements do not violate the constraints after
                % swimming
                valid = sum(bsxfun(@gt, Pi, vars(:,1)) & bsxfun(@lt, Pi, vars(:,2)), 1) == n;
                % Update valid positions
                Pnext(:,valid) = Pi(:,valid);
                % Compute new nutrient landscape
                J = f(Pnext);
                J = J + cell2cell(J);
                % Only if for each bacterium the nutrient function is
                % better, it is moved
                valid = bsxfun(@gt, J, Jp);
                P(:,valid) = Pnext(:,valid);
            end
        end
        % Chemotactic loop end
        
        %% Reproduction
        % Passino suggests using the history of the nutrient function as a
        % measure of fitness for selection and reproduction. Here I propose
        % the use of the efficiency measure.
        
        % Update the nutrient landscape after chemotaxing
        J = f(P);
        Jmax = max(J);
        Jmin = min(J);
        eff = (1-spress)*(J - Jmin)/max([Jmax - Jmin, eps]) + spress;
        % Sort bacteria in descending order of efficiency
        [~, idxs] = sort(eff, 'descend');
        P(:,:) = P(:,idxs);
        % Half of the least fit bacterium dies and the rest splits in two
        % identical copies
        P(:,S/2+1:end) = P(:,1:S/2);
    end
    %% Dispersion events
    for j = 1:S
        if rand < ped
            idx = randi(n);
            P(idx, j) = (vars(idx,2) - vars(idx,1))*rand + vars(idx,1);
        end
    end  
end
%% Select the best individual
% Compute final nutrient function
J = f(P);
[~, idx] = max(J);
best = P(:,idx);

%% Plot
if plotFlag
    figure; hold on;
    plot(Jhmin);
    plot(Jhmax, 'r');
    xlabel('Steps');
    ylabel('Nutrient Function Value');
    legend('J_{min}', 'J_{max}', 'location', 'SouthEast');
    xlim([1, length(Jhmin)]);
    grid on;
end

%% Cell-to-cell attractant/repellant function
function Jcc = cell2cell(X)
    % Preallocate
    Jcc = zeros(1, S);
    % Compute the function for each bacterium in the population
    for b = 1:S
        % "Sum of squares of difference" matrix
        Ds = sum((repmat(X(:,b), 1, S) - X).^2, 1);
        Jcc(b) = Sar * (sum(exp(-Wa * Ds), 2) - sum(exp(-Wr * Ds), 2));
    end
end

%% Random unit vectors generator
function V = randuv(n, S)
% Generate S random unit vectors of n dimensions.
% Based on Maxim Vedenyov's generator.
% See http://www.mathworks.com/matlabcentral/fileexchange/25363-random-unit-vector-generator
    V = zeros(n, S);
    for ii = 1:S
        % Repeat if the vector is too small
        while 1
            % Use a normal distribution to guarantee angle uniform distribution
            v = randn(n, 1);
            % Square of the norm
            vsnorm = v'*v;
            if vsnorm > 1e-10
                % Normalize
                v = v/sqrt(vsnorm);
                break;
            end
        end
        V(:, ii) = v;
    end
end

end