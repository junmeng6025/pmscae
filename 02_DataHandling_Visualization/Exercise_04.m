clear; close all; clc;
%% ========================================================================
%  SubTask 1
%  ------------------------------------------------------------------------
h = figure('Name','Subplots');
p = gobjects(1,3);

%% ========================================================================
%  SubTask 2
%  ------------------------------------------------------------------------
melbourne = imread('melbourne_circuit.jpg');

tiledlayout(1,3)
for k = 1: numel(p)
    p(k) = nexttile;
end
axes(p(1)); imshow(melbourne); axis off
%% ========================================================================
%  SubTask 3
%  ------------------------------------------------------------------------
sz = size(melbourne);
R = melbourne(:,:, 1);
G = melbourne(:,:, 2);
B = melbourne(:,:, 3);
for x = 1: sz(1)
    for y = 1: sz(2)
        r = R(x, y);
        g = G(x, y);
        b = B(x, y);
        if r>0 || g>0 || b<250
            R(x, y) = 255;
            G(x, y) = 255;
            B(x, y) = 255;
        end
    end
end
melbourne_extracted = cat(3,R,G,B);
axes(p(2)); imshow(melbourne_extracted); axis off
%  ------------------------------------------------------------------------
logicArray = false(sz(1), sz(2));
%  ------------------------------------------------------------------------
for x = 1: sz(1)
    for y = 1: sz(2)
        r = R(x, y);
        g = G(x, y);
        b = B(x, y);
        if r==0 && g==0 && b>250
            logicArray(x, y) = 1;
        end
    end
end
axes(p(3)); spy(logicArray); axis off
%% ========================================================================
%  SubTask 4
%  ------------------------------------------------------------------------
[row, col] = find(logicArray);
trackCoordinate = horzcat(row, col);
csvwrite('trackCoordinate.csv',trackCoordinate);