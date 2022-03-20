clear; clc;
% linearize the SimMechanic model
linsys = linearize('inv_pend');
% calcualte the gains of the controller
K = place(linsys.a, linsys.b, [-6, -6.01, -6.02, -6.03]);
save('K.mat', 'K');
% calculate the feedforward control
c = [1 0 0 0];
prec = ((c*(linsys.b * K - linsys.a)^-1) * linsys.b)^-1;
save('prec.mat','prec');