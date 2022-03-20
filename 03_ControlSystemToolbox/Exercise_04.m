clear; close all; clc;
%% ========================================================================
%  SubTask 1
%  ------------------------------------------------------------------------
G = tf(1, [0.25, 1, 1]);

%% ========================================================================
%  SubTask 2
%  ------------------------------------------------------------------------
controller = pidtune(G, 'pid', 2.5);
[Gm, Pm, Wcg, Wcp] = margin(G);
%  ANSWER: 
%  phase margin = 180

%% ========================================================================
%  SubTask 3
%  Open the PID Tuner
%  response time set to 0.1s
%  transient behavior as aggressive as possible,
%  ... without exceeding 10% overshoot.
%  ------------------------------------------------------------------------
pidTuner(G,'pid')
%  ANSWER:
%  transient behavior = 0.636
%  overshoot = 10%
%  Kp = 38.6047
%  Ki = 76.6898
%  Kd = 4.8583

%% ========================================================================
%  SubTask 4
%  Open the SISO Design Tool with the model G.
%  ------------------------------------------------------------------------
controlSystemDesigner(G)

%% ========================================================================
%  SubTask 5
%  Choose the third control architecture,
%  with a feedforward controller F parallel to the feedback controller C.
%  ------------------------------------------------------------------------

%% ========================================================================
%  SubTask 6
%  In the feedback controller C, place a pole at -6 and a zero at -1
%  ------------------------------------------------------------------------

%% ========================================================================
%  SubTask 7
%  Increase the gain until reaching a phase margin of 60°.
%  ------------------------------------------------------------------------
%  ANSWER:
%  gain = 3.275 
%      19.65 (s+1)
%  C = -----------
%         (s+6)
%% ========================================================================
%  SubTask 8
%  Let F be a simple gain with a value of 0.3.
%  ------------------------------------------------------------------------

%% ========================================================================
%  SubTask 9
%  Create a step response analysis plot of the closed loop
%  determine the time of the peak amplitude.
%  ------------------------------------------------------------------------
%  export "IOTransfer_r2y" from Control System Designer
%  step(IOTransfer_r2y)

%  ANSWER:
%  peak amplitude  0.991
%  overshoot       18.5%
%  peak time       0.36s
%% ========================================================================
%  SubTask 10
%  
%  ------------------------------------------------------------------------