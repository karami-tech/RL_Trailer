figure(1)
subplot(4,2,2)
plot(DrCycles.C505(:,1),DrCycles.C505(:,2).*1.609344,'r','LineWidth',1.1)
ylabel('Speed [km/h]');
xlabel('Time [sec]');
grid on;
title('2: C505 Drivecycle')

subplot(4,2,1)
plot(DrCycles.FTP(:,1),DrCycles.FTP(:,2).*1.609344,'r','LineWidth',1.1)
ylabel('Speed [km/h]');
xlabel('Time [sec]');
grid on;
title('1: FTP Drivecycle')

subplot(4,2,3)
plot(DrCycles.UDDS(:,1),DrCycles.UDDS(:,2).*1.609344,'r','LineWidth',1.1)
ylabel('Speed [km/h]');
xlabel('Time [sec]');
grid on;
title('3: UDDS Drivecycle')

subplot(4,2,4)
plot(DrCycles.HWFET(:,1),DrCycles.HWFET(:,2).*1.609344,'r','LineWidth',1.1)
ylabel('Speed [km/h]');
xlabel('Time [sec]');
grid on;
title('4: HWFET Drivecycle')

subplot(4,2,5)
plot(DrCycles.US06(:,1),DrCycles.US06(:,2).*1.609344,'r','LineWidth',1.1)
ylabel('Speed [km/h]');
xlabel('Time [sec]');
grid on;
title('5: US06 Drivecycle')

subplot(4,2,6)
plot(DrCycles.US06City(:,1),DrCycles.US06City(:,2).*1.609344,'r','LineWidth',1.1)
ylabel('Speed [km/h]');
xlabel('Time [sec]');
grid on;
title('6: US06City Drivecycle')

subplot(4,2,7)
plot(DrCycles.US06Hwy(:,1),DrCycles.US06Hwy(:,2).*1.609344,'r','LineWidth',1.1)
ylabel('Speed [km/h]');
xlabel('Time [sec]');
grid on;
title('7: US06Hwy Drivecycle')