%% Clean Slate Protocol
clear;
close all;
clc;
%% Load Data 
% load ../simresults/Tractor_Semitrailer_MF_FT_circle.mat
% load ../simresults/Tractor_Semitrailer_MF_TNO_circle.mat
%% Plot 1G Vs 2G (global position, lateral acc-drive & steer, steering angle, torsion angle, Yaw velocity)

%% Plot MF (MAT Vs TNO) Position
figure('Name','Global Position');
plot(p.steeraxle.pos(:, 1), p.steeraxle.pos(:, 2), 'b', 'LineWidth', 1);
% hold on;
% plot(q.frontaxle.pos(:, 1), q.frontaxle.pos(:, 2), 'r--', 'LineWidth', 1);
xlabel('X coordinate position (m)');
ylabel('Y coordinate position (m)');
title('Global Position - Front Axle');
% axis equal
legend('MF - MAT ', 'MF - TNO','Location', 'best');
hold off;

%% Plot MF (MAT Vs TNO) GLobal Position - Tractor + Trailer 
figure('Name','Global Position');
plot(p.frontaxle.pos(:, 1), p.frontaxle.pos(:, 2), 'b', 'LineWidth', 1);
hold on;
plot(q.frontaxle.pos(:, 1), q.frontaxle.pos(:, 2), 'r', 'LineWidth', 1);
plot(p.semitraileraxle3.pos(:, 1),p.semitraileraxle3.pos(:, 2), 'b', 'LineWidth', 1);
plot(q.semitraileraxle3.pos(:, 1),q.semitraileraxle3.pos(:, 2), 'r', 'LineWidth', 1);
xlabel('X coordinate position (m)');
ylabel('Y coordinate position (m)');
title('Global Position - Front Axle + Trailer Axle 3');
axis equal
legend('MF - MAT (Steer)', 'MF - TNO (Steer)','MF - MAT (Trailer 3)', 'MF - TNO (Trailer 3)','Location', 'best');
hold off;

%% Steering angle
figure;
plot(p.time, rad2deg(p.inputs.delta), 'LineWidth', 2); % Radians to deg
hold on;
plot(q.time, rad2deg(q.inputs.delta), 'r--', 'LineWidth', 2);
axis auto;
hold off;
grid on;
xlabel('Time [s]');
ylabel('\delta [deg]');
legend('MF - MAT', 'MF - TNO', 'Location', 'best');
title('Steering angle');

%% Steer Axle - Lateral acceleration
figure;
plot(p.time, p.steeraxle.acc(:, 2) / 9.81, 'LineWidth', 1);
hold on;
plot(q.time, q.steeraxle.acc(:, 2) / 9.81, 'r--', 'LineWidth', 1);
axis auto;
hold off;
grid on;
xlabel('Time [s]');
ylabel('a_y [g]');
legend('MF - MAT', 'MF - TNO', 'Location', 'best');
title('Steer Axle - Lateral acceleration');

%% Steer Axle - Lateral acceleration Error
figure;
plot(p.time, abs(p.steeraxle.acc(:, 2) - q.steeraxle.acc(:, 2)));
axis auto;
grid on;
xlabel('Time [s]');
ylabel('a_y [g]');
legend('MF - MAT  Vs MF - TNO');
title('Steer Axle - Lateral acceleration Error');

%% Drive Axle - Lateral acceleration
figure;
plot(p.time, p.driveaxle.acc(:, 2) / 9.81, 'LineWidth', 1);
hold on;
plot(q.time, q.driveaxle.acc(:, 2) / 9.81, 'r--', 'LineWidth', 1);
axis auto;
hold off;
grid on;
xlabel('Time [s]');
ylabel('a_y [g]');
legend('MF - MAT', 'MF - TNO', 'Location', 'best');
title('Drive Axle - Lateral acceleration');

