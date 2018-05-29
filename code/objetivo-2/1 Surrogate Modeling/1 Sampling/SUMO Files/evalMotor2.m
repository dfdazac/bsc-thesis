function f = evalMotor2(x)
%EVALMOTOR Evaluate a Reluctance Linear Motor model in COMSOL, according to
%the thrust Fx and the objective function f(x) = Fx/Pj, where Pj is the
%power due to Joule losses. The design variables, selected after a
%screening process, are:
%   Variable                                COMSOL variable name
% ----------------------------------------------------------------
%   x(1): Pole pitch                        tau [cm]
%   x(2): Width of the motor                L [cm]
%   x(3): Slot width to slot pitch ratio    bs2taus
%   x(4): Slot height                       hs [cm]
%   x(5): Primary current                   Im
%   x(6): Number of turns per coil          nc
%
%This function assumes that the mph model is already loaded in the COMSOL
%server, as in the following example:
%   model = mphload('D:\Google Drive\My Docs\UD\Proyecto de Grado\Trabajo\Objetivo 1\Diseño inicial\COMSOL Files\RLM_v18')
%
%   f = EVALMOTOR(model,x) returns the value of the objective function f(x)
%   evaluated for the model, for a given design vector x.

%Author: Daniel F. Daza

%% Initialize COMSOL server and retrieve model
import com.comsol.model.*
import com.comsol.model.util.*

mphstart(2037);
tags = ModelUtil.tags;
if isempty(tags)
    model = mphload('D:\Google Drive\My Docs\UD\Proyecto de Grado\Trabajo\Objetivo 1\Diseño inicial\COMSOL Files\RLM_v18.mph');
else
    model = ModelUtil.model('Model');
end

%% Set parameters
model.param.set('tau',[num2str(x(1)), ' [cm]']);
model.param.set('L',[num2str(x(2)), ' [cm]']);
model.param.set('bs2taus',x(3));
model.param.set('hs',[num2str(x(4)), ' [cm]']);
model.param.set('Im',x(5));
model.param.set('nc',x(6));

%% Perform experiment to measure the thrust, Joule losses and efficiency
model.study('std1').run;
Fx = mphglobal(model,'Fx');
Pj = mphglobal(model,'Pj');

%% Compute objective function
f = Fx^2/Pj;

end