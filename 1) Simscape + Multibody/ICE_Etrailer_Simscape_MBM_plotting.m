%% ICE Plotting file:
%  last updated: 03/12/2024

close all

%$ Drive Cycle speed & Driver inputs
figure(1)
subplot(2,1,1);
plot(p.time,p.velocity.reference.*3.6,'k','LineWidth',1.1);
hold on;
plot(p.time,p.velocity.actual.*3.6,'r','LineWidth',1.1);
xlabel('time [s]');
ylabel('Velocity [km/h]');
title('DriveCycle speed');
grid on;
legend('Reference Speed','Tractor-Semi Speed')
xlim([0 tmax]);
ylim([0 100]);
    
subplot(2,1,2);
plot(p.time,p.inputs.throttle,'k','LineWidth',1.1); 
hold on
plot(p.time,p.inputs.brake,'r','LineWidth',1.1);
xlabel('time [s]');
ylabel('Pedal percentage [%]');
avg_throttle = mean(p.inputs.throttle);
avg_brake = mean(p.inputs.brake);
title(['Driver Inputs over time: avg. throttle pos. is ',num2str(avg_throttle),'%']);
grid on;
xlim([0 tmax]);
ylim([0 105]);
yline(avg_throttle,'k--','LineWidth',1.1);
legend('Throttle [%]','Brake [%]','Avg. Throttle position');

%% Battery Information
figure(2)
subplot(3,1,1);
plot(p.time,p.battery.current,'r','LineWidth',1);
xlabel('time [s]');
ylabel('Battery current [A]')
% ylim([-400 100]);
title('Battery current over time');
yline(0,'k--','LineWidth',1.1)
grid on;
xlim([0 tmax]);

subplot(3,1,3);
plot(p.time,p.battery.SOCcalc,'r','LineWidth',1);
xlabel('time [s]');
ylabel('Battery SOC [%]')
title('Battery SOC over time');
grid on;
xlim([0 tmax]);
    
subplot(3,1,2);
plot(p.time,p.battery.Voltage,'r','LineWidth',1);
ylabel('Battery Voltage [V]')
title('Battery Voltage over time');
grid on;
xlim([0 tmax]);
    
%% Torque Request & E-trailer Driveline torques
% figure(3)
% subplot(2,1,1)
% plot(p.time,p.Etrailercontrol.TrqReq,'r','LineWidth',1);
% xlabel('time [s]');
% ylabel('Torque [Nm]')
% title('E-motor Torque Request over time');
% yline(0,'k--','LineWidth',1.1);
% grid on;
% xlim([0 tmax]);
% 
% subplot(2,1,2)
% plot(p.time,p.DriveL.TrqSum,'b','LineWidth',1);
% hold on;
% plot(p.time,p.DriveR.TrqSum,'r--','LineWidth',1);
% yline(0,'k--','LineWidth',1.1)
% xlabel('time [s]');
% ylabel('Torque [Nm]')
% title('Driveline Torques over time');
% legend('Driveline Torque L','Driveline Torque R');
% grid on;
% % ylim([-2300 3000]);
% xlim([0 tmax]);
    
%% Tractor engine & transmission information
figure(4)
subplot(3,1,2);
plot(p.time,p.tractorengine.PowerPeReal,'.k','LineWidth',1);
hold on
plot(p.time,p.Etrailercontrol.PeEst,'.r','LineWidth',0.5);
xlabel('time [s]');
ylabel('Engine Power [kW]')
title('E-motor Torque Request over time');
grid on;
legend('exact','estimated');
xlim([0 tmax]);

subplot(3,1,3);
plot(p.time,p.tractorengine.RPM,'.k','LineWidth',1.5);
xlabel('time [s]');
ylabel('Engine speed [rpm]');
title('Tractor Engine speed over time');
grid on;
xlim([0 tmax]);
ylim([0 2000]);

subplot(3,1,1);
plot(p.time,p.tractorengine.Torque,'r','LineWidth',1.5);
xlabel('time [s]');
ylabel('Engine torque [Nm]');
title('Tractor Engine torque over time');
grid on;
xlim([0 tmax]);