%% Trailer Axle 3 - Lateral acceleration
figure;
plot(p.time, p.semitraileraxle3.acc(:, 2) / 9.81, 'LineWidth', 1);
hold on;
plot(q.time, q.semitraileraxle3.acc(:, 2) / 9.81, 'r--', 'LineWidth', 1);
axis auto;
hold off;
grid on;
xlabel('Time [s]');
ylabel('a_y [g]');
legend('MF - MAT', 'MF - TNO', 'Location', 'best');
title('Trailer Axle 3 - Lateral acceleration');


%% Steer Axle - Load
figure;
g = 9.81; % Acceleration due to gravity in m/s^2
steer_axle_load_kg = p.steeraxle.acc(:, 3) / g;
plot(p.time, steer_axle_load_kg, 'LineWidth', 1);
axis auto;
hold off;
grid on;
xlabel('Time [s]');
ylabel('Load [kg]');
legend('Steer Axle Load', 'Location', 'best');
title('Steer Axle Load');

%% Drive Axle - Load
figure;
drive_axle_load_kg = p.driveaxle.acc(:, 3) / g;
plot(p.time, drive_axle_load_kg, 'LineWidth', 1);
axis auto;
hold off;
grid on;
xlabel('Time [s]');
ylabel('Load [kg]');
legend('Drive Axle Load', 'Location', 'best');
title('Drive Axle Load');
%% Tire Load Tractor (Fz)
figure;

% Constants
g = 9.81; % Acceleration due to gravity in m/s^2
settle_time = 2; % Time after which the model settles down, in seconds
index_after_settle = find(p.time > settle_time, 1); % Find the index after the model has settled

% Front Axle Tire Loads
subplot(3, 1, 1); % 3 rows, 1 column, 1st subplot

tire_load_kg_FL = p.tyre.tractor.Fz(:, 1) / g;
tire_load_kg_FR = p.tyre.tractor.Fz(:, 2) / g;


% Plot tire loads
plot(p.time, tire_load_kg_FL, 'b', 'LineWidth', 1.5);
hold on;
plot(p.time, tire_load_kg_FR, 'r--', 'LineWidth', 1.5);

hold off;

grid on;
xlabel('Time [s]');
ylabel('Load [kg]');
legend('Tire Load FL', 'Tire Load FR');
title('Front Axle Tire Loads');

% Rear Left Tire Loads
subplot(3, 1, 2); % 3 rows, 1 column, 2nd subplot

tire_load_kg_RL1 = p.tyre.tractor.Fz(:, 3) / g;
tire_load_kg_RL2 = p.tyre.tractor.Fz(:, 4) / g;


% Plot tire loads
plot(p.time, tire_load_kg_RL1, 'b', 'LineWidth', 1.5);
hold on;
plot(p.time, tire_load_kg_RL2, 'r--', 'LineWidth', 1.5);


hold off;

grid on;
xlabel('Time [s]');
ylabel('Load [kg]');
legend('Tire Load RL1', 'Tire Load RL2');
title('Rear Left Tire Loads');

% Rear Right Tire Loads
subplot(3, 1, 3); % 3 rows, 1 column, 3rd subplot

tire_load_kg_RR1 = p.tyre.tractor.Fz(:, 5) / g;
tire_load_kg_RR2 = p.tyre.tractor.Fz(:, 6) / g;

% Plot tire loads
plot(p.time, tire_load_kg_RR1, 'b', 'LineWidth', 1.5);
hold on;
plot(p.time, tire_load_kg_RR2, 'r--', 'LineWidth', 1.5);

hold off;

grid on;
xlabel('Time [s]');
ylabel('Load [kg]');
legend('Tire Load RR1', 'Tire Load RR2');
title('Rear Right Tire Loads');


%% Semitrailer Tire loads (Fz)
figure;

% Constants
g = 9.81; % Acceleration due to gravity in m/s^2

% Axle 1 Tire Loads
subplot(3, 1, 1); % 3 rows, 1 column, 1st subplot

tire_load_kg_A1L = p.tyre.semitrailer.Fz(:, 1) / g;
tire_load_kg_A1R = p.tyre.semitrailer.Fz(:, 2) / g;

