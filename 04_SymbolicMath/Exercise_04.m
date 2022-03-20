clear; close all; clc;
%% ========================================================================
%  SubTask 1
%  ------------------------------------------------------------------------
syms x
eqn_x = abs(exp(x)) == 1;
asm1 = assumptions
sol_x = solve(eqn_x, x)
%  ANSWER: x=0

%% ========================================================================
%  SubTask 2
%  ------------------------------------------------------------------------
assume(x, 'real')
asm2 = assumptions
sol_x_real = solve(eqn_x, x)
%  ANSWER: x=0

%% ========================================================================
%  SubTask 3
%  ------------------------------------------------------------------------
syms a b c
eqn_ab1 = a^2 * b^2 == 0;
eqn_ab2 = a - b/2 == c;
sol_ab = solve(eqn_ab1, eqn_ab2, [a, b]);
solution_a1b1 = [sol_ab.a(1), sol_ab.b(1)]
solution_a2b2 = [sol_ab.a(2), sol_ab.b(2)]
%  ANSWER:
%  solution_a1b1 = [c, 0]
%  solution_a2b2 = [0, -2*c]

%% ========================================================================
%  SubTask 4
%  ------------------------------------------------------------------------
assume(c>1)
assume(b>=0)
sol_ab_st4 = solve(eqn_ab1, eqn_ab2, [a, b]);
%  ANSWER:
%  solution_ab = [c, 0]