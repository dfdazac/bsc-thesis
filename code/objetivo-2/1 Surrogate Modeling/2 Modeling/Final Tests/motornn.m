function Y = motornn(X)
%MOTORNN neural network simulation of the objective function of a linear 
%motor design.
%
% Generated by Neural Network Toolbox function genFunction, 22-Feb-2016 23:32:04.
% Modified by Daniel F. Daza.
% 
% Y = motornn(X) takes these arguments:
% 
%   X = 6xN matrix, 6 unscaled inputs of N samples. The inputs should be
%   specified in the following order, according to the following
%   constraints (taken from the SUMO simulator configuration file):
%
%   "...
%   <InputParameters>
%		<"tau"      minimum="5.00" maximum="12.00"/>
%		<"L"        minimum="5.00" maximum="14.00"/>
%		<"bs2taus"  minimum="0.40" maximum="0.700"/>
%		<"hs"       minimum="2.00" maximum="4.000"/>
%		<"Im"       minimum="1.00" maximum="5.000"/>
%		<"nc"       minimum="25.0" maximum="100.0"/>
%	</InputParameters>
%   ..."
% 
% and returns:
%   Y = 1xN cell of 1 outputs over N samples.

%% Scale variables
Q = size(X, 2);
sub = [8.50e+00; 9.50e+00; 5.50e-01; 3.00e+00; 3.00e+00; 6.25e+01];
div = [3.50e+00; 4.50e+00; 1.50e-01; 1.00e+00; 2.00e+00; 3.75e+01];
X = (X - repmat(sub, 1, Q))./repmat(div, 1, Q);

%% Neural network constants
% Layer 1
b1 = [-1.4937817213833227;-1.9852364568646554;-1.273051899449918;2.501054764303579;0.73225781966271941;-0.79122926056236165;-0.29801100083726517;-2.1759050238756781;1.3633123775793135;0.24345134387157608;-2.1287779699943776;0.42953126529082325;-0.3383844341472268];
IW1_1 = [0.10593694812513414 -0.0043164999450575588 0.023603176603065566 0.11899117870525168 -1.4414233324416301 -0.15889793680255548;-3.0223151321086763 -0.0043289667485872001 0.049962495762576574 -0.0050663375242019559 0.030350389378272117 0.018302802180185766;0.98991489302476854 0.061098275900892111 0.17973708654875739 -0.043106843906306466 -0.4775516218184413 -0.42907771780042808;1.1183895554350336 -0.067710236932213355 0.35118252647616455 0.33722627552071527 -1.5969026999435709 -1.3968177648598661;-2.6090316526054322 -0.0055848070114658428 -0.0097330875940584791 0.051689929285945464 -0.10779123499116115 -0.11507158189313674;-0.65575612740135958 -0.059804738530434227 0.074380374676978292 0.28034605702150472 -0.37757504363021149 -0.32588913229214994;-0.075170142625794717 0.0043668719872701463 0.16664512501131518 0.089505918025452741 0.056345803808249321 0.050255357137604748;0.12996168069464381 -0.80546917059099088 0.090326728324536906 0.11407822688678415 0.094497851179632955 0.083455252462387844;-0.12330830057378526 0.0050541237798173407 -0.039969001178640481 -0.13051991147878875 0.2140325737156267 1.3374633981325248;0.14412948097248526 -0.0020727924319562038 -0.33129746612221239 0.10211277341200906 0.037685993842245975 0.033364842814246086;-0.57145409757037879 -0.034735705558613356 1.2543392342072346 0.05110613869184441 0.21969545139725533 0.20429232044063791;-1.0281327943574108 -0.0052067423771045085 -0.071575801358295235 0.044394975031392211 -0.23329860864981547 -0.21980848718383342;0.23647884585680773 -0.0093595833389146614 -0.051887456566636646 -0.052754866684022579 0.67189342644600125 0.60020902916568453];