plot(p.time, tire_load_kg_A1L, 'b', 'LineWidth', 1.5);
hold on;
plot(p.time, tire_load_kg_A1R, 'r--', 'LineWidth', 1.5);
hold off;

grid on;
xlabel('Time [s]');
ylabel('Load [kg]');
legend('Axle 1 Left', 'Axle 1 Right');
title('Semitrailer Axle 1 Tire Loads');

% Axle 2 Tire Loads
subplot(3, 1, 2); % 3 rows, 1 column, 2nd subplot

tire_load_kg_A2L = p.tyre.semitrailer.Fz(:, 3) / g;
tire_load_kg_A2R = p.tyre.semitrailer.Fz(:, 4) / g;

plot(p.time, tire_load_kg_A2L,  'b', 'LineWidth', 1.5);
hold on;
plot(p.time, tire_load_kg_A2R, 'r--', 'LineWidth', 1.5);
hold off;

grid on;
xlabel('Time [s]');
ylabel('Load [kg]');
legend('Axle 2 Left', 'Axle 2 Right');
title('Semitrailer Axle 2 Tire Loads');

% Axle 3 Tire Loads
subplot(3, 1, 3); % 3 rows, 1 column, 3rd subplot

tire_load_kg_A3L = p.tyre.semitrailer.Fz(:, 5) / g;
tire_load_kg_A3R = p.tyre.semitrailer.Fz(:, 6) / g;

plot(p.time, tire_load_kg_A3L,  'b', 'LineWidth', 1.5);
hold on;
plot(p.time, tire_load_kg_A3R, 'r--', 'LineWidth', 1.5);
hold off;

grid on;
xlabel('Time [s]');
ylabel('Load [kg]');
legend('Axle 3 Left', 'Axle 3 Right');
title('Semitrailer Axle 3 Tire Loads');
%% Kingpin Load on 1G model and 2G (Fz)
figure;
plot(s.time,s.Vx*3.6)
hold on
plot(p.time,p.Vx*3.6)
axis auto;
hold off;
grid on;
xlabel('Time [s]');
ylabel('Speed [kmph]');
legend('2G Model','1G Model', 'Location', 'best');
title('Speed Output');

%local axis
figure;
plot(s.time, -s.semitrailer.kingpin.r1.fr.lc(:,3),'LineWidth', 1);
hold on
plot(s.time, -s.semitrailer.kingpin.r2.fr.lc(:,3),'LineWidth', 1);
plot(p.time, -p.semitrailer.kingpin.j1.ft(:,1),'LineWidth', 1);
axis auto;
hold off;
grid on;
xlabel('Time [s]');
ylabel('Load [N]');
legend('Kingpin Load - r1','Kingpin Load- r2','Kingpin load - uni J', 'Location', 'best');
title('Kingpin Load Local Axis');

%Global axis 
figure;
plot(s.time, -s.semitrailer.kingpin.r1.fr.gb(:,3),'LineWidth', 1);
hold on
plot(s.time, -s.semitrailer.kingpin.r2.fr.gb(:,3),'LineWidth', 1);
plot(p.time, -p.semitrailer.kingpin.j1.ft(:,1),'LineWidth', 1);
axis auto;
hold off;
grid on;
xlabel('Time [s]');
ylabel('Load [N]');
legend('Kingpin Load - r1','Kingpin Load- r2', 'Kingpin load - uni J', 'Location', 'best');
title('Kingpin Load Global Axis');
%% Fx 1G model and 2G (Fx)

%local axis
figure;
plot(s.time, s.semitrailer.kingpin.r1.fr.lc(:,1),'LineWidth', 1);
hold on
plot(s.time, s.semitrailer.kingpin.r2.fr.lc(:,1),'LineWidth', 1);
plot(p.time, -p.semitrailer.kingpin.j1.ft(:,3),'LineWidth', 1);
axis auto;
hold off;
grid on;
xlabel('Time [s]');
ylabel('Load [N]');
legend('Kingpin Load - r1','Kingpin Load- r2','Kingpin load - uni J', 'Location', 'best');
title('Kingpin Load Local Axis');

