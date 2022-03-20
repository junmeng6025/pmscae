clear; close all; clc;
%% ========================================================================
%  SubTask 1
%  ------------------------------------------------------------------------
%  a) create a datastore object
%     delimiter change to ','
ds = datastore('RKI_COVID19.csv');
ds.Delimiter = ',';
%% ========================================================================
%  SubTask 2
%  ------------------------------------------------------------------------
%  b) select the colum we concern
ds.SelectedVariableNames = {'Bundesland', 'Altersgruppe', 'Geschlecht', 'AnzahlFall', 'AnzahlTodesfall'};
ds.TreatAsMissing = 'unbekannt';
ds_selected = preview(ds);

%% ========================================================================
%  SubTask 3
%  ------------------------------------------------------------------------
%  c) convert to tall array
tarray = tall(ds);

%% ========================================================================
%  SubTask 4
%  ------------------------------------------------------------------------
%  d) cerate subset for debugging
subset = head(tarray,100000); % default: extract 8 rows
%  From now on, continue to work with the smaller array

%% ========================================================================
%  SubTask 5
%  ------------------------------------------------------------------------
%  e) sum the values for the variables Cases and Deaths
%     group them for each state in Germany
queue = gather(tarray); % 'gather' convert a tall array to a table
static = groupsummary(queue,'Bundesland','sum',{'AnzahlFall','AnzahlTodesfall'});

%% ========================================================================
%  SubTask 6
%  ------------------------------------------------------------------------
%  f) Create two pie charts, for Cases and Deaths in each state
stateLabels = static.Bundesland;
% stateLabels = categorical(static.(:,1));
listCases = static.sum_AnzahlFall;
% listCases = categorical(static.(:,3));
listDeaths = static.sum_AnzahlTodesfall;
% listDeaths = categorical(static.(:,4));

figure('Name','Cases and Deaths plots of each state in Germany')
subplot(1,2,1)
p1 = pie(listCases,stateLabels);
title('\fontsize{11}\bfAnzahl Fall jedes Bundeslands')

subplot(1,2,2)
p2 = pie(listDeaths,stateLabels);
title('\fontsize{11}\bfAnzahl Todesfall jedes Bundeslands')
% ################## to improve: show percentage values ##################
suptitle('\fontsize{16}\bfCases and Deaths plots of each state')

%% ========================================================================
%  SubTask 7
%  ------------------------------------------------------------------------
%  g) bubble figure
global GPStab
GPStab = readtable('GPS_Coordinates_StatesGermany.xlsx');
len = height(GPStab);

state = string(GPStab.State); % 'string' converts cell to string list

latitude = zeros(len,1);
longitude = zeros(len,1);
sum_cases = zeros(len,1);
sum_deaths = zeros(len,1);

covidTab = table(string(stateLabels),listCases,listDeaths);
covidTab.Properties.RowNames = string(stateLabels);

for p = 1: len
    currentState = state(p);
    [latitude(p), longitude(p)] = Lookup(currentState);
    sum_cases(p) = covidTab.listCases(currentState);
    sum_deaths(p) = covidTab.listDeaths(currentState);
end
covidMap = table(latitude,longitude,sum_cases,sum_deaths);
covidMap.Properties.RowNames = state;

% plot geobubble
figure
gb = geobubble(latitude,longitude,sum_cases);
gb.BubbleWidthRange = [10 60];
geolimits([47 55], [5 15]);

%% ========================================================================
%  SubTask 8
%  ------------------------------------------------------------------------
%  local function
function [lati, longi] = Lookup(stateName)
% input:    state name (str)
% output:   latitude (double), longitude (double)
global GPStab
for i = 1: height(GPStab)
    if strcmp(stateName, GPStab.State(i))
        lati = GPStab.Lat(i);
        longi = GPStab.Long(i);
    end
end
end