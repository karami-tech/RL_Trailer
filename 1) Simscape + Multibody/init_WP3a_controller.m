%% WP3a controller parameter file:
%  last updated: 25/11/2024

% Controller tunable paramters:
TmA = -100;                 % [Nm] Control parameter
TmB = 350;                  % [Nm] Control parameter
Pe0 = 200000;               % [W] Control Parameter
Vxcoast = 30/3.6;           % [m/s] coast velocity

% Additional controller parameters:
m1 = 7044;                  % Mass of tractor in [kg]
m2 = mass + massload;       % Mass of semitrailer (including load) in [kg]
tau_m = 6;                  % Ratio between trailer axle and E-motor
eta_m = 1;                  % Efficiency E-motor to E-axle
r_w = 0.5;                  % Tire radius in [m]
theta_m = 0.15;
theta = 0.5;                % Share of aerodynamic drag for truck (order 0.5)
pa = 1.3;                   % Air Density in [kg/m^3]
Af = 9.5;                   % Frontal area in [m^2]
cd = 0.8;                   % Drag coefficient 
Cdrag = 0.5*pa*Af*cd;         
cr = 0.008;                 % Rolling resistance coefficient
eta_g = 0.85;               % Efficiency gear truck
eta_a = 0.97;               % Efficiency auxiliaries truck driveline