%Global axis 
figure;
plot(s.time, s.semitrailer.kingpin.r1.fr.gb(:,1),'LineWidth', 1);
hold on
plot(s.time, s.semitrailer.kingpin.r2.fr.gb(:,1),'LineWidth', 1);
plot(p.time, -p.semitrailer.kingpin.j1.ft(:,3),'LineWidth', 1);
axis auto;
hold off;
grid on;
xlabel('Time [s]');
ylabel('Load [N]');
legend('Kingpin Load - r1','Kingpin Load- r2', 'Kingpin load - uni J', 'Location', 'best');
title('Kingpin Load Global Axis');
%% Kingpin Load (Joint 1 +2) (Fz)
figure;
plot(s.time, s.semitrailer.kingpin.Fr(:,3),'LineWidth', 1);
hold on
plot(p.time, p.semitrailer.kingpin.j1.ft(:,1),'--','LineWidth', 1);
axis auto;
hold off;
grid on;
xlabel('Time [s]');
ylabel('Load [N]');
legend('Kingpin Load - 1G','Kingpin Load- 2G', 'Location', 'best');
title('Kingpin Load ');

% figure;
% plot(p.time, p.semitrailer.kingpin.j2.fc(:,3),'r', 'LineWidth', 1);
% hold on
% plot(p.time,p.semitrailer.kingpin.j2.ft(:,3), 'b--','LineWidth', 1);
% axis auto;
% hold off;
% grid on;
% xlabel('Time [s]');
% ylabel('Load [N]');
% legend('Kingpin Load - con','Kingpin Load - tot', 'Location', 'best');
% title('Kingpin Load - Joint 2 ');
%% Kingpin Force (Joint 1 +2) (Fx)
figure;
plot(s.time, -s.semitrailer.kingpin.Fr(:,1), 'LineWidth', 1);
hold on
plot(p.time, p.semitrailer.kingpin.j1.ft(:,3),'LineWidth', 1);
axis auto;
hold off;
grid on;
xlabel('Time [s]');
ylabel('Force [N]');
legend('Kingpin Force - 1G','Kingpin Force - 2G', 'Location', 'best');
title('Kingpin Force (Fx) - Joint 1 ');

% figure;
% plot(p.time, p.semitrailer.kingpin.j2.fc(:,1),'r', 'LineWidth', 1);
% hold on
% plot(p.time, p.semitrailer.kingpin.j2.ft(:,1), 'b--','LineWidth', 1);
% axis auto;
% hold off;
% grid on;
% xlabel('Time [s]');
% ylabel('Force [N]');
% legend('Kingpin Force - con','Kingpin Force - tot', 'Location', 'best');
% title('Kingpin Force (Fx) - Joint 2 ');

%% Kingpin + all tire forces Forces (Joint 1 +2) (Fx)
% Determine the index for 60 seconds or the closest time to 60 seconds
[~, idx60] = min(abs(p.time - 60));

% Create a figure for subplots
figure;

% Subplot for Kingpin Force (Fx) - Joint 1 
subplot(4, 2, 1);
hold on; % Hold on for multiple plots
p1 = plot(p.time, p.semitrailer.kingpin.j1.fc(:,3), 'r', 'LineWidth', 1);
p2 = plot(p.time, p.semitrailer.kingpin.j1.ft(:,3), 'b--', 'LineWidth', 1);
finalValue1 = p.semitrailer.kingpin.j1.fc(idx60,3);
finalValue2 = p.semitrailer.kingpin.j1.ft(idx60,3);
legend([p1, p2], {sprintf('Kingpin Force - con (Final: %.2f N)', finalValue1), sprintf('Kingpin Force - tot (Final: %.2f N)', finalValue2)}, 'Location', 'best');
title('Kingpin Force (Fx) - Joint 1');
xlabel('Time [s]');
ylabel('Force [N]');
grid on;


