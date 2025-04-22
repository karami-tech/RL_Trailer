%% Comparing script for further analysis:
close all
clear all

% Loading data:
load('comp_BURGERS.mat');
load('comp_BURGERS2.mat');
load('comp_KRAKER.mat');

%% Plotting:

% Fuel consumption comparison:

fuelconsBURGERSA = round(fuel_BURGERS_A(end),2);
fuelconsBURGERSB = round(fuel_BURGERS_B(end),2);
fuelconsKRAKERA = round(fuel_KRAKER_A(end),2);
fuelconsKRAKERB = round(fuel_KRAKER_B(end),2);

%%
figure(1)
plot(pBURGERS.time,fuel_BURGERS_B,'k--','LineWidth',1.2);
hold on
plot(pBURGERS.time,fuel_BURGERS_A,'k','LineWidth',1.2);
hold on
plot(pKRAKER.time,fuel_KRAKER_B,'r--','LineWidth',1.2);
hold on
plot(pKRAKER.time,fuel_KRAKER_A,'r','LineWidth',1.2);

xlabel('time [s]');
ylabel('Fuel consumption [L]');
title('Total tractor Engine fuel consumption');
grid on;
legend(['BURGER E-trailer OFF ',num2str(fuelconsBURGERSB),'l'],['BURGERS E-trailer ON ',num2str(fuelconsBURGERSA),'l'],['KRAKER E-trailer OFF ',num2str(fuelconsKRAKERB),'l'],['KRAKER E-trailer ON ',num2str(fuelconsKRAKERA),'l'],'Location','northwest');
xlim([0 506]);

figure(2)
plot(pBURGERS.time,SOC_BURGERS_A,'k','LineWidth',1.2);
hold on
plot(pKRAKER.time,SOC_KRAKER_A,'r','LineWidth',1.2);
xlabel('time [s]');
ylabel('SOC [%]');
title('Batterypack SOC over time');
grid on;
legend('BURGERS','KRAKER','Location','northeast');
xlim([0 506]);