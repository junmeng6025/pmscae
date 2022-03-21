clear; close all; clc;
%% Task 1 / Implementation of the Himmelblau Function (2 Points)

% See <himmelblau.m>

%% Task 2 / Visualization (2 Points)
%  use 'linspace()' as input:
% X1 = linspace(-5, 5);
% X2 = linspace(-5, 5);

%  use 'ndgrid()' as input: (as advised in tutorial)
[X1, X2] = ndgrid(-5: 0.1: 5);

hb = himmelblau(X1, X2);
figure('Name', 'Contour')
contour(X1, X2, hb, 25)
ax_con = gca;

figure('Name', 'Surface')
surf(X1, X2, hb, 'EdgeColor', 'None')
ax_sur = gca;

%% Task 3 / Unconstrained Optimization (2 Points)
fun_opt = @(x) himmelblau(x(1), x(2));

% running optimization
x1 = [-3, 3];
x_opt1 = fminunc(fun_opt, x1);

x2 = [-2, 2];
x_opt2 = fminunc(fun_opt, x2);

x3 = [3, 1];
x_opt3 = fminunc(fun_opt, x3);

x4 = [3, -2];
x_opt4 = fminunc(fun_opt, x4);

% adding labels
X_opt = [x_opt1, fun_opt(x_opt1);...
         x_opt2, fun_opt(x_opt2);...
         x_opt3, fun_opt(x_opt3);...
         x_opt4, fun_opt(x_opt4)];
labels = {'\bulletx_{opt1}',...
          '\bulletx_{opt2}',...
          '\bulletx_{opt3}',...
          '\bulletx_{opt4}'};    
text(ax_con, X_opt(:,1), X_opt(:,2), labels)
text(ax_sur, X_opt(:,1), X_opt(:,2), X_opt(:,3), labels)

%% Task 4 / Constrained Optimization (2 Points)
A = [];
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];
c = @(x) ((x(1) - 5) / 2).^2 + (x(2) - 4).^2 - 1;
ceq = [];
nonlcon = @(x)deal(c(x), ceq);
x_opt_con = fmincon(fun_opt, [0, 0], A, b, Aeq, beq, lb ,ub, nonlcon);

% adding label
text(ax_con, x_opt_con(1), x_opt_con(2), '\bulletx_{opt,nlcon}')
text(ax_sur, x_opt_con(1), x_opt_con(2), fun_opt(x_opt_con),...
     '\bulletx_{opt,nlcon}')

%% Task 5 / Finding the Local Maximum (1 Point)
% maximum of himmelblau is the minimum of the -himmelblau
fun_locmax = @(x) -himmelblau(x(1), x(2));
x_locmax = fminunc(fun_locmax, [-2, 2]);

% adding label
text(ax_con, x_locmax(1), x_locmax(2), '\bulletx_{locmax}')
text(ax_sur, x_locmax(1), x_locmax(2), fun_opt(x_locmax),...
     '\bulletx_{locmax}')
