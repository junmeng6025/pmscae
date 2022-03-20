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

function [ solution ] = solveMpc(problem, x_i, y_c)
    % Solve the MPC problem for a given initial state x_i and command sequence
    % y_c.
    %
    % Input:
    % - problem: see createProblem()
    % - x_i: the initial (current) state vector
    % - y_c: the commanded output sequence (size n_y by N)
    %
    % Output:
    % - solution: solution of the MPC problem
    %   - x: state history (size n_x by N)
    %   - u: control history (size n_u by N)

    %--------------------------------------------------------------------------
    % Problem
    H = problem.H;
    df_dy_hat_c = problem.df_dy_hat_c;
    z_lb = problem.z_lb;
    z_ub = problem.z_ub;
    C_eq = problem.C_eq;
    v_eq = problem.v_eq;
    C_ne = problem.C_ne;
    v_ne = problem.v_ne;
    dy_hat_dz = problem.dy_hat_dz;
    n_y = problem.Setup.Model.n_y;
    N = problem.Setup.Horizon;

    assert(size(y_c, 1) == n_y);
    assert(size(y_c, 2) == N);

    %--------------------------------------------------------------------------
    % Update the initial boundary condition
    %
    % Task:
    % Update the constraints such that the initial boundary condition is
    % satisfied.

    error("NOT_IMPLEMENTED");

    %--------------------------------------------------------------------------
    % Calculate the linear term
    %
    % Task:
    % Calculate the coefficient vector f for the QP objective.
    %
    % Output:
    % f: The linear coefficient vector.

    error("NOT_IMPLEMENTED");

    %--------------------------------------------------------------------------
    % Solve the QP
    %
    % Task:
    % Call a suitable optimization routine (with suitable options).  Check if
    % the solution is valid.
    %
    % Output:
    % z: The vector of optimal decision variables.

    error("NOT_IMPLEMENTED");

    %--------------------------------------------------------------------------
    % Extract the solution
    %
    % Task:
    % Extract the state and control histories from the solution vector.
    %
    % Output:
    % - solution.x: the state history (n_x by N)
    % - solution.u: the control history (n_u by N)
    % - solution.y: the output history (n_y by N)

    error("NOT_IMPLEMENTED");

end
