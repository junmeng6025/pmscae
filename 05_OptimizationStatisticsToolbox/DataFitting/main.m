close all; clear; clc;
%% Load and visualize the dataset (2 Points)
load('taskDataset.mat')
figure('Name', 'Scatter3 of point cloud')
scatter3(x, y, z, '.')
xlabel('x')
ylabel('y')
zlabel('z')

%% Prepare a model structure (2 Points)
% See modelFunction.m
p_guess = [3, 0.3, 2, 5, 5, 1];
% test: generate a z_approx based on p_guess
z_approx = modelFunction(x, y, p_guess);

%% Define the residual function (2 Points)
residual = @(p) modelFunction(x, y, p) - z;

%% Fit the model (2 Points)
options = optimoptions(@lsqnonlin,'Algorithm','levenberg-marquardt',...
    'MaxFunctionEvaluations',2000, 'Display', 'iter');
[p_optm, res_norm, res, exitflag] = lsqnonlin(residual, p_guess);

% Check convergence
if exitflag <= 0
    error("Solver did not converge!");
end

%% Visualize the fit (2 Points)
[axx, axy] = ndgrid(0: 0.1: 10);

figure('Name','Point cloud with guessed fitting surface')
scatter3(x, y, z, '.','MarkerEdgeColor', 'r')
hold on
surf(axx, axy, modelFunction(axx, axy, p_guess), 'EdgeColor', 'w')
xlabel('x')
ylabel('y')
zlabel('z')
title('Point cloud with guessed fitting surface')

figure('Name','Point cloud with optimized fitting surface')
scatter3(x, y, z, '.','MarkerEdgeColor', 'c')
hold on
surf(axx, axy, modelFunction(axx, axy, p_optm))
xlabel('x')
ylabel('y')
zlabel('z')
title('Point cloud with optimized fitting surface')