clear; close all; clc;
%% ========================================================================
%  SubTask 1
%  ------------------------------------------------------------------------
%  def of functions seeing in the end of script.
locCounter = 0;
global globalCounter;
for i = 1: 10
    locCounter = CountLoc(locCounter);  % the first loop already increments
    perCounter = CountPer;  % the first loop is to initialize persistentCounter to 0
    CountGlb;               % the first loop is to initialize persistentCounter to 0
end
disp(locCounter)
disp(perCounter)
disp(globalCounter)

% ### conclusion ###

% local variables declared in the first function 'CountLoc'...
% ... like 'out' and 'in' don't appear in the workspace on the right
% the command 'clear' does NOT affect global and persistent variables 
% persistent variables can be cleared by restarting MATLAB
% global variables can be cleared with command 'clear global'
% A global variable must be declared within the function, ...
% ... as well as the script calling the function.

%% ========================================================================
%  SubTask 2
%  ------------------------------------------------------------------------
%  without pre-allocating
tStart01 = tic;
numarray01 = 0;
for a = 1:1000
    numarray01(a) = a^2;
end
tEnd01 = toc(tStart01);
fprintf('Time spent without pre-allocating is %ds.\n',tEnd01);

%  with pre-allocating
tStart02 = tic;
numarray02 = zeros(1000);
for b = 1:1000
    numarray02(b) = b^2;
end
tEnd02 = toc(tStart02);
fprintf('Time spent with pre-allocating is %ds.\n',tEnd02);

%% ========================================================================
%  SubTask 3
%  ------------------------------------------------------------------------
A = magic(20000);   % memory usage jumps obviously, then falls a little
B = A;              % memory usage jumps keeps alomst no change
B(1) = 0;           % memory usage jumps obviously, then keeps high level

%% ========================================================================
%  Functions SubTask 1
%  ------------------------------------------------------------------------
%  Function01: inputs the previous counter value
%              increments it by one and outputs it as the new counter value
%              variables used in this function exist locally in the function’s workspace 
%              and are deleted once the function is terminated.
function out = CountLoc(in)
if isempty(in)
    in = 0;
end
out = in + 1;
end

%  ------------------------------------------------------------------------
%  Function02: no input arguments
%              declares a persistent variable
function nextInc_persistent = CountPer()
persistent persistentCounter
if isempty(persistentCounter)
    persistentCounter = 0;
else
    persistentCounter = persistentCounter + 1;
end
nextInc_persistent = persistentCounter;
end

%  ------------------------------------------------------------------------
%  Function03: neither input nor output arguments
%              declares a global variable within the function
function CountGlb()
global globalCounter
if isempty(globalCounter)
    globalCounter = 0;
else
    globalCounter = globalCounter + 1;
end
end