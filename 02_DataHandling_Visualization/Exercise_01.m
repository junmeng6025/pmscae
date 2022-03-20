% clear; close all; clc;
%% ========================================================================
%  SubTask 1
%  ------------------------------------------------------------------------
%  Importing data interactively
%  FilePath: current working space
%  FileName: 'PopulationData.dat'
%  load data into workspace as a table data type

%% ========================================================================
%  SubTask 2
%  ------------------------------------------------------------------------
summary(PopulationData)
%sz = size(PopulationData);

%% ========================================================================
%  SubTask 3
%  ------------------------------------------------------------------------
PopulationData.PopulationFemale = (PopulationData.PopulationFemaleOfTotal/100 .* PopulationData.PopulationTotal);
PopulationData.PopulationMale = (PopulationData.PopulationTotal - PopulationData.PopulationFemale);

%% ========================================================================
%  SubTask 4
%  ------------------------------------------------------------------------
PopulationMatrix = table2array(PopulationData);
csvwrite('GermanPopulation.csv',PopulationMatrix);

%% ========================================================================
%  SubTask 5
%  ------------------------------------------------------------------------
save('GermanPopulation.mat', 'PopulationData');
%  load and check file 'GermanPopulation.mat'
check_GermanPopulation = load('GermanPopulation.mat');

%% ========================================================================
%  SubTask 6
%  ------------------------------------------------------------------------
%  Perform a low level import of the data from 'PopulationData.dat'.

fname = 'PopulationData.dat';
fid = fopen(fname);

Header = textscan(fid, '%s', 10, 'Delimiter', ';');
disp(Header{:})

numbers = fscanf(fid, '%g; %g; %g; %g; %g; %g; %g; %g; %g; %g\n', [10 Inf])';

doc textscan
doc fscanf

%% ========================================================================
%  SubTask 7
%  ------------------------------------------------------------------------
fileID = fopen('PopulationData.txt','w');
formatSpec = '%10i; %10.3f; %10.3f; %10.3f; %10.3f; %10.3f; %10.3f; %10.3f; %10i; %10.3f\n';
fprintf(fileID, formatSpec, numbers');