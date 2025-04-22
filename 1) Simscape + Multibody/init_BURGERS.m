%% BURGERS E-trailer parameter file
%  last updated: 28/10/2024

% BURGERS Trailer Parameters:
mass_trailer =      11000;      %[kg] Mass of the Trailer
chassis_length =    13.82;      %[m] Length of trailer chassis
front_overhang =    1.620;      %[m] Distance between kingpin and front of trailer
wheelbase =         8.115;      %[m] Distance between kingpin and centre of axle combination

% Electric drivetrain masses:
mass_batterypack =  420;        %[kg] mass of battery pack
mass_Emotor =       27;         %[kg] mass of E-motor
mass_inverter =     6.8;        %[kg] mass of inverter
mass_Edriveline = mass_batterypack + (2*mass_Emotor) + (2*mass_inverter);

% Inverter losses:
Vdc =               [200 400 600 800];
Arms =              [100 200 300 400 500 600];
Power_dissipation = [261 384 513 642; 552 783 1020 1260; 894 1233 1584 1956; 1300 1750 2200 2740; 1740 2300 2900 3550; 2250 2900 3650 4500];
inverter_thermal_res = 0.017;   %[K/W] Inverter thermal resistance

% Trailer mass determination (E-trailer or not):

if etrailer_ON == 1
    mass = mass_trailer + mass_Edriveline;
else
    mass = mass_trailer;
end

% Battery Parameters:
Voc =               675;        %[V] Open Circuit Voltage
Rin =               0.1;        %[ohm] internal Resistance of battery
energyCapacity=     116.89;     %[Ah] Energy Capacity of Battery
initialSOC =        0.95;       %[%] Starting SOC

% E-Motor (2x AXM3) Parameters:
MaxTrqOut =         525;        %[Nm] Max E-motor Torque
MaxPowerOut =       220000;     %[W] Max Power of E-motor
MaxMotorSpeed =     5800;       %[rpm] Maximum motor speed
Std_Regen_Trq =     300;        %[Nm] Standard Regeneration Torque when throttle = 0
    
% Driveline Parameters:
G_diff =            1;          %Gear ratio of E-trailer differential (no diff)
G_motor =           6;          %Gear ratio of motor reducer

% Drivermodel Parameters:
kP =                0.5;        %Proportianal Gain Driver          
kD =                0;          %Derivative Gain Driver
kI =                1e-03;      %Integrator Gain Driver  

% Surroundings parameters:
airDensity =        1.3;        %[kg/m^3] Air Density
Crr =               0;          %Rolling Resistance coefficient
gravity =           9.81;       %[m/s^2] Gravity constant
outside_temp =      25;         %[C] outside temperature

% Tractor engine parameters:

% BSFC map arrays (defined from Genta, Joop)
Eff= [336.0 370.2 399.2 423.6 444.0 461.0 475.2 487.2 496.2 502.6 506.2 506.9 504.2 500.0 492.4 482.3 469.2 ; 271.0 278.2 285.5 292.8 300.0 307.0 313.7 320.0 325.9 331.5 336.7 341.5 345.9 350.0 353.7 357.0 360.0 ; 223.2 222.7 222.2 221.9 222.0 222.7 224.2 226.7 230.0 234.2 239.3 245.3 252.2 260.0 268.7 278.2 288.7 ; 227.6 221.7 216.8 212.9 210.0 208.1 207.2 207.3 208.5 210.7 214.0 218.3 223.6 230.0 237.4 245.9 255.3 ; 215.0 211.4 208.4 206.0 204.2 203.0 202.4 202.4 203.0 204.2 206.0 208.4 211.3 214.9 219.0 223.7 229.0 ; 223.5 216.6 211.2 207.1 204.1 202.0 200.6 199.7 199.5 199.9 200.9 202.5 204.7 207.6 211.0 215.1 219.7 ; 239.5 229.6 221.2 214.2 208.5 204.0 200.6 198.2 196.9 196.6 197.4 199.2 202.1 206.0 210.5 214.5 218.9 ; 179.0 196.0 205.6 209.4 209.0 206.0 202.0 198.6 196.9 196.9 198.6 202.0 205.0 208.5 212.0 215.9 220.0 ; 188.6 201.7 208.6 210.7 209.4 206.1 202.2 199.1 197.5 197.6 199.2 202.1 205.8 209.9 213.6 216.8 221.0 ; 209.0 212.0 214.0 215.0 210.0 206.3 205.0 201.0 200.6 200.8 201.9 203.5 209.1 215.0 216.5 217.5 221.0 ];
RPM=[400 500 600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000];
Torq=[0 250 500 750 1000 1250 1500 1750 1850 2000];

% Diesel density:
Diesel_density = 850;           %Fuel Density Diesel [kg/m^3]