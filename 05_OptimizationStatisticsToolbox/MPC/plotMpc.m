function plotMpc(problem, t, y_c, solution)

    N_y_c = size(y_c, 2);
    N_sol = size(solution.u, 2);

    model = problem.Setup.Model;

    % states and controls -----------------------------------------------------

    ax1 = subplot(2, 1, 1);
    hold("on");

    for k = 1 : size(solution.u, 1)
        line = stairs(t(1 : N_sol), solution.u(k, :), "DisplayName", sprintf("u_%d", k));
        if isfinite(model.u_lb(k))
            yline(model.u_lb(k), "--", "Color", line.Color, "DisplayName", sprintf("u_l_b_%d", k));
        end
        if isfinite(model.u_ub(k))
            yline(model.u_ub(k), "--", "Color", line.Color, "DisplayName", sprintf("u_u_b_%d", k));
        end
    end

    for k = 1 : size(solution.x, 1)
        line = plot(t(1 : N_sol), solution.x(k, :), "DisplayName", sprintf("x_%d", k));
        if isfinite(model.x_lb(k))
            yline(model.x_lb(k), "--", "Color", line.Color, "DisplayName", sprintf("x_l_b_%d", k));
        end
        if isfinite(model.x_ub(k))
            yline(model.x_ub(k), "--", "Color", line.Color, "DisplayName", sprintf("x_u_b_%d", k));
        end
    end

    legend("show");
    xlabel("t");

    % commanded and actual outputs --------------------------------------------

    ax2 = subplot(2, 1, 2);
    hold("on");

    for k = 1 : size(solution.y, 1)
        plot(t(1 : N_y_c), y_c(k, :), "DisplayName", sprintf("y_c_%d", k));
    end

    for k = 1 : size(solution.y, 1)
        line = plot(t(1 : N_sol), solution.y(k, :), "DisplayName", sprintf("y_%d", k));
        if isfinite(model.y_lb(k))
            yline(model.y_lb(k), "--", "Color", line.Color, "DisplayName", sprintf("y_l_b_%d", k));
        end
        if isfinite(model.y_ub(k))
            yline(model.y_ub(k), "--", "Color", line.Color, "DisplayName", sprintf("y_u_b_%d", k));
        end
    end

    legend("show");
    xlabel("t");

    % -------------------------------------------------------------------------

    linkaxes([ax1, ax2], "x");

end