% Layer 2
b2 = [0.35421729925342821;2.388974287278975;0.91095439151328983;0.23015487068850232;1.7706381193540164;0.036274672805923378;-2.7098177250554083;-0.149393319043609;-3.1549507185246615;0.0028055116744708205;-2.3603581405439842;4.7147291754616756;-3.1517519981366036;-0.82880436704904004];
LW2_1 = [-2.346229734794222 0.42812528945559269 0.015073612439110793 0.39733271256818004 0.30176570131509767 -0.78463581662880688 0.1013550582851613 -1.1279838880223341 -1.1514954362651073 0.88674210330741055 1.3036705440767598 -0.5369379758890821 -1.8113988065771065;0.99177477992324525 -0.34893929064537371 2.6495964474136033 -0.21307670473547699 -0.37646212592135853 0.93005621448765075 -4.250644479132534 -3.3435095574481388 -0.87103578034590978 -2.1620449361683396 0.8229314682576182 1.2999064075852731 1.3034152427456605;0.98388223492674365 0.28222964649346016 0.053195923175228151 -0.15710256522530741 0.21894108119180725 -0.41245892142396712 0.42270274214695441 -1.1299134554438353 2.4547312958170946 0.85671111195563932 1.1416305967176217 -0.72103963880947586 -2.0848668002837734;1.7239757038291572 0.0053400291120142889 -0.10230246108430502 0.22891508821769385 0.48949365565855346 -0.045570538473963369 -1.8480881767749893 -0.31173523100463763 -1.3633213550110355 -1.1954088190222962 -1.2236456450564048 -1.05764166418685 0.050124905815023199;1.7124528542650184 0.51280336989113329 -1.1865250829643263 -0.40994927252726371 2.5004715909292994 -0.69181542758092329 -2.7664536838451079 0.094881628596937939 -1.5627178483049446 1.6941234338178373 -0.39007730105957938 -6.4628511907141295 -3.0749290731003613;-0.18629408410653767 -0.06920247658536352 -0.77043926320772504 -0.19008961726519608 -0.136953396349203 -0.35622300153394776 2.8139607208344759 1.2042943174169918 0.17492558986291823 0.66891310967858875 -0.81311200758521041 -0.37139411532883149 -0.073950187165143733;-0.31848736249134296 1.550750651419351 2.821776141568737 1.8612488674348693 -0.26005086644217867 -5.3004713614291994 4.254698813676093 4.2970481061194938 0.54212286864165404 1.7372387761941994 -2.1648138948144888 1.96201226005087 2.0905223458227304;-0.10717197137019702 2.8201045462674585 -1.213845639634392 0.25174221294461813 0.21692465557326709 1.1278421831854542 -2.1304788273444868 -1.6242636066693836 0.062625062293573105 -1.3884140694000269 -0.39635838123772033 -0.86433414379517259 0.46240340764261245;-0.94299694300448722 -0.015545741393065624 -0.56475312364739416 -0.37632027740928747 -0.51825790096398416 -0.22520660054834993 -1.1203235282793123 -0.67504654966036393 0.74462587427549121 0.17415413664228219 0.06820467504169439 0.75725867119188761 0.062620282768592092;1.3296728866632219 0.072074321293181531 -0.32867057760769497 0.070774354779104889 0.98216691840492276 0.02250458879236528 -3.7099654748858688 -1.8090203716219797 -1.1577715649137104 -0.04470108968711111 0.55489625093643513 -2.6480393563210929 -1.1163565388714789;0.27699245486798513 -3.0896755676144485 0.29252918584559007 -0.80230935368823986 0.0010241851903190933 -0.67539362894651767 0.43011820539239526 -0.38587148335271454 -0.17177468246842234 0.65501633717668428 0.70667156432536793 -0.24252695676444819 -1.2790138962145496;1.568636260146907 -0.35634491386364514 2.3770107923119608 0.066847032036523188 -0.3430674956021092 2.2377373290069227 -4.0802149217385368 -2.3732613731802239 -1.143337590856546 -1.8628047258712805 1.5562641936925654 2.5462346785978398 2.0398493632842896;-1.7993438197277465 1.3633976495011442 1.58480559284503 0.29796223410093814 3.2348966821374141 1.2211212488099052 -0.73726930249689415 -0.90510331591552884 1.3982440745543971 0.4030902936305315 1.3319253096337387 -1.2515598991740515 2.0012532413097182;-0.43381786726202837 2.1973424632540555 0.43615577914521547 0.18130537125193857 2.189660603347392 -0.30414876132278451 3.246148659919077 1.9967244913764659 0.37345433012911428 0.92182895506520202 -0.89115489156079453 -2.6072109900185327 -0.32967028489084604];

% Layer 3
b3 = 5.0693281586485144;
LW3_2 = [7.527585029046076 -7.3560606117179841 7.2121694725291734 -6.5405672922693103 4.5696802339553253 11.548192485530096 7.6151315239413879 -5.1491737334640799 -9.2860909449876932 -8.1637764830600599 -5.6492005579701443 -6.2823785773720067 -3.6166635076857245 -10.33869930064521];
  
%% Neural Network Simulation
% Layer 1
a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*X);
% Layer 2
a2 = tansig_apply(repmat(b2,1,Q) + LW2_1*a1);
% Output layer
Y = repmat(b3,1,Q) + LW3_2*a2;
end

%% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n)
  a = 2 ./ (1 + exp(-2*n)) - 1;
end