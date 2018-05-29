%% DesignScript.m
% Author: Daniel F. Daza
% This file provides a script to be used when obtaining the parameters of
% the initial design, based on the design methodology proposed by Boldea.

%% Prepare
clc, clear, close all;

%% Constants and design definitions
% Vacuum magnetic permeability
mu0 = 1.256637061e-6;
% Resistivity of copper
rhoc = 2.3e-8;
% Number of phases
m = 3;
% Peak thrust (N)
Fxmax = 150;
% Continuous duty thrust (N)
Fx = 80;
% Continuous duty speed (m/s)
U = 2;

%% Enter pole pitch and airgap distance in meters
tau = 6e-2;
g = 0.5e-3;

%% Enter Kdm and Kqm saliency coefficients values from the curves
Kdm = 0.98;
Kqm = 0.08;
% Compute the ratio
KdmpKqm = Kdm/Kqm;
%disp(['Kqm/Kqm = ' num2str(KdmpKqm)]);

%% Enter a d-axis saturation factor
Ksd = 0.1;
% Compute the saturated d-axis saliency coefficient
Kdms = Kdm/(1+Ksd);
%disp(['Kdms = ' num2str(Kdms)]);

%% Enter the leakage to magnetizing inductance ratio Ll/Lm
LlpLm = 0.1;

% Compute the Ld/Lq ratio
LdpLq = (LlpLm + Kdms)/(LlpLm + Kqm);
%disp(['Ld/Lq = ' num2str(LdpLq)]);

%% Enter the peak value of the resultant airgap flux density
Bg1k = 0.4;
% Compute the d-axis peak flux density
Bd1p = Bg1k/sqrt(1 + (LdpLq)^2*(Kqm*(1+Ksd)/Kdm)^2);
%disp(['Bd1p = ' num2str(Bd1p) ' T']);

%% Enter the Carter coefficient Kc, the number of slots/pole/phase q and
% the coil pitch/pole pitch ratio yptau.
Kc = 1.3;
q = 2;
yptau = 5/6;
% Therefore, the coil pitch is
y = yptau*tau;

% Compute the winding factor
% Distribution factor
Kd = sin(pi/6)/(q*sin(pi/(6*q)));
%disp(['Kd = ' num2str(Kd)]);
% Pitch factor
Kp = sin(yptau*pi/2);
%disp(['Kp = ' num2str(Kp)]);
% Winding factor
Kw = Kd*Kp;
%disp(['Kw = ' num2str(Kw)]);

% Compute the peak mmf in the d-axis
W1Id = (pi*g*Kc*Bd1p*(1+Ksd))/(mu0*3*sqrt(2)*Kdm*Kw);
%disp(['W1Id = ' num2str(W1Id) 'p' ' A*turns']);
% Compute the peak mmf in the q-axis
W1Iq = W1Id*LdpLq;
%disp(['W1Iq = ' num2str(W1Iq) 'p' ' A*turns']);

% Compute the armature effective length-poles product Lp
Lp = (Fxmax*pi*Kc*g)/(18*mu0*(Kdm/(1+Ksd)-Kqm)*Kw^2*W1Id*W1Iq);
%disp(['Lp = ' num2str(Lp) ' m']);

%% Enter the total number of pole pairs p
p = 2;

% Compute the armature effective length
L = Lp/p;
disp(['Armature width: ' num2str(L*100) ' cm']);
% Compute the armature length
AL = 2*p*tau;
%disp(['Armature length: ' num2str(AL*100) ' cm']);

% Plot armature area
% figure;
% patch([0 Ad Ad 0]*100, [0 0 L L]*100, 'r');
% xlim([0 0.2]*100); ylim([0 0.2]*100);
% title('Armature Area');
% xlabel('cm'); ylabel('cm');

% Compute the peak thrust density (Force/square meters)
fxp = Fxmax/(2*p*tau*L);
%disp(['fxp = ' num2str(fxp/10000) ' N/cm^2']);

% Compute the slot peak mmf
n1Isp = W1Id*sqrt(1+LdpLq^2)/q;
%disp(['n1Isp = ' num2str(n1Isp) ' A*turns/slot']);

% Compute the average peak slot mmf
% Max thrust to continuous duty factor
C = Fx/Fxmax;
n1Iav = n1Isp*sqrt(C);
%disp(['n1Iav = ' num2str(n1Iav) ' A*turns/slot']);

% Compute the slot pitch
taus = tau/(3*q);
disp(['taus = ' num2str(taus*1000) ' mm']);

% Stator geometry
bs = 3*taus/4;
disp(['bs = ' num2str(bs*1000) ' mm']);
hs = 3*bs;
disp(['hs = ' num2str(hs*1000) ' mm']);
As = bs*hs;
disp(['As = ' num2str(As*1e6) ' mm^2']);

%% Enter ha (teeth height) and teeh separation
ha = 1e-3;
Dso = 1e-3;

%% Enter fill factor
Kfill = 0.5;
% Slot average current density
Jav = n1Iav/(Kfill*As);
%disp(['Jav = ' num2str(Jav/1e6) ' A/mm^2']);

% Stator back iron (core) flux density
Bcp = 2*Bg1k;
% Stator back iron height
hc = (Bg1k/Bcp)*tau/pi;
disp(['hc = ' num2str(hc*1000) ' mm']);

% Number of slots in the stator
z0 = 2*p*m*q;
z = (2*p + yptau)*z0/(2*p);
disp(['Number of slots = ' num2str(z) ' slots']);

