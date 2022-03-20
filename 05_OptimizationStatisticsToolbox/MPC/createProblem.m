%****************************************************************************************************************
%*                                                                                                              *
%*                                          MATLAB / Simulink Lab Course                                        *
%*                                                                                                              *
%****************************************************************************************************************
%*                                                                                                              *
%*                       L E H R S T U H L   F U E R   F L U G S Y S T E M D Y N A M I K                        *
%*                     I N S T I T U T E   O F   F L I G H T   S Y S T E M   D Y N A M I C S                    *
%*                                                                                                              *
%*                                     Technische Universitaet Muenchen (TUM)                                   *
%*                                Boltzmannstrasse 15 - D-85748 Garching - Germany                              *
%*                    Phone: +49 89 289-16081, eMail: office@fsd.mw.tum.de, Web: www.fsd.mw.tum.de              *
%*                                                                                                              *
%*     (c) by Institute of Flight System Dynamics of Technische Universitaet Muenchen, All Rights Reserved      *
%*                                                                                                              *
%****************************************************************************************************************
%*                                                                                                              *
%*                                          Exercise MPC                                                        *
%*                                                                                                              *
%****************************************************************************************************************

function [ problem ] = createProblem(setup)
    % Setup the problem matrices.
    %
    % Input:
    % - setup:
    %   - Model: the dynamic system
    %     - A, B, C, D: the system matrices
    %     - n_x, n_u, n_y: the system dimensions
    %     - x_lb, x_ub: lower and upper state bounds
    %     - u_lb, u_ub: lower and upper control bounds
    %     - y_lb, y_ub: lower and upper output bounds
    %     - TimeStep: the discrete time step
    %   - Horizon: the lookahead horizon (number of steps N)
    %   - OutputErrorPenalty: symmetric weighting matrix for the tracking error
    %
    % Output:
    % - problem:
    %   - Setup: setup
    %   - H: the constant Hessian of the MPC problem
    %   - df_dy_hat_c: the Jacobian of the linear term w.r.t. to the commanded
    %     output sequence
    %   - z_lb, z_ub: lower and upper bounds of the decision variables
    %   - C_eq, v_eq: equality constraints in standard form (C_eq * z == v_eq)
    %   - C_ne, v_ne: inequalities in standard form (C_ne * z <= v_ne)
    %   - Indices
    %     - x: indices of x in z (size: n_x by N)
    %     - u: indices of u in z (size: n_u by N)

    %--------------------------------------------------------------------------
    % Dynamic system

    model = setup.Model;
    n_x = model.n_x;
    n_u = model.n_u;
    n_y = model.n_y;
    A = model.A;
    B = model.B;
    C = model.C;
    D = model.D;

    assert(isequal(size(A), [n_x, n_x]));
    assert(isequal(size(B), [n_x, n_u]));
    assert(isequal(size(C), [n_y, n_x]));
    assert(isequal(size(D), [n_y, n_u]));
    assert(isequal(size(model.x_lb), [n_x, 1]));
    assert(isequal(size(model.x_ub), [n_x, 1]));
    assert(isequal(size(model.u_lb), [n_u, 1]));
    assert(isequal(size(model.u_ub), [n_u, 1]));
    assert(isequal(size(model.y_lb), [n_y, 1]));
    assert(isequal(size(model.y_ub), [n_y, 1]));

    %--------------------------------------------------------------------------
    % Lookahead horizon and objective

    N = setup.Horizon;

    Q = setup.OutputErrorPenalty;
    assert(issymmetric(Q));

    mu = setup.ConstraintViolationPenalty;
    assert(isscalar(mu));

    %--------------------------------------------------------------------------
    % Decision variables and Jacobians
    %
    % Tasks:
    % - Calculate the Jacobians of the stacked state vector x_hat and the
    %   stacked control vector u_hat with respect to the vector of decision
    %   variables z.
    % - Calculate the Jacobian of the stacked output vector y_hat with respect
    %   to the vector of decision variables z.
    %
    % Output:
    % - zIndex.e: index of e in z (scalar)
    % - zIndex.x: indices of [x_1, ..., x_N] in z (n_x by N)
    % - zIndex.u: indices of [u_1, ..., u_N] in z (n_u by N)
    % - de_dz: Jacobian of e w.r.t. z
    % - dx_hat_dz: Jacobian of x_hat w.r.t. z
    % - du_hat_dz: Jacobian of u_hat w.r.t. z
    % - dy_hat_dz: Jacobian of y_hat w.r.t. z
    
    zIndex = struct();
    zIndex.e = N;
    zIndex.x = n_x * N;
    zIndex.u = n_u * N;
    
    x_hat = zeros(N, n_x);
    u_hat = zeros(N, n_u);
    y_hat = C_hat * x_hat + D_hat * u_hat;

    de_dz = jacobian(e, z);
    dx_hat_dz = jacobian(x_hat, z);
    du_hat_dz = jacobian(u_hat, z);
    dy_hat_dz = jacobian(y_hat, z);

    %--------------------------------------------------------------------------
    % Bounds
    %
    % Task:
    % Define the vectors of lower and upper bounds for the decision variables.
    %
    % Output:
    % - z_lb: vector of lower bounds
    % - z_ub: vector of upper bounds
    
    z_lb = [];
    z_ub = [];

    %--------------------------------------------------------------------------
    % Dynamic constraint
    %
    % Task:
    % Express the dynamic constraint in standard form.
    %
    % Output:
    % - C_eq: equality constraint matrix
    % - v_eq: equality constraint vector

    v_eq = C_eq * z;

    %--------------------------------------------------------------------------
    % Inequality constraints
    %
    % Task:
    % Express the (relaxed) state and output inequality constraints in standard
    % form.
    %
    % Output:
    % - C_ne: inequality constraint matrix
    % - v_ne: inequality constraint vector

    v_ne >= C_ne * z;

    %--------------------------------------------------------------------------
    % Objective
    %
    % Task:
    % Express the quadratic objective in standard form.  Calculate the Hessian
    % and prepare the linear term, which still depends on the command sequence
    % (unknown at this point).
    %
    % Output:
    % - H: the Hessian of the objective
    % - df_dy_hat_c: Jacobian of the linear term (f) w.r.t. the stacked command
    %   sequence y_hat_c.

    H = (de_dz)' * mu * (de_dz) + (dy_hat_dz)' * Q_hat * (dy_hat_dz);
    df_dy_hat_c = - (dy_hat_dz)' * Q_hat;
    J = 1/2 * z' * H * z + df_dy_hat_c' * z;

    %--------------------------------------------------------------------------
    % Problem

    problem = struct();
    problem.Setup = setup;
    problem.H = H;
    problem.df_dy_hat_c = df_dy_hat_c;
    problem.z_lb = z_lb;
    problem.z_ub = z_ub;
    problem.C_eq = C_eq;
    problem.v_eq = v_eq;
    problem.C_ne = C_ne;
    problem.v_ne = v_ne;
    problem.Indices.x = zIndex.x;
    problem.Indices.u = zIndex.u;
    problem.dy_hat_dz = dy_hat_dz;

end
