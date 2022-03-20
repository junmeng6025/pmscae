clear; close all; clc;
%% ========================================================================
%  SubTask 1
%  ------------------------------------------------------------------------
Kt = 3.45;
T = 0.001;
i1 = 1/6.5;
i2 = 1/5.6;
d = 0.038;

g1 = tf(1, [T 0]);
closed_loop = feedback(g1, 1);
G_wheel = Kt * closed_loop * i1 * i2 * (d/2);

%% ========================================================================
%  SubTask 2
%  ------------------------------------------------------------------------
%  Initialize a PI-controller C
Kp = 1;
Ki = 1;
C = pid(Kp, Ki);

pidTuner(C,'pi')
%  switch domain into frequency domain, set:
%   bandwidth = 9 rad/s
%   phase margin = 90 deg

%  ANSWER:
%  Kp = 0.10976
%  Ki = 8.8902
