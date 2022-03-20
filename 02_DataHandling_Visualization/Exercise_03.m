clear; close all; clc;
%% ========================================================================
%  SubTask 1
%  ------------------------------------------------------------------------
PopDE = importdata('GermanPopulation.mat');
%  the command 'load(fNmae)' loads .mat file as a struct
%  the command 'importdata(fNmae)' can extract the data in .mat file

%% ========================================================================
%  SubTask 2
%  ------------------------------------------------------------------------
figure
plot(PopDE.Year, PopDE.PopulationTotal)

%% ========================================================================
%  SubTask 3
%  ------------------------------------------------------------------------
title('\fontsize{11}\bfGerman Population')
xlabel('Year')
ylabel('Population')
grid on
grid minor

%% ========================================================================
%  SubTask 4
%  ------------------------------------------------------------------------
legend('Population Total')
ax = gca;

%% ========================================================================
%  SubTask 5
%  ------------------------------------------------------------------------
hold on
plot(PopDE.Year, PopDE.PopulationMale)
plot(PopDE.Year, PopDE.PopulationFemale)
legend({'Population Total','Population Male','Population Female'},...
        'Location','southoutside','NumColumns',3)

%% ========================================================================
%  SubTask 6
%  ------------------------------------------------------------------------
figure
a = area(PopDE.Year, [PopDE.PopulationMale, PopDE.PopulationFemale]);
title('\fontsize{11}\bfGerman Population')
xlabel('Year')
ylabel('Population')
a(1).FaceColor = 'b';
a(2).FaceColor = 'y';
legend('Male','Female')

%  ------------------------------------------------------------------------
sumMale = sum(PopDE.PopulationMale);
sumFemale = sum(PopDE.PopulationFemale);
figure
pie([sumMale, sumFemale], {'Male', 'Female'});
% ################### problem ###################
% do not know how to combine all the items of male and female

%% ========================================================================
%  SubTask 7
%  ------------------------------------------------------------------------
h = figure('Name','Subplots');
p = gobjects(2);
for piter = 1: numel(p)
    p(piter) = subplot(2,2,piter);
end
L = membrane;
% surface plot
p1 = surf(p(1),L,'EdgeColor','none');
title(p(1),'Surface');

% mesh plot
p2 = mesh(p(2),L);
title(p(2),'Mesh');

% ribbon plot
p3 = ribbon(p(3),L);
set(p3,'EdgeColor','none')
title(p(3),'Ribbon');

% ezsurface plot
p4 = bar3(p(4),L);
set(p4,'EdgeColor','none')
title(p(4),'3D Bar');
