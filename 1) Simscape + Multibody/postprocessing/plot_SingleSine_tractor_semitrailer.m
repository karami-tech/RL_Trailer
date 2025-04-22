load ../simresults/Tractor_Semitrailer_Model_1G_2G_Test_SingleSine_v88_f40.mat

%% Steering and Lateral axle pos
figure()
subplot(1,2,1)
plot(s.time,s.inputs.delta*180/pi,'LineWidth',1.5);
hold on 
plot(p.time,p.inputs.delta*180/pi,'--','LineWidth',1.5);
hold off,legend('1G Model','2G Model')
title('Steering wheel angle');
xlabel('Time [s]');
ylabel('\delta [deg]');
grid on;

subplot(1,2,2)
plot(s.time,s.steeraxle.pos(:,2),'LineWidth',1.5);
hold on 
plot(s.time,s.semitraileraxle3.pos(:,2),'Color',[0.3010 0.7450 0.9330],'LineWidth',1.5);
plot(p.time,p.steeraxle.pos(:,2),'r--','LineWidth',1.5);
plot(p.time,p.semitraileraxle3.pos(:,2),'--','Color',[0.6350 0.0780 0.1840],'LineWidth',1.5)
hold off,legend('1G - Steer axle ','1G - Trailer axle 3','2G - Steer axle','2G - Trailer axle 3','location','best')
title('Lateral axle position');
xlabel('Time [s]');
ylabel('y axle [m]');
grid on;

idx = find(s.time > 10 & s.time < 12);
ypos=mean(s.steeraxle.pos(idx,2))

idx2 = find(p.time > 10 & p.time < 12);
ypos2=mean(p.steeraxle.pos(idx2,2))

%% Calculation of Rearward Amplification (RA) %%%

figure()
plot(s.time,s.steeraxle.acc(:,2),'LineWidth',1.5)
hold on
plot(s.time,s.semitraileraxle3.acc(:,2),'Color',[0.3010 0.7450 0.9330],'LineWidth',1.5);
plot(p.time,p.steeraxle.acc(:,2),'r--','LineWidth',1.5)
plot(p.time,p.semitraileraxle3.acc(:,2),'--','Color',[0.6350 0.0780 0.1840],'LineWidth',1);
hold off,grid on;
legend('1G - Steer axle','1G - Trailer axle 3','2G - Steer axle','2G - Trailer axle 3');
title('Lateral acceleration');
xlabel('Time [s]');ylabel('ay [m/s^2]');

RA=max(abs(s.semitraileraxle3.acc(:,2)))/max(abs(s.steeraxle.acc(:,2)))
RA2=max(abs(p.semitraileraxle3.acc(:,2)))/max(abs(p.steeraxle.acc(:,2)))

%% Calculation of Dynamic Load Transfer Ratio (DLTR) %%%

figure()

DLTR1=(s.tyre.Fz(:,1)-s.tyre.Fz(:,2)+s.tyre.Fz(:,3)+s.tyre.Fz(:,4)-s.tyre.Fz(:,5)-s.tyre.Fz(:,6))...
       ./(s.tyre.Fz(:,1)+s.tyre.Fz(:,2)+s.tyre.Fz(:,3)+s.tyre.Fz(:,4)+s.tyre.Fz(:,5)+s.tyre.Fz(:,6));

DLTR2=(s.semitrailer.Fz(:,1)-s.semitrailer.Fz(:,2)+s.semitrailer.Fz(:,3)-s.semitrailer.Fz(:,4)+s.semitrailer.Fz(:,5)-s.semitrailer.Fz(:,6))...
       ./(s.semitrailer.Fz(:,1)+s.semitrailer.Fz(:,2)+s.semitrailer.Fz(:,3)+s.semitrailer.Fz(:,4)+s.semitrailer.Fz(:,5)+s.semitrailer.Fz(:,6));

DLTR3=(p.tyre.Fz(:,1)-p.tyre.Fz(:,2)+p.tyre.Fz(:,3)+p.tyre.Fz(:,4)-p.tyre.Fz(:,5)-p.tyre.Fz(:,6))...
       ./(p.tyre.Fz(:,1)+p.tyre.Fz(:,2)+p.tyre.Fz(:,3)+p.tyre.Fz(:,4)+p.tyre.Fz(:,5)+p.tyre.Fz(:,6));

DLTR4=(p.semitrailer.Fz(:,1)-p.semitrailer.Fz(:,2)+p.semitrailer.Fz(:,3)-p.semitrailer.Fz(:,4)+p.semitrailer.Fz(:,5)-p.semitrailer.Fz(:,6))...
       ./(p.semitrailer.Fz(:,1)+p.semitrailer.Fz(:,2)+p.semitrailer.Fz(:,3)+p.semitrailer.Fz(:,4)+p.semitrailer.Fz(:,5)+p.semitrailer.Fz(:,6));

plot(s.time,DLTR1,'LineWidth',1.5)
hold on 
plot(s.time,DLTR2 ,'Color',[0.3010 0.7450 0.9330],'LineWidth',1.5)
plot(p.time,DLTR3,'r--','LineWidth',1.5)
plot(p.time,DLTR4,'--','Color',[0.6350 0.0780 0.1840],'LineWidth',1.5)
hold off
title('Dynamic load transfer ratio');
grid on
xlabel('Time [s]');
ylabel('DLTR [-]')
legend('1G - DLTR tractor','1G - DLTR semi-trailer','2G - DLTR tractor','2G - DLTR semi-trailer');

DLTR1=max(abs(DLTR1))
DLTR2=max(abs(DLTR2))
DLTR3=max(abs(DLTR3))
DLTR4=max(abs(DLTR4))


print -depsc -tiff ss_tractor_semitrailer
