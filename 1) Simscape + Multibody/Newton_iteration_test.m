%% Newton Iteration test script:

Fz1 = 48825;
Fz2 = 73264;
Fz3 = 288504;
FKP = 10000;
V = 10;
cm = 0.5;
rw = 0.5;

 % % Parameters
 %    tol = 1e-6; % Convergence tolerance
 %    maxIter = 10; % Maximum number of iterations
 %    Pe = Pe0; % Initial guess
 %    Pe0_ref = Pe0;
 % 
 %    % Right-hand side constants
 %    RHS = -FKP / m2 + (1 - theta) * Cdrag * V^2 / m2 + cr * Fz3 / m2 ...
 %          - FKP / m1 - theta * Cdrag * V^2 / m1 - cr * (Fz1 + Fz2) / m1;
 % 
 %    % Newton's iteration
 %    for iter = 1:maxIter
 %        % Compute Tm(Pe)
 %        Tm = (TmB - TmA) / pi * atan(cm * (Pe - Pe0_ref) / Pe0_ref) + (TmB + TmA) / 2;
 % 
 %        % Compute derivative of Tm(Pe)
 %        dTm_dPe = (TmB - TmA) / (pi * Pe0_ref) * (cm / (1 + (cm * (Pe - Pe0_ref) / Pe0_ref)^2));
 % 
 %        % Compute F_trailer(Pe)
 %        Ftrailer = (tau_m * eta_m / r_w) * Tm;
 % 
 %        % Compute derivative of F_trailer(Pe)
 %        dFtrailer_dPe = (tau_m * eta_m / r_w) * dTm_dPe;
 % 
 %        % Compute the function value f(Pe)
 %        f = (1 / m2) * (Ftrailer + FKP - (1 - theta) * Cdrag * V^2 - cr * Fz3) ...
 %            - (1 / m1) * (eta_g * eta_a / V * Pe - FKP - theta * Cdrag * V^2 - cr * (Fz1 + Fz2)) - RHS;
 % 
 %        % Compute the derivative f'(Pe)
 %        df_dPe = (1 / m2) * dFtrailer_dPe - (1 / m1) * (eta_g * eta_a / V);
 % 
 %        % Update Pe using Newton's method
 %        Pe_new = Pe - f / df_dPe;
 % 
 %        % Check convergence
 %        if abs(Pe_new - Pe) < tol
 %            Pe = Pe_new;
 %            fprintf('Converged in %d iterations. Pe = %.6f\n', iter, Pe);
 %            return;
 %        end
 % 
 %        % Update Pe for next iteration
 %        Pe = Pe_new;
 %    end
 % 
 %    error('Newton method did not converge within %d iterations.', maxIter);

%% 2nd version:
% Solve for Pe using Newton Iteration

% Constants
max_iter = 10; % Maximum number of iterations
tolerance = 1e-6; % Convergence tolerance
Pe_v2 = Pe0; % Initial guess for Pe

% Newton Iteration
for iter = 1:max_iter
    % Evaluate Tm(Pe)
    Tm = (TmB - TmA) / pi * atan(cm * ((Pe_v2 - Pe0) / Pe0)) + (TmB + TmA) / 2;

    % Evaluate Ftrailer(Pe)
    Ftrailer = (tau_m * eta_m / rw) * Tm;

    % Define the equation
    f = (1/m2) * (Ftrailer + FKP - (1 - theta) * Cdrag * V^2 - cr * Fz3) ...
        - (1/m1) * ((eta_g * eta_a / V) * Pe_v2 - FKP - theta * Cdrag * V^2 - cr * (Fz1 + Fz2));

    % Derivative of Tm with respect to Pe
    dTm_dPe = (TmB - TmA) / pi * cm / Pe0 * (1 + (cm * (Pe_v2 - Pe0) / Pe0)^2)^-1;

    % Derivative of Ftrailer with respect to Pe
    dFtrailer_dPe = (tau_m * eta_m / rw) * dTm_dPe;

    % Derivative of the equation with respect to Pe
    df_dPe = (1/m2) * dFtrailer_dPe ...
        - (1/m1) * (eta_g * eta_a / V);

    % Update Pe using Newton's method
    Pe_new = Pe_v2 - f / df_dPe;

    % Check for convergence
    if abs(Pe_new - Pe_v2) < tolerance
        Pe_v2 = Pe_new;
        fprintf('Converged in %d iterations. Pe = %.2f\n', iter, Pe_v2);
        return; % Converged
    end

    % Update Pe for the next iteration
    Pe_v2 = Pe_new;
    
end

% If no convergence, throw an error
error('Newton Iteration did not converge within the maximum number of iterations.');