% Kingpin Force (Fx) - Joint 2
subplot(4, 2, 2);
hold on;
p3 = plot(p.time, p.semitrailer.kingpin.j2.fc(:,1), 'r', 'LineWidth', 1);
p4 = plot(p.time, p.semitrailer.kingpin.j2.ft(:,1), 'b--', 'LineWidth', 1);
finalValue3 = p.semitrailer.kingpin.j2.fc(idx60,1);
finalValue4 = p.semitrailer.kingpin.j2.ft(idx60,1);
legend([p3, p4], {sprintf('Kingpin Force - con (Final: %.2f N)', finalValue3), sprintf('Kingpin Force - tot (Final: %.2f N)', finalValue4)}, 'Location', 'best');
title('Kingpin Force (Fx) - Joint 2');
xlabel('Time [s]');
ylabel('Force [N]');
grid on;

% Steer Axle : Fx
subplot(4, 2, 3);
hold on;
p5 = plot(p.time, p.tyre.tractor.Fx(:,1), 'r', 'LineWidth', 1);
p6 = plot(p.time, p.tyre.tractor.Fx(:,2), 'b--', 'LineWidth', 1);
finalValue5 = p.tyre.tractor.Fx(idx60,1);
finalValue6 = p.tyre.tractor.Fx(idx60,2);
totalFinalValue3 = finalValue5 + finalValue6;
legend([p5, p6], {sprintf('Steer Axle (L) (Final: %.2f N)', finalValue5), sprintf('Steer Axle (R) (Final: %.2f N)', finalValue6)}, 'Location', 'best');
title('Steer Axle : Fx');
xlabel('Time [s]');
ylabel('Force [N]');
grid on;
text(60, p.tyre.tractor.Fx(idx60,1), sprintf('Total: %.2f N', totalFinalValue3), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'EdgeColor', 'black');

% Subplot for Drive Axle Outer: Fx
subplot(4, 2, 4);
hold on;
p7 = plot(p.time, p.tyre.tractor.Fx(:,3), 'r', 'LineWidth', 1);
p8 = plot(p.time, p.tyre.tractor.Fx(:,4), 'b--', 'LineWidth', 1);
finalValue7 = p.tyre.tractor.Fx(idx60,3);
finalValue8 = p.tyre.tractor.Fx(idx60,4);
totalFinalValue4 = finalValue7 + finalValue8;
legend([p7, p8], {sprintf('Drive Axle (L1) (Final: %.2f N)', finalValue7), sprintf('Drive Axle (R1) (Final: %.2f N)', finalValue8)}, 'Location', 'best');
title('Drive Axle Outer: Fx');
xlabel('Time [s]');
ylabel('Force [N]');
grid on;
text(60, p.tyre.tractor.Fx(idx60,3), sprintf('Total: %.2f N', totalFinalValue4), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'EdgeColor', 'black');

% Subplot for Drive Axle Inner: Fx
subplot(4, 2, 5);
hold on;
p9 = plot(p.time, p.tyre.tractor.Fx(:,5), 'r', 'LineWidth', 1);
p10 = plot(p.time, p.tyre.tractor.Fx(:,6), 'b--', 'LineWidth', 1);
finalValue9 = p.tyre.tractor.Fx(idx60,5);
finalValue10 = p.tyre.tractor.Fx(idx60,6);
totalFinalValue5 = finalValue9 + finalValue10;
legend([p9, p10], {sprintf('Drive Axle (L2) (Final: %.2f N)', finalValue9), sprintf('Drive Axle (R2) (Final: %.2f N)', finalValue10)}, 'Location', 'best');
title('Drive Axle Inner: Fx');
xlabel('Time [s]');
ylabel('Force [N]');
grid on;
text(60, p.tyre.tractor.Fx(idx60,5), sprintf('Total: %.2f N', totalFinalValue5), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'EdgeColor', 'black');

