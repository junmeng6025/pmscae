function f = fibonacci_recursive(n)
% return the n_th element of fibonacci serie.
if n < 0
     disp('ERROR: n must be a non-negative int.');
elseif n == 0
    f = 0;
elseif n == 1
    f = 1;
else
    f = fibonacci_recursive(n-1) + fibonacci_recursive(n-2);     
end
end