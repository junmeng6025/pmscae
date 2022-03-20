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

function [ history ] = simulateMpc(problem, x_0, y_c, nu, steps)

    model = problem.Setup.Model;
    A = model.A;
    B = model.B;
    C = model.C;
    D = model.D;
    E = model.E;

    x = zeros([model.n_x, steps]);
    u = zeros([model.n_u, steps]);
    y = zeros([model.n_y, steps]);

    x(:, 1) = x_0;
    N = problem.Setup.Horizon;

    y_c_horizon = zeros([size(y_c, 1), N]);

    for k = 1 : steps

        fprintf("Step %d: ", k);

        % Extract the commands for the lookahead horizon
        m = min(size(y_c, 2) - k + 1, N);
        y_c_horizon(:, 1 : m) = y_c(:, k : k + m - 1);
        if m < N
            % Constant extrapolation
            y_c_horizon(:, m + 1 : end) = ...
                repmat(y_c_horizon(:, m), [1, N - m]);
        end

        % Solve the MPC problem
        solution = solveMpc(problem, x(:, k), y_c_horizon);

        % Apply the first control
        u(:, k) = solution.u(:, 1);

        % Calculate the current outputs and update the states
        y(:, k) = C * x(:, k) + D * u(:, k);
        if k < steps
            x(:, k + 1) = A * x(:, k) + B * u(:, k) + E * nu(:, k);
        end

    end

    history = struct();
    history.x = x;
    history.u = u;
    history.y = y;

end
