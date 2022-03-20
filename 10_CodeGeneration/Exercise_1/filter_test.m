% Generate a noisy signal
v = linspace(0,2*pi,1e6);
x = sin(v) + 0.3*rand(1,numel(v));

disp('M-file:')
tic
% Filter the signal using the M-file
y1 = averaging_filter(x);
% Display time elapsed since last "tic"
toc

disp('MEX-file:')
tic
% Filter the signal using the MEX-file
y2 = averaging_filter_mex(x);
% Display time elapsed since last "tic"
toc