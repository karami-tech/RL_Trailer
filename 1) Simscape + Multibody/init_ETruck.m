%% E-truck parameter file
%  last updated: 30/10/2024

% E-Truck Battery Parameters:
ETruck_Voc =               750;        %[V] Open Circuit Voltage
ETruck_Rin =               0.015;        %[ohm] internal Resistance of battery
ETruck_energyCapacity=     650;        %[Ah] Energy Capacity of Battery
ETruck_initialSOC =        0.95;       %[%] Starting SOC
ETruck_battery_mass =      1500;       %[kg] Battery mass

% E-Truck E-Motor Parameters:
ETruck_MaxTrqOut =         2250;       %[Nm] Max E-motor Torque
ETruck_MaxPowerOut =       500000;     %[W] Max Power of E-motor
ETruck_MaxMotorSpeed =     9000;       %[rpm] Maximum motor speed
ETruck_Std_Regen_Trq =     300;        %[Nm] Standard Regeneration Torque when throttle = 0
ETruck_Emotor_mass =       250;        %[kg] E-Truck E-motor mass
    
% E-Truck Driveline Parameters:
ETruck_G_motor =          17.5;          %Gear ratio of motor reducer (no motor reducer)