% Subplot for Trailer Axle 1: Fx
subplot(4, 2, 6);
hold on;
p9 = plot(p.time, p.tyre.semitrailer.Fx(:,1), 'r', 'LineWidth', 1);
p10 = plot(p.time, p.tyre.semitrailer.Fx(:,2), 'b--', 'LineWidth', 1);
finalValue11 = p.tyre.semitrailer.Fx(idx60,1);
finalValue12 = p.tyre.semitrailer.Fx(idx60,2);
totalFinalValue6 = finalValue11 + finalValue12;
legend([p9, p10], {sprintf('Trailer Axle (L) (Final: %.2f N)', finalValue11), sprintf('Trailer Axle (R) (Final: %.2f N)', finalValue12)}, 'Location', 'best');
title('Trailer Axle 1: Fx');
xlabel('Time [s]');
ylabel('Force [N]');
grid on;
text(60, p.tyre.semitrailer.Fx(idx60,1), sprintf('Total: %.2f N', totalFinalValue6), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'EdgeColor', 'black');

% Subplot for Trailer Axle 2: Fx
subplot(4, 2, 7);
hold on;
p11 = plot(p.time, p.tyre.semitrailer.Fx(:,3), 'r', 'LineWidth', 1);
p12 = plot(p.time, p.tyre.semitrailer.Fx(:,4), 'b--', 'LineWidth', 1);
finalValue13 = p.tyre.semitrailer.Fx(idx60,3);
finalValue14 = p.tyre.semitrailer.Fx(idx60,4);
totalFinalValue7 = finalValue13 + finalValue14;
legend([p11, p12], {sprintf('Trailer Axle (L) (Final: %.2f N)', finalValue13), sprintf('Trailer Axle (R) (Final: %.2f N)', finalValue14)}, 'Location', 'best');
title('Trailer Axle 2: Fx');
xlabel('Time [s]');
ylabel('Force [N]');
grid on;
text(60, p.tyre.semitrailer.Fx(idx60,3), sprintf('Total: %.2f N', totalFinalValue7), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'EdgeColor', 'black');

% Subplot for Trailer Axle 3: Fx
subplot(4, 2, 8);
hold on;
p13 = plot(p.time, p.tyre.semitrailer.Fx(:,5), 'r', 'LineWidth', 1);
p14 = plot(p.time, p.tyre.semitrailer.Fx(:,6), 'b--', 'LineWidth', 1);
finalValue15 = p.tyre.semitrailer.Fx(idx60,5);
finalValue16 = p.tyre.semitrailer.Fx(idx60,6);
totalFinalValue8 = finalValue15 + finalValue16;
legend([p13, p14], {sprintf('Trailer Axle (L) (Final: %.2f N)', finalValue15), sprintf('Trailer Axle (R) (Final: %.2f N)', finalValue16)}, 'Location', 'best');
title('Trailer Axle 3: Fx');
xlabel('Time [s]');
ylabel('Force [N]');
grid on;
text(60, p.tyre.semitrailer.Fx(idx60,5), sprintf('Total: %.2f N', totalFinalValue8), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'EdgeColor', 'black');

% Adjustments for better visibility and clarity
set(gcf, 'Position', get(0, 'Screensize'));

hold off; 

% Sum of all totalFinalValue variables for steady state forward driving forces
grandTotalSteadyStateForce = totalFinalValue3 + totalFinalValue4 + totalFinalValue5 + totalFinalValue6 + totalFinalValue7 + totalFinalValue8;

% Display the grand total in the MATLAB Command Window
disp(['Grand Total of All Tires: ', num2str(grandTotalSteadyStateForce), ' N']);

%% 1G Kingpin + all tire forces Forces (Joint 1 +2) (Fx)
% Determine the index for 60 seconds or the closest time to 60 seconds
[~, idx60] = min(abs(s.time - 60));

% Create a figure for subplots
figure;

