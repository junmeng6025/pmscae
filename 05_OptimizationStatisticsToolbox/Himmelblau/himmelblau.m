function [ y ] = himmelblau(x1, x2)

%  use 'linspace()' as input:

% if numel(x1) == numel(x2)
%     y = zeros(numel(x1));
%     for i = 1: numel(x1)
%         for j = 1: numel(x2)
%             y(i, j) = (x1(i)^2 + x2(j) - 11)^2 + (x1(i) + x2(j)^2 - 7)^2;
%         end
%     end

%  use 'ndgrid()' as input:

if size(x1) == size(x2)
    y = zeros(size(x1));
    y = (x1.^2 + x2 - 11).^2 + (x1 + x2.^2 - 7).^2;
else
    error("NOT_IMPLEMENTED");
end
end
