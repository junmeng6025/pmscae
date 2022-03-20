close all; clear; clc;
%% Task 1 / Data Import and Preprocessing (1 Point)
load('carbig.mat')

cyl4 = strtrim(convertCharsToStrings(cellstr(cyl4)));
Mfg = strtrim(convertCharsToStrings(cellstr(Mfg)));
Model = strtrim(convertCharsToStrings(cellstr(Model)));
org = strtrim(convertCharsToStrings(cellstr(org)));
Origin = strtrim(convertCharsToStrings(cellstr(Origin)));
when = strtrim(convertCharsToStrings(cellstr(when)));

%% Task 2 / Basics (3 Points)
TabCarbig = table(Acceleration,...
                  cyl4,...
                  Cylinders,...
                  Displacement,...
                  Horsepower,...
                  Mfg,...
                  Model,...
                  Model_Year,...
                  MPG,...
                  org,...
                  Origin,...
                  Weight,...
                  when);

% Find the Mfg and models of all cars that share the minimum power.
minHP = min(Horsepower);
TabMinHP = groupfilter(TabCarbig, 'Model', @(x) all(x == minHP), 'Horsepower');
fprintf('Cars of minimum power (of %dHP):\n', minHP)
disp(TabMinHP)

% Calculate the median weights by manufacturer.
TabMedWeight = groupsummary(TabCarbig,"Mfg","median","Weight");
fprintf('Median weights by manufacturer:\n')
disp(TabMedWeight)

%% Task 3 / Boxplots (2 Points)
dsa_MPG = TabCarbig(:, {'Mfg', 'Model', 'MPG'});
dsa_MPG_vw = dsa_MPG(strcmp(dsa_MPG.Mfg, 'volkswagen'), :);
dsa_MPG_toyota = dsa_MPG(strcmp(dsa_MPG.Mfg, 'toyota'), :);
dsa_MPG_cmp = vertcat(dsa_MPG_vw, dsa_MPG_toyota);

figure('Name', 'Comparision MPG Volkswagen and Toyota')
boxplot(dsa_MPG_cmp.MPG, dsa_MPG_cmp.Mfg)
title('Comparision MPG Volkswagen and Toyota')

%% Task 4 / Distribution Fitting (2 Points)
% Fit normal and weibull distribution to MPG
pd_MPG_n = fitdist(MPG, 'Normal');
pd_MPG_w = fitdist(MPG, 'Weibull');

figure('Name', 'Distribution Plot of MPG')
x_mpg = min(MPG): 1: max(MPG);
y_mpg_n = pdf(pd_MPG_n, x_mpg);
y_mpg_w = pdf(pd_MPG_w, x_mpg);

plot(x_mpg, y_mpg_n, 'LineWidth',2)
hold on
plot(x_mpg, y_mpg_w,'Color','r','LineStyle',':','LineWidth',2)

title('Distribution Plot of MPG')
legend('normal', 'weibull','Location','NorthEast')

% Determine programmatically which fits the data better
nll_n = negloglik(pd_MPG_n);
% nll_n = 1.3826e+03
nll_w = negloglik(pd_MPG_w);
% nll_w = 1.3786e+03