% Subplot for Kingpin Force (Fx) - Joint 1 
subplot(4, 2, 1);
hold on; % Hold on for multiple plots
p1 = plot(s.time, s.semitrailer.kingpin.r1.fr.lc(:,1), 'r', 'LineWidth', 1);
p2 = plot(s.time, s.semitrailer.kingpin.r1.fr.gb(:,1), 'b--', 'LineWidth', 1);
finalValue1 = s.semitrailer.kingpin.r1.fr.lc(idx60,3);
finalValue2 = s.semitrailer.kingpin.r1.fr.gb(idx60,3);
legend([p1, p2], {sprintf('Kingpin Force - con (Final: %.2f N)', finalValue1), sprintf('Kingpin Force - tot (Final: %.2f N)', finalValue2)}, 'Location', 'best');
title('Kingpin Force (Fx) - Joint 1');
xlabel('Time [s]');
ylabel('Force [N]');
grid on;


% Kingpin Force (Fx) - Joint 2
subplot(4, 2, 2);
hold on;
p3 = plot(p.time, p.semitrailer.kingpin.j2.fc(:,1), 'r', 'LineWidth', 1);
p4 = plot(p.time, p.semitrailer.kingpin.j2.ft(:,1), 'b--', 'LineWidth', 1);
finalValue3 = p.semitrailer.kingpin.j2.fc(idx60,1);
finalValue4 = p.semitrailer.kingpin.j2.ft(idx60,1);
legend([p3, p4], {sprintf('Kingpin Force - con (Final: %.2f N)', finalValue3), sprintf('Kingpin Force - tot (Final: %.2f N)', finalValue4)}, 'Location', 'best');
title('Kingpin Force (Fx) - Joint 2');
xlabel('Time [s]');
ylabel('Force [N]');
grid on;

% Steer Axle : Fx
subplot(4, 2, 3);
hold on;
p5 = plot(s.time, s.tyre.tractor.Fx(:,1), 'r', 'LineWidth', 1);
p6 = plot(s.time, s.tyre.tractor.Fx(:,2), 'b--', 'LineWidth', 1);
finalValue5 = p.tyre.tractor.Fx(idx60,1);
finalValue6 = p.tyre.tractor.Fx(idx60,2);
totalFinalValue3 = finalValue5 + finalValue6;
legend([p5, p6], {sprintf('Steer Axle (L) (Final: %.2f N)', finalValue5), sprintf('Steer Axle (R) (Final: %.2f N)', finalValue6)}, 'Location', 'best');
title('Steer Axle : Fx');
xlabel('Time [s]');
ylabel('Force [N]');
grid on;
text(60, p.tyre.tractor.Fx(idx60,1), sprintf('Total: %.2f N', totalFinalValue3), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'EdgeColor', 'black');

% Subplot for Drive Axle Outer: Fx
subplot(4, 2, 4);
hold on;
p7 = plot(p.time, p.tyre.tractor.Fx(:,3), 'r', 'LineWidth', 1);
p8 = plot(p.time, p.tyre.tractor.Fx(:,4), 'b--', 'LineWidth', 1);
finalValue7 = p.tyre.tractor.Fx(idx60,3);
finalValue8 = p.tyre.tractor.Fx(idx60,4);
totalFinalValue4 = finalValue7 + finalValue8;
legend([p7, p8], {sprintf('Drive Axle (L1) (Final: %.2f N)', finalValue7), sprintf('Drive Axle (R1) (Final: %.2f N)', finalValue8)}, 'Location', 'best');
title('Drive Axle Outer: Fx');
xlabel('Time [s]');
ylabel('Force [N]');
grid on;
text(60, p.tyre.tractor.Fx(idx60,3), sprintf('Total: %.2f N', totalFinalValue4), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'EdgeColor', 'black');

% Subplot for Drive Axle Inner: Fx
subplot(4, 2, 5);
hold on;
p9 = plot(p.time, p.tyre.tractor.Fx(:,5), 'r', 'LineWidth', 1);
p10 = plot(p.time, p.tyre.tractor.Fx(:,6), 'b--', 'LineWidth', 1);
finalValue9 = p.tyre.tractor.Fx(idx60,5);
finalValue10 = p.tyre.tractor.Fx(idx60,6);
totalFinalValue5 = finalValue9 + finalValue10;
legend([p9, p10], {sprintf('Drive Axle (L2) (Final: %.2f N)', finalValue9), sprintf('Drive Axle (R2) (Final: %.2f N)', finalValue10)}, 'Location', 'best');
title('Drive Axle Inner: Fx');
xlabel('Time [s]');
ylabel('Force [N]');
grid on;
text(60, p.tyre.tractor.Fx(idx60,5), sprintf('Total: %.2f N', totalFinalValue5), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'EdgeColor', 'black');

