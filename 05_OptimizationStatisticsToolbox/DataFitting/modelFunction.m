function [ z ] = modelFunction(x, y, p)
    % Inputs:
    % - x, y: values of the independent variables
    % - p: parameter vector
    %
    % Outputs:
    % - z: model output
    
    % analyse of the dataset behavior:
    % z seems to have 2 components: 
    %   a saddle surface built on a inclined surface
    
    % z has a component of x.*y as a inclined base surface
    % regardless of this base surface, the saddle surface has following 
    % features:
    % z-x relation at two ends of y (y=10 and y=0) seems to be linear
    % z-x relation at middle of y (y=5) seems to be z=(x-5).^2
    % z-y relation at two ends of x (x=10 and x=0) seems to be a normpdf
    % z-y relation at middle of x (x=5) seems to be z=0 
    
    c = p(1);
    a = p(2);
    b = p(3);
    x_m = p(4);
    mu_y = p(5);
    sig_y = p(6);
    
    z = c +...
        a*x.*y +...
        b.*(x - x_m*ones(size(x))).^2.*normpdf(y,mu_y,sig_y);
    
end
