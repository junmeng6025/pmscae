clear; close all; clc;
%% ========================================================================
%  SubTask 1
%  ------------------------------------------------------------------------
%  zero-pole-gain model
zero = 18;
pole = [-3 + 2i, -3 - 2i];
gain = 4 / 2225;
F = zpk(zero, pole, gain);

%% ========================================================================
%  SubTask 2
%  ------------------------------------------------------------------------
%  transfer function model
num = [-4/2225, 23*4/2225];
den = [1, 1, 4.25];
G = tf(num, den, 'InputDelay', 0.05);

%% ========================================================================
%  SubTask 3
%  ------------------------------------------------------------------------
%  transform model G to zero-pole-gain form G_zpk
G_zpk = zpk(G);
display(G_zpk)
%  ANSWER: numerator of G_zpk: -0.0017978 (s-23)

%% ========================================================================
%  SubTask 4
%  ------------------------------------------------------------------------
%  connect F and G parallel to assemble model E
%G = ss(G);
%F = ss(F);
E = parallel(G, F, 1, 1, [1 1], [1 1]);
%  OR:
%  create Fnew: has two outputs that are same as each other. 
%  one will be added to the output of G
%  the other will be retained as the output of the system
%Fnew = [F; F];
%E = parallel(Fnew, G, 1, 1, 2, 1);

%  with help from MathWorks forum
%  https://de.mathworks.com/matlabcentral/answers/1591984-how-to-build-a-control-system-with-one-input-and-multiple-outputs?s_tid=mlc_ans_email_view#answer_836849

%% ========================================================================
%  SubTask 5
%  ------------------------------------------------------------------------
%  PID controller C
Kp = 3.16;
Ki = 15.9;
Kd = 0.156;
C = pid(Kp, Ki, Kd);

%% ========================================================================
%  SubTask 6
%  ------------------------------------------------------------------------
%  closed_loop: connect C and E series with feedback
closed_loop = feedback(C*E, 1, 1, 2, -1);
%  #################### PROBLEM ####################
%  don't know how to deal with 2 outputs from F
display(closed_loop)
%% ========================================================================
%  SubTask 7
%  ------------------------------------------------------------------------
NS_EntireSys = order(closed_loop);
display(NS_EntireSys)
%  ANSWER: the order of the entire system: 7

%% ========================================================================
%  SubTask 8
%  ------------------------------------------------------------------------
%  Is the transfer from input 1 to output 2 of the mode closed_loop proper?
%  ANSWER: 