% Subplot for Trailer Axle 1: Fx
subplot(4, 2, 6);
hold on;
p9 = plot(p.time, p.tyre.semitrailer.Fx(:,1), 'r', 'LineWidth', 1);
p10 = plot(p.time, p.tyre.semitrailer.Fx(:,2), 'b--', 'LineWidth', 1);
finalValue11 = p.tyre.semitrailer.Fx(idx60,1);
finalValue12 = p.tyre.semitrailer.Fx(idx60,2);
totalFinalValue6 = finalValue11 + finalValue12;
legend([p9, p10], {sprintf('Trailer Axle (L) (Final: %.2f N)', finalValue11), sprintf('Trailer Axle (R) (Final: %.2f N)', finalValue12)}, 'Location', 'best');
title('Trailer Axle 1: Fx');
xlabel('Time [s]');
ylabel('Force [N]');
grid on;
text(60, p.tyre.semitrailer.Fx(idx60,1), sprintf('Total: %.2f N', totalFinalValue6), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'EdgeColor', 'black');

% Subplot for Trailer Axle 2: Fx
subplot(4, 2, 7);
hold on;
p11 = plot(p.time, p.tyre.semitrailer.Fx(:,3), 'r', 'LineWidth', 1);
p12 = plot(p.time, p.tyre.semitrailer.Fx(:,4), 'b--', 'LineWidth', 1);
finalValue13 = p.tyre.semitrailer.Fx(idx60,3);
finalValue14 = p.tyre.semitrailer.Fx(idx60,4);
totalFinalValue7 = finalValue13 + finalValue14;
legend([p11, p12], {sprintf('Trailer Axle (L) (Final: %.2f N)', finalValue13), sprintf('Trailer Axle (R) (Final: %.2f N)', finalValue14)}, 'Location', 'best');
title('Trailer Axle 2: Fx');
xlabel('Time [s]');
ylabel('Force [N]');
grid on;
text(60, p.tyre.semitrailer.Fx(idx60,3), sprintf('Total: %.2f N', totalFinalValue7), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'EdgeColor', 'black');

% Subplot for Trailer Axle 3: Fx
subplot(4, 2, 8);
hold on;
p13 = plot(p.time, p.tyre.semitrailer.Fx(:,5), 'r', 'LineWidth', 1);
p14 = plot(p.time, p.tyre.semitrailer.Fx(:,6), 'b--', 'LineWidth', 1);
finalValue15 = p.tyre.semitrailer.Fx(idx60,5);
finalValue16 = p.tyre.semitrailer.Fx(idx60,6);
totalFinalValue8 = finalValue15 + finalValue16;
legend([p13, p14], {sprintf('Trailer Axle (L) (Final: %.2f N)', finalValue15), sprintf('Trailer Axle (R) (Final: %.2f N)', finalValue16)}, 'Location', 'best');
title('Trailer Axle 3: Fx');
xlabel('Time [s]');
ylabel('Force [N]');
grid on;
text(60, p.tyre.semitrailer.Fx(idx60,5), sprintf('Total: %.2f N', totalFinalValue8), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'EdgeColor', 'black');

% Adjustments for better visibility and clarity
set(gcf, 'Position', get(0, 'Screensize'));

hold off; 

% Sum of all totalFinalValue variables for steady state forward driving forces
grandTotalSteadyStateForce = totalFinalValue3 + totalFinalValue4 + totalFinalValue5 + totalFinalValue6 + totalFinalValue7 + totalFinalValue8;

% Display the grand total in the MATLAB Command Window
disp(['Grand Total of All Tires: ', num2str(grandTotalSteadyStateForce), ' N']);

