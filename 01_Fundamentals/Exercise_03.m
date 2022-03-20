clear; close all; clc;
%% ========================================================================
%  SubTask 1
%  ------------------------------------------------------------------------
prompt = 'Please select the calculation mode (sum/ factotial/ fibonacci): >>';
cal_mode = input(prompt, 's');
if strcmp(cal_mode, "sum")
    disp('Calcualte the sum of all integers from 1 to n.');
elseif strcmp(cal_mode, "factorial")
    disp('Calculate the factorial of n.');
elseif strcmp(cal_mode, "fibonacci")
    disp('Calcualte the nth element of the fibonacci series.');
else
    disp('Sorry, this calcualtion is not referred.');
end

%% ========================================================================
%  SubTask 2
%  ------------------------------------------------------------------------
switch cal_mode
    case 'sum'
        desp = 'Calcualte the sum of all integers from 1 to n.';
    case 'factorial'
        desp = 'Calculate the factorial of n.';
    case 'fibonacci'
        desp = 'Calcualte the nth element of the fibonacci series.';
    otherwise
        desp = 'Sorry, this calcualtion is not referred.';
end
disp(desp)

%% ========================================================================
%  SubTask 3
%  ------------------------------------------------------------------------
n = input('Please enter n: >>');
s = 0;
for i = (1: n)
    s = s + i;
end
message1 = ['The sum from 1 to', num2str(n), ' is ', num2str(s),'.'];
disp(message1)

%% ========================================================================
%  SubTask 4
%  ------------------------------------------------------------------------
k = 1;
fact = 1;
while k < n
    k = k + 1;
    fact = fact * k;
end
message2 = sprintf('The factorial from 1 to %d is %d.', n, fact);
disp(message2)

%% ========================================================================
%  SubTask 5
%  ------------------------------------------------------------------------
a = 0;
b = 1;
if n <= 0
    disp('n must be a positive int.')
elseif n < 2
    c = 1;
    fprintf('The %dth number of fibinacci serie is %d.\n', n, c)
else
    for j = (1: n-1)
        c = a + b;
        a = b;
        b = c;
    end
    fprintf('The %dth number of fibinacci serie is %d.\n', n, c)
end

%% ========================================================================
%  SubTask 6
%  ------------------------------------------------------------------------
% take fibonacci serie as example
% abort the calcualtion when time reaches what was set.
m = input('Which element in fibonacci serie do you want?>>');
clock = input('Set a clock(ms) to abort the calculation:>>');
Flag = true; % indicates if calculation finishes.
tStart = tic;
u = 0;
v = 1;
if m <= 0
    disp('n must be a positive int.')
elseif m < 2
    v = 1;
    fprintf('The %dth number of fibinacci serie is %d.\n', m, v)
else
    for j = (1: m-1)
        w = u + v;
        u = v;
        v = w;
        tEnd = toc(tStart);
        if tEnd >= clock/1000
            fprintf('It has spent %dms,',clock)
            fprintf('ends at the %dth iteration.',j) 
            fprintf('The current result is %d.\n',v)
            Flag = false;
            break
        end
    end
    if Flag
        fprintf('The %dth number of fibinacci serie is %d.\n', m, v)
        fprintf('Time spent %dms.\n',tEnd*1000)
    end
end
return