load ../simresults/LZV_A_Roll.mat

subplot(2,2,1)
plot(s.time,s.inputs.delta*180/pi,'LineWidth',1.5);
title('Steering wheel angle');
xlabel('t [s]');
ylabel('\delta [deg]');
grid on;

subplot(2,2,2)
plot(s.time,s.Vx,'LineWidth',1.5);
title('Forward velocity');
xlabel('t [s]');
ylabel('Vx [m/s]');
grid on;

subplot(2,2,3)
plot(s.time,s.steeraxle.acc(:,2),'b-',s.time,s.drawbartraileraxle2.acc(:,2),'k--','LineWidth',1.5);
grid on;
legend('Steer axle','drawbar trailer axle2',1);
title('Lateral accelerations of the first and last axle');
xlabel('t [s]');ylabel('ay [m/s2]');

%%% Calculation of Dynamic Load Transfer Ratio (DLTR) %%%

subplot(2,2,4)

DLTR1=(s.tyre.Fz(:,1)-s.tyre.Fz(:,2)+s.tyre.Fz(:,3)+s.tyre.Fz(:,4)-s.tyre.Fz(:,5)-s.tyre.Fz(:,6))...
       ./(s.tyre.Fz(:,1)+s.tyre.Fz(:,2)+s.tyre.Fz(:,3)+s.tyre.Fz(:,4)+s.tyre.Fz(:,5)+s.tyre.Fz(:,6));

DLTR2=(s.semitrailer.Fz(:,1)-s.semitrailer.Fz(:,2)+s.semitrailer.Fz(:,3)-s.semitrailer.Fz(:,4)+s.semitrailer.Fz(:,5)-s.semitrailer.Fz(:,6))...
       ./(s.semitrailer.Fz(:,1)+s.semitrailer.Fz(:,2)+s.semitrailer.Fz(:,3)+s.semitrailer.Fz(:,4)+s.semitrailer.Fz(:,5)+s.semitrailer.Fz(:,6));
   
DLTR3=(s.trailer.Fz(:,1)-s.trailer.Fz(:,2)+s.trailer.Fz(:,3)-s.trailer.Fz(:,4))./(s.trailer.Fz(:,1)+s.trailer.Fz(:,2)+s.trailer.Fz(:,3)+s.trailer.Fz(:,4));

plot(s.time,DLTR1,s.time,DLTR2,s.time,DLTR3,'LineWidth',1.5);
title('Dynamic load transfer ratio');
grid
xlabel('t [s]');
ylabel('DLTR [-]')
legend('tractor','semi-trailer','drawbar trailer');

idx1=find(DLTR1 < -0.999 );
idx2=find(DLTR2 < -0.999 );
idx3=find(DLTR3 < -0.999 );

idx=min([ idx1' idx2' idx3']);
s.time(idx)
s.Vx(idx)
s.steeraxle.acc(idx,2)
s.drawbartraileraxle2.acc(idx,2)

print -depsc -tiff ro_LZV_A
