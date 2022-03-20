clear; close all; clc;
%% ========================================================================
%  SubTask 1
%  ------------------------------------------------------------------------
numFilt = [5, 4, 3, 2, 1];
denFilt = 15;
H = filt(numFilt, denFilt, 1/50);
%  sample time: 0.02
%  order: 4
%  #################### PROBLEM ####################
%  what means "use the function tf"? like this?
z = tf('z', 1/50);
H_tf = (z^-4 + 2*z^-3 + 3*z^-2 + 4*z^-1 + 5)/15;

%% ========================================================================
%  SubTask 2: upsample
%  ------------------------------------------------------------------------
%  y = upsample(x,n)
%  increases the sample rate of a sequence by a factor of n.
%  increases the sample rate of x by inserting n – 1 zeros between samples.
H_us = upsample(H, 2);
%  sample time: 0.01
%  order: 8
%  increases model order

%% ========================================================================
%  SubTask 3: resample
%  ------------------------------------------------------------------------
%  y = d2d(x,Ts) 
%  H: sample rate 50Hz; H_rs: sample rate 100Hz
H_rs = d2d(H, 1/100, 'tustin');
%  sample time: 0.01
%  order: 4

%% ========================================================================
%  SubTask 4: 3 separate figures
%  ------------------------------------------------------------------------
figure('Name','Step response H')
step(H)
title('Step response H')
xlim([0 0.25])
ylim([0 1.1])

figure('Name','Step response H_us')
step(H_us)
title('Step response H-us')
xlim([0 0.25])
ylim([0 1.1])

figure('Name','Step response H_rs')
step(H_rs)
title('Step response H-rs')
xlim([0 0.25])
ylim([0 1.1])

%  ANSWER: H and H_us have the same step response
%% ========================================================================
%  SubTask 5
%  ------------------------------------------------------------------------
poles = [-10, -3, -1, -1];
Y = zpk([], poles, 1);
%% ========================================================================
%  SubTask 6
%  ------------------------------------------------------------------------
[Yb, g] = balreal(Y);
%% ========================================================================
%  SubTask 7
%  ------------------------------------------------------------------------
order_desired = order(Y) - 2;
Yr = balred(Yb, order_desired);
%% ========================================================================
%  SubTask 8
%  ------------------------------------------------------------------------
figure('Name', 'Step response Y and Yr')
step(Y)
hold on
step(Yr)
grid on
title('Step response Y and Yr')
legend('Y','Yr')
%% ========================================================================
%  SubTask 9
%  ------------------------------------------------------------------------
[Ys, Yf] = freqsep(Y, 2);
%% ========================================================================
%  SubTask 10
%  ------------------------------------------------------------------------
figure('Name', 'Step response Ys, Yf and Ys+Yf')
step(Y,'o');
hold on
step(Ys)
hold on
step(Yf)
hold on
step(Ys+Yf,'m')
grid on
title('Step response Ys, Yf and Ys+Yf')
legend('Y','Ys','Yf','Ys+Yf')