%% Temperature Plotting:

% if trailer_ID == 1
% 
%     % Temperature information:
%     figure(5)
%     subplot(3,1,1)
%     plot(p.time,p.battery.temperature,'r','LineWidth',1);
%     xlabel('time [s]');
%     ylabel('Battery temperature [C]');
%     title('Battery temperature over time');
%     grid on;
%     xlim([0 tmax]);
% 
%     % subplot(3,1,3)
%     % plot(p.time,p.inverter.temperature,'r','LineWidth',1);
%     % xlabel('time [s]');
%     % ylabel('Inverter temperature [C]');
%     % title('Inverter temperature over time');
%     % grid on;
%     % xlim([0 tmax]);
% 
%     subplot(3,1,2)
%     plot(p.time,p.Emotor.temperature,'r','LineWidth',1);
%     xlabel('time [s]');
%     ylabel('E-motor temperature [C]');
%     title('E-motor temperature over time');
%     grid on;
%     xlim([0 tmax]);
% 
% else
%     % Temperature information:
%     figure(5)
%     subplot(3,1,1)
%     plot(p.time,p.battery.temperature,'r','LineWidth',1);
%     xlabel('time [s]');
%     ylabel('Battery temperature [C]');
%     title('Battery temperature over time');
%     grid on;
%     xlim([0 tmax]);
% 
%     % subplot(3,1,3)
%     % plot(p.time,p.inverter.temperature,'r','LineWidth',1);
%     % xlabel('time [s]');
%     % ylabel('Inverter temperature [C]');
%     % title('Inverter temperature over time');
%     % grid on;
%     % xlim([0 tmax]);
% 
%     subplot(3,1,2)
%     plot(p.time,p.Emotor.temperatureL,'r','LineWidth',1);
%     hold on
%     plot(p.time,p.Emotor.temperatureR,'k','LineWidth',1);
%     xlabel('time [s]');
%     ylabel('E-motor temperatures [C]');
%     title('E-motor temperature over time');
%     grid on;
%     legend('Motor L','Motor R');
%     xlim([0 tmax]);
% end

%% WP3a Control
figure(6)
subplot(2,2,[1 2]);
plot(p.time,p.Etrailercontrol.TrqReq,'.r','LineWidth',1);
xlabel('time [s]');
ylabel('Torque [Nm]')
title('E-motor Torque Request over time');
yline(0,'k--','LineWidth',1.1);
grid on;
xlim([0 tmax]);

subplot(2,2,3);
plot(p.time,p.velocity.reference,'k','LineWidth',1.5);
xlabel('time [s]');
% ylabel('Velocity [km/h]');
title('DriveCycle input speed and acceleration');
grid on;
legend('input speed [m/s]');
xlim([0 tmax]);

subplot(2,2,4);
plot(p.Etrailercontrol.PeEst,p.Etrailercontrol.TrqReqWP3a,'.r','LineWidth',0.5)
xlabel('Engine Power [kW]');
ylabel('Torque Request [Nm]');
title ('Tm over Pe');
grid on;
ylim([-400 400]);

%% SOC & Fuel consumption

figure(7)
subplot(2,2,1);
plot(p.time,p.battery.SOCcalc,'r','LineWidth',1);
xlabel('time [s]');
ylabel('Battery SOC [%]')
title('Battery SOC over time');
grid on;
xlim([0 tmax]);

fuelcons = round(p.tractorengine.fuelcons(end),2);
subplot(2,2,2);
plot(p.time,p.tractorengine.fuelcons,'r','LineWidth',1.5);
xlabel('time [s]');
ylabel('Fuel consumption [L]');
title(['Total tractor Engine fuel cons. is ',num2str(fuelcons),'l']);
grid on;
xlim([0 tmax]);

subplot(2,2,[3 4]);
plot(p.time,p.semitrailer.kingpin.j1.fc(:,3),'.k','LineWidth',1.5);
yline(0,'k--','LineWidth',1)
xlabel('time [s]');
ylabel('Long. kingpin force [N]');
title('Longitudinal kingpin force over time');
grid on;
xlim([0 tmax]);