% Final length of the armature core
Lpf = taus/2 + (z-1)*taus + taus/2;
disp(['Final armature length = ' num2str(Lpf*100) ' cm']);

% Primary resistance to W1^2 ratio
R1pW12 = 2*rhoc*(L + 0.01 + 1.5*tau*yptau)/(p*q*n1Iav/Jav);
%disp(['R1 = ' num2str(R1pW12) ' W1^2']);

% Unsaturated uniform-airgap inductance to W1^2 ratio
LmpW12 = (6*mu0*Kw^2*tau*L)/(pi^2*p*Kc*g);
%disp(['LmpW12 = ' num2str(LmpW12) ' W1^2']);

% Direct and quadrature axis inductances to W1^2 ratio
LdmpW12 = LmpW12 * Kdm/(1+ Ksd);
LqmpW12 = LmpW12 * Kqm;
%disp(['Ldm = ' num2str(LdmpW12) ' W1^2']);
%disp(['Lqm = ' num2str(LqmpW12) ' W1^2']);

% Slot permeance and end-connection permeance
lambdasl = hs/(3*bs)+ha/Dso;
lambdae = 0.3*q*(3*yptau-1);

% End-connection length
Lec = 0.01+1.5*y;

% Leakage inductance to W1^2 ratio
LleakpW12 = 2*mu0*(lambdasl*L + lambdae*Lec)/(p*q);
%disp(['Lleak = ' num2str(LleakpW12) ' W1^2']);

% New leakage to magnetizing inductance ratio Ll/Lm
NLlpLm = LleakpW12/LmpW12;
disp(['Obtained NLlpLm = ' num2str(NLlpLm)]);

% Ld to W12 and Lq to W12
LdpW12 = LdmpW12 + LleakpW12;
LqpW12 = LqmpW12 + LleakpW12;

% New Ld/Lq ratio
NLdpLq = LdpW12/LqpW12;
disp(['Obtained Ld/Lq = ' num2str(NLdpLq)]);

% Id/Iq ratio at maximum power factor
IdpIq = sqrt(NLdpLq);

% Rated direct and quadrature mmfs
RW1Id = W1Id*p*sqrt((Fx*NLdpLq)/(Fxmax*IdpIq));
RW1Iq = IdpIq*RW1Id;
%disp(['RW1Id = ' num2str(RW1Id)]);
%disp(['RW1Iq = ' num2str(RW1Iq)]);

% Steady-state line frequency
wr = U*pi/tau;
% Vd to W1 ratio and Vq to W1 ratio
VdpW1 = (wr*LqpW12*RW1Iq - R1pW12*RW1Id);
VqpW1 = (wr*LdpW12*RW1Id + R1pW12*RW1Iq);

%% Enter modulation factor for the PWM inverter and DC input voltage
Kv0 = 0.85;
V0 = 100;

% RMS value of inverter phase voltage
Vp = 4*Kv0*V0/(sqrt(6)*pi);

% Number of turns per phase (real number)
W1r = Vp/sqrt(VdpW1^2 + VqpW1^2);
% Number of turns per slot
n1 = W1r/(p*q);
% Number of turns per coil (double layer winding)
nc = ceil(W1r/(2*p*q));
% Number of turns per phase (integer)
W1 = 2*p*q*nc;

disp(['Turns per phase = ' num2str(W1)]);
disp(['Turns per coil  = ' num2str(nc)]);

% Direct and quadrature phase currents
Idrms = RW1Id/W1;
Iqrms = RW1Iq/W1;
Idrmsp = W1Id*p/W1;
Iqrmsp = W1Iq*p/W1;
% Phase current
Ia = sqrt(Idrms^2 + Iqrms^2);
Iap = sqrt(Idrmsp^2 + Iqrmsp^2);
% Average slot current
Iav = n1Iav/(2*nc);

fprintf('\n');
disp('--------- Continous-duty operating currents:');
disp(['Continuous-duty peak Id = ' num2str(sqrt(2)*Idrms) ' A']);
disp(['Continuous-duty peak Iq = ' num2str(sqrt(2)*Iqrms) ' A']);
disp(['Continuous-duty RMS Ia = ' num2str(Ia) ' A']);
%disp(['Continuous-duty Peak Ia = ' num2str(sqrt(2)*Ia) ' A']);
fprintf('\n');
disp('--------- Peak-duty operating currents:');
disp(['Peak-duty peak Id = ' num2str(sqrt(2)*Idrmsp) ' A']);
disp(['Peak-duty peak Iq = ' num2str(sqrt(2)*Iqrmsp) ' A']);
disp(['Peak-duty RMS Ia = ' num2str(Iap) ' A']);
%disp(['Peak-duty Peak Ia = ' num2str(sqrt(2)*Iap) ' A']);

% Calculated d and q axis inductances
Ld = LdpW12 * W1^2;
Lq = LqpW12 * W1^2;

% Calculated thrust (peak and rated)
Fxcp = 3*pi/(2*tau) * (Ld - Lq) * 2*W1Id*p/W1*W1Iq*p/W1;
Fxcr = 3*pi/(2*tau) * (Ld - Lq) * 2*Idrms*Iqrms;
fprintf('\n');
disp(['--------- Peak thrust: ' num2str(Fxcp) ' N']);
disp(['--------- Rated thrust: ' num2str(Fxcr) ' N']);