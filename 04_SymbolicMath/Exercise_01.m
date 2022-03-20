clear; close all; clc;
%% ========================================================================
%  SubTask 1
%  ------------------------------------------------------------------------
syms p q r

%% ========================================================================
%  SubTask 2
%  ------------------------------------------------------------------------
K = log(p^q);

%% ========================================================================
%  SubTask 3
%  ------------------------------------------------------------------------
k = subs(K, q, 0);
disp(k)
%  ANSWER:K=0 for q=0

%% ========================================================================
%  SubTask 4
%  ------------------------------------------------------------------------
L(p, q, r) = (sin(r))^2 + (cos(p+q))^2;

%% ========================================================================
%  SubTask 5
%  ------------------------------------------------------------------------
l = L((r-q), q, r);
disp(l)

%% ========================================================================
%  SubTask 6
%  ------------------------------------------------------------------------
l_simp = simplify(l);
disp(l_simp)