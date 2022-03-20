clear; close all; clc;
%% ========================================================================
%  SubTask 1
%  ------------------------------------------------------------------------
syms x
f(x) = 27*x*log(x+3)+cos(2^x);
F = int(f, x, [-1 1]);
F_num = double(F);

fprintf('Subtask1\nIntegration [-1 1]:\n')
disp(F_num)
%  ANSWER: 7.0068

%% ========================================================================
%  SubTask 2
%  ------------------------------------------------------------------------
syms y z
g = (z/y)*tan(y*z)+(1/y^2)*log(cos(y*z));

dg_dz = diff(g, z);
fprintf('Subtask2\ndg_dz:\n')
disp(dg_dz)

dg_dz_simp = simplify(dg_dz);
fprintf('dg_dz simplified:\n')
disp(dg_dz_simp)
%  ANSWER: dg/dz = -z/(sin(y*z)^2 - 1)

%% ========================================================================
%  SubTask 3
%  ------------------------------------------------------------------------
syms x y z alpha
vector_field = [alpha*z/x, z/y, log(x*y)]';
rotation = curl(vector_field);

fprintf('Subtask3\nRotation of Vector Field:\n')
disp(rotation)
%  ANSWER: rotation in (x, y, z):
%                                0
%  conj(alpha)/conj(x) - 1/conj(x)
%                                0

%% ========================================================================
%  SubTask 4
%  ------------------------------------------------------------------------
syms s alpha
Lf = 1/sqrt(s+alpha);
inv_Lf = ilaplace(Lf, s);

fprintf('Subtask4\nInverse Laplace Transform:\n')
disp(inv_Lf)
%  ANSWER: exp(-alpha*s)/(s^(1/2)*pi^(1/2))

%% ========================================================================
%  SubTask 5
%  ------------------------------------------------------------------------
syms x
h(x) = exp(x);
T(x) = taylor(h, 'Order', 2);
taylortool(h)
%  ANSWER: T_2(x) = x + x^2/2 + 1
%  T_2(1) = 2.5

%  Question:
%  Why do I obtain T(x) = x + 1 from command "T(x) = taylor(h, 'Order', 2)"
%  But in taylortool it comes "T_2(x) = x + x^2/2 + 1" when N set as 2
