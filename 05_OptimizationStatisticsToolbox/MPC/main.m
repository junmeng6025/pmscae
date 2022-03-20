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

%% Dynamic System

% Here, we define the dynamic system in a struct for simplicity.

model = struct();

model.A = [
    0.90, 0.07
    -1.73, 0.42
];
model.B = [
    0.49
    8.62
];
model.C = [
    1, 0
];
model.D = [
    0.1
];
model.E = [
    -0.02
    0.05
];

model.n_x = size(model.A, 1);
model.n_u = size(model.B, 2);
model.n_y = size(model.C, 1);
model.n_nu = size(model.E, 2);

model.x_lb = [ -inf, -5 ]';
model.x_ub = [ +inf, +5 ]';

model.u_lb = -2;
model.u_ub = +2;

model.y_lb = [ -3 ]';
model.y_ub = [ +3 ]';

model.TimeStep = 0.1;

%% Problem Setup

setup = struct();
setup.Model = model;
setup.Horizon = 20;
setup.OutputErrorPenalty = eye(model.n_y);
setup.ConstraintViolationPenalty = 1e3;
setup.RelaxationLimit = inf;

%% Create the problem matrices and solve the MPC problem at a single point

N = setup.Horizon;
steps = 10 * N;
t = model.TimeStep * (0 : steps - 1);
rng(798475);
y_c = repelem(-5 + randi(10, [1, ceil(steps / 10)]), 10);

problem = createProblem(setup);

x_0 = [0, 0]';
solution = solveMpc(problem, x_0, y_c(:, 1 : N));

figure("Name", "Solution for a single lookahead horizon");
plotMpc(problem, t, y_c, solution);

%% Simulate the MPC

% Random zero-mean disturbance
nu = 1 * randn([model.n_u, steps]);

history = simulateMpc(problem, x_0, y_c, nu, steps);

figure("Name", "Simulation");
plotMpc(problem, t, y_c, history)
subplot(2, 1, 1);
plot(t, nu, "DisplayName", "\nu");
