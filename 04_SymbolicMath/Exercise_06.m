clear; close all; clc;
%% ========================================================================
%  SubTask 1
%  ------------------------------------------------------------------------
syms wr(t) wl(t) d l_wheels
vr = wr*d/2;
vl = wl*d/2;
v = 1/2*(vl + vr);
w = 1/l_wheels*(vr - vl);

%% ========================================================================
%  SubTask 2
%  ------------------------------------------------------------------------
wl_star = 8*(sin(t))^2;
wr_star = 8*(cos(t))^2;
v_star = subs(v, {wr, wl}, {wr_star, wl_star});
w_star = subs(w, {wr, wl}, {wr_star, wl_star});
%  ANSWER:
%  v_star(t) = 2*d*sin(t)^2 + 2*d*cos(t)^2
%  w_star(t) = -(4*d*sin(t)^2 - 4*d*cos(t)^2)/l_wheels
 
%% ========================================================================
%  SubTask 3
%  ------------------------------------------------------------------------
w_star_para = subs(w_star, {d, l_wheels}, {0.03, 0.1});
assume(t, 'positive')
sol_t = solve(w_star_para == 0, t);
sol_t_digit = vpa(sol_t, 3);
%  ANSWER:
%  t = pi/4 s
%  numeric: t = 0.785s

%% ========================================================================
%  SubTask 4
%  ------------------------------------------------------------------------
syms Psi(t) x(t) y(t)
Psi = dsolve(diff(Psi) == w_star, Psi(0) == 0);
xt = dsolve(diff(x) == v_star*cos(Psi), x(0) == 0);
% , x(0) == 0
yt = dsolve(diff(y) == v_star*sin(Psi), y(0) == 0);
% , y(0) == 0

Psi_para = subs(Psi, {d, l_wheels}, {0.03, 0.1});
x_para = subs(xt, {d, l_wheels}, {0.03, 0.1});
y_para = subs(yt, {d, l_wheels}, {0.03, 0.1});

x_50 = subs(x_para, t, 50);
x_50_num = vpa(x_50)
y_50 = subs(y_para, t, 50);
y_50_num = vpa(y_50)
%  ANSWER:
%  x(50) = 2.7348663817974375393867619619061
%  y(50) = 0.0024587880355567689775287431125268
