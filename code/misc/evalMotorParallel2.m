function [f,Fx] = evalMotorParallel2(x)
%EVALMOTOR Evaluate a Reluctance Linear Motor model in COMSOL, according to
%the thrust Fx and the objective function f(x) = Ld/Lq * n, where Ld and Lq
%are the direct and quadrature axis inductances, n is the efficiency, and x
%is the vector of design variables:
%   Variable                                COMSOL variable name
% ----------------------------------------------------------------
%   x(1): Pole pitch                        tau
%   x(2): Width of the motor                L
%   x(3): Slot width to slot pitch ratio    bs2taus
%   x(4): Slot height                       hs
%   x(5): Back iron height                  hc
%   x(6): Number of laminations             NL
%   x(7): Laminations width                 wrr
%   x(8): Laminations angle                 thetarr
%   x(9): Stack height factor               shf
%   x(10): Primary current                  Im
%   x(11): Number of turns per coil         nc
%
%   [f,Fx] = EVALMOTOR(x) returns the value of the objective function f(x)
%   and the thrust Fx for a given design vector x.

%Author: Daniel F. Daza
mphstart(2037);
model = mphload('D:\Google Drive\My Docs\UD\Proyecto de Grado\Trabajo\Objetivo 1\Diseño inicial\COMSOL Files\RLM_v17.mph');

%% Set parameters
tau = x(1);
% model.param.set('tau',tau);
% model.param.set('L',x(2));
% model.param.set('bs2taus',x(3));
% model.param.set('hs',x(4));
% model.param.set('hc',x(5));
% model.param.set('NL',x(6));
% model.param.set('wrr',x(7));
% model.param.set('thetarr',x(8));
% model.param.set('shf',x(9));
% model.param.set('Im',x(10));
% model.param.set('nc',x(11));

%% Perform experiment to measure Ld
model.param.set('phi',pi/2);
model.param.set('d',0);
model.study('std1').run;
Ld = abs(mphglobal(model,'La'));

%% Perform experiment to measure Lq
model.param.set('d',tau/2);
model.study('std1').run;
Lq = abs(mphglobal(model,'La'));

%% Perform experiment to measure the thrust, Joule losses and efficiency
model.param.set('phi',0);
model.study('std1').run;
Fx = mphglobal(model,'Fx');
n = mphglobal(model,'n');

%% Compute objective function
f = Ld/Lq * n;

end