clear; close all; clc;
%% ========================================================================
%  SubTask 1
%  ------------------------------------------------------------------------
n = input('For the n_th element in Febonacci serie, please enter the number n:>>');
f = [0, 1];
if n < 0
    disp('ERROR: n must be a non-negative int.')
elseif n < 2
    fprintf('The %dth number of fibinacci serie is %d.\n', n, f(n))
else
    for i = (1: n-1)
        f(3) = f(1) + f(2);
        f(1) = f(2);
        f(2) = f(3);
    end
    fprintf('The %dth number of fibinacci serie is %d.\n', n, f(3))
end

%% ========================================================================
%  SubTask 2
%  ------------------------------------------------------------------------
clear;
clc;
% Definition of the function "Fibo" is at the end of the script.
% involke the function "Fibo":
n = input('For the n_th element in Febonacci serie, please enter the number n:>>');
fibo = Fibo(n);
message = sprintf('The %dth number of fibinacci serie is %d.\n', n, fibo);
disp(message)

%% ========================================================================
%  SubTask 3
%  ------------------------------------------------------------------------
m = input('Enter n to find the n_th element in fibonacci serie.>>');
y = fibonacci_recursive(m);
disp(y)

%% ========================================================================
%  SubTask 4
%  ------------------------------------------------------------------------
% Definition of the function "SphereData" is at the end of the script.
% involke the function "SphereData":
r = input("Please enter the sphere's radius r:>>");
[v, s, c] = SphereData(r);
fprintf('The volume is %d.\n',v)
fprintf('The surface is %d.\n',s)
fprintf('The circumference is %d.\n',c)

%% ========================================================================
%  SubTask 5
%  ------------------------------------------------------------------------
R = input("Please enter the sphere's radius r:>>");
[V, S, C] = SphereData_call(R);
fprintf('The volume is %d.\n',V)
fprintf('The surface is %d.\n',S)
fprintf('The circumference is %d.\n',C)

%% ========================================================================
% Function definition:

% SubTask 2
%  ------------------------------------------------------------------------
function out = Fibo(n)
% returns the n_th element of fibonacci serie.
f = [0, 1];
if n < 0
    disp('ERROR: n must be a non-negative int.')
elseif n < 2
    out = f(n);
else
    for i = (1: n-1)
        f(3) = f(1) + f(2);
        f(1) = f(2);
        f(2) = f(3);
    end
    out = f(3);
end
end

% SubTask 4
%  ------------------------------------------------------------------------
% as nested functions
function [y1, y2, y3] = SphereData(r)
y1 = Volume;
y2 = Surface;
y3 = Circumference;
    function vol = Volume
        vol = (4/3)*pi*r^3;
    end
    function sur = Surface
        sur = 4*pi*r^2;
    end
    function cir = Circumference
        cir = 2*pi*r;
    end
end

% SubTask 5
%  ------------------------------------------------------------------------
% as local function
function vol = Volume(R)
vol = (4/3)*pi*R^3;
end
function sur = Surface(R)
sur = 4*pi*R^2;
end
function cir = Circumference(R)
cir = 2*pi*R;
end
function [o1, o2, o3] = SphereData_call(in)
o1 = Volume(in);
o2 = Surface(in);
o3 = Circumference(in);
end