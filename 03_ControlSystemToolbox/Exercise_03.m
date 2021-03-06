clear; close all; clc;
%% ========================================================================
%  SubTask 1
%  ------------------------------------------------------------------------
w = realp('w', 3);
z = realp('z', 0.9);

%% ========================================================================
%  SubTask 2
%  ------------------------------------------------------------------------
A = [-2*w*z, -w^2; 1, 0];
B = [w^2; 0];
C = [1, 0];
D = 0;
sys = ss(A, B, C, D);
Q = genss(sys);

%% ========================================================================
%  SubTask 3
%  ------------------------------------------------------------------------
Qsample = replaceBlock(Q, 'z', [0.1 0.7 1]);

%% ========================================================================
%  SubTask 4
%  ------------------------------------------------------------------------
figure('Name','Bode diagram of 3 samples of model Q')
bode(Qsample)
grid on
%% ========================================================================
%  SubTask 5
%  ------------------------------------------------------------------------
Q_z1 = replaceBlock(Q, 'z', 1);
figure('Name','Bode diagram of 3 samples of model Q')
pzplot(Q_z1)
[poles, zeros] = pzmap(Q_z1);
grid on
%% ========================================================================
%  SubTask 6
%  ------------------------------------------------------------------------
Q_z07 = replaceBlock(Q, 'z', 0.7);
damp(Q_z07)
%  ANSWER
%         Pole              Damping       Frequency      Time Constant  
%                                       (rad/seconds)      (seconds)    
%                                                                       
% -2.10e+00 + 2.14e+00i     7.00e-01       3.00e+00         4.76e-01    
% -2.10e+00 - 2.14e+00i     7.00e-01       3.00e+00         4.76e-01    
%% ========================================================================
%  SubTask 7
%  ------------------------------------------------------------------------
Q_z01 = replaceBlock(Q, 'z', 0.1);
g_peak = getPeakGain(Q_z01);
g_db = mag2db(g_peak);
%  ANSWER: the peak gain of Q with z=0.1 is 15
%          in decibels: 23.52 dB

%% ========================================================================
%  SubTask 8
%  ------------------------------------------------------------------------
t = 0:40/4000:40;
input = chirp(t,0,5,0.5,'linear',-90);
%  y = chirp(t,f0,t1,f1,method,phi)
%  default: cos
%  phi: specifies the initial phase(deg).
figure('Name','Chirp')
plot(t,input)
title('Chirp signal')
ylim([-1.5 1.5])
grid on

%% ========================================================================
%  SubTask 9
%  ------------------------------------------------------------------------
figure('Name','Response of model Q with z=0.1 with chirp input')
lsim(Q_z01,input,t)
title('Response of model Q with z=0.1 with chirp input')
grid on
%  ANSWER: output at t=22.2s is 0.602