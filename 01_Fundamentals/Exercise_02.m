clear; close all; clc;
%% ========================================================================
%  SubTask 1
%  ------------------------------------------------------------------------
CellData = {'Markus', 'Mueller', 53, true, {'Marta Mueller'; 'Michael Mueller'; 'Martina Mueller'};
            'Peter', 'Schmidt', 58, true, {'Ursula Schmidt'};
            'Beate', 'Maier', 46, false, {'Gustav Maier'};
            'Ursula', 'Leitner', 36, true, {}
            };

%% ========================================================================
%  SubTask 2
%  ------------------------------------------------------------------------
save('CellData.mat', 'CellData')

%% ========================================================================
%  SubTask 3
%  ------------------------------------------------------------------------
StructData = struct('FirstName',CellData(:,1),...
                    'Surname',CellData(:,2),...
                    'Age',CellData(:,3),...
                    'Attendance',CellData(:,4),...
                    'Company',CellData(:,5)...
                    );
disp(StructData)

%% ========================================================================
%  SubTask 4
%  ------------------------------------------------------------------------
Mr_Mueller = StructData(1);
FirstName = StructData(1).FirstName;
Surname = StructData(1).Surname;
Age = StructData(1).Age;
Attendance = StructData(1).Attendance;
Company = StructData(1).Company;

whos

%% ========================================================================
%  SubTask 5
%  ------------------------------------------------------------------------
TableData = struct2table(StructData(1:4));
disp(TableData)

%% ========================================================================
%  SubTask 6
%  ------------------------------------------------------------------------
meanage = mean(TableData.Age);
