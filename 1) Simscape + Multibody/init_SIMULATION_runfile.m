%% 04/12/2024 - Runfile SIMSCAPE E-trailer [KRAKER or BURGERS]:
% close all
% clear

%% Load DriveCycle input file:
load('US_drivecycles.mat');
load('EUDC.mat');

%% SIMULATION INPUT PARAMETERS:

% KRAKER or BURGERS trailer:
trailer_ID = 1;         % (KRAKER ID = 1 ; BURGERS ID = 0)

% Etrailer ON or OFF:
etrailer_ON = 1;        % (1 = ON; 0 = OFF)

% Simple or WP3a Etrailer controller_Break:
WP3a_SIMPLE_switch_Break = 2; % (1 = simple ; 2 = WP3a)



% Simple, WP3a or RL Etrailer controller_Torque:
WP3a_SIMPLE_switch_Torque = 3; % (1 = simple ; 2 = WP3a; 3=RL)


% Cargo mass:
massload =          23000;      %[kg] Mass of Cargo

% Specify which trailer init file to run:
if trailer_ID == 0
    run('init_BURGERS.m');
else
    run('init_KRAKER.m');
end

%% Input Drive Cycle:
% Specify which input Drivecycle is wanted: 
InputSwitch = 2;    

% 1 = FTP
% 2 = C505
% 3 = UDDS
% 4 = HWFET
% 5 = US06
% 6 = US06City
% 7 = US06Hwy

% Specify simulation time based on length drivecycle input:
if InputSwitch == 1
    tmax =       2478;      
elseif InputSwitch == 2
    tmax =       506;        
elseif InputSwitch == 3
    tmax =       1373;
elseif InputSwitch == 4
    tmax =       766;
elseif InputSwitch == 5
    tmax =       597;
elseif InputSwitch == 6
    tmax =       233;
elseif InputSwitch == 7
    tmax =       371;
else
    tmax =       400;        %[sec] simulation time input
end

