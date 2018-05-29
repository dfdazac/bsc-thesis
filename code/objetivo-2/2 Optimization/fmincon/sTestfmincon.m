%% sTestfmincon.m
% Author: Daniel F. Daza
%% Prepare
clc, clear, close all;

%% Convex trivial case
fun = @(x)(x.^2);
lb = -1;
ub = 1;
x0 = 0.3;
xm = fmincon(fun,x0,[],[],[],[],lb,ub);

x = linspace(lb, ub, 100);
figure; hold on;
plot(x, fun(x));
plot(xm, fun(xm), 'r.', 'MarkerSize', 15);

%% Multimodal function
fun = @(x)(x.^2 + 0.5*sin(5*x));
lb = -1;
ub = 1;
x0 = 0.8;
options = optimoptions(@fmincon,'Algorithm','sqp');
xm = fmincon(fun,x0,[],[],[],[],lb,ub,[],options);

x = linspace(lb, ub, 100);
figure; hold on;
plot(x, fun(x));
plot(xm, fun(xm), 'r.', 'MarkerSize', 15);

%% 2D problem
fun = @(x)(x(1).^2 + x(2).^2);
lb = [-1; -1];
ub = [1; 1];
x0 = [0.5; 0.5];
xm = fmincon(fun,x0,[],[],[],[],lb,ub);

x1 = linspace(lb(1), ub(1), 50);
x2 = linspace(lb(2), ub(2), 50);
[X1, X2] = meshgrid(x1, x2);
F = X1.^2 + X2.^2;
figure;
surf(X1, X2, F); hold on;
plot3(xm(1),xm(2),fun(xm),'r.','MarkerSize',20);

%% Multimodal function
fun = @(x)(-sinc(x));
lb = -5;
ub = 5;
x0 = -4;
options = optimoptions(@fmincon,'Algorithm','sqp');
xm = fmincon(fun,x0,[],[],[],[],lb,ub,[],options);

x = linspace(lb, ub, 100);
figure; hold on;
plot(x, fun(x));
plot(xm, fun(xm), 'r.', 'MarkerSize', 15);