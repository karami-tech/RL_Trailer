load ../simresults/LZV_B_roll.mat

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
plot(s.time,s.steeraxle.acc(:,2),'b-',s.time,s.semitrailer2axle3.acc(:,2),'k--','LineWidth',1.5);
grid on;
legend('Steer axle','semi-trailer 2 axle3',1);
title('Lateral accelerations of the first and last axle');
xlabel('t [s]');ylabel('ay [m/s2]');

%%% Calculation of Dynamic Load Transfer Ratio (DLTR) %%%

subplot(2,2,4)

DLTR1=(s.tyre.Fz(:,1)-s.tyre.Fz(:,2)+s.tyre.Fz(:,3)+s.tyre.Fz(:,4)-s.tyre.Fz(:,5)-s.tyre.Fz(:,6))...
       ./(s.tyre.Fz(:,1)+s.tyre.Fz(:,2)+s.tyre.Fz(:,3)+s.tyre.Fz(:,4)+s.tyre.Fz(:,5)+s.tyre.Fz(:,6));

DLTR2=(s.semitrailer1.Fz(:,1)-s.semitrailer1.Fz(:,2)+s.semitrailer1.Fz(:,3)-s.semitrailer1.Fz(:,4)+s.semitrailer1.Fz(:,5)-s.semitrailer1.Fz(:,6))...
       ./(s.semitrailer1.Fz(:,1)+s.semitrailer1.Fz(:,2)+s.semitrailer1.Fz(:,3)+s.semitrailer1.Fz(:,4)+s.semitrailer1.Fz(:,5)+s.semitrailer1.Fz(:,6));
   
DLTR3=(s.semitrailer2.Fz(:,1)-s.semitrailer2.Fz(:,2)+s.semitrailer2.Fz(:,3)-s.semitrailer2.Fz(:,4)+s.semitrailer2.Fz(:,5)-s.semitrailer2.Fz(:,6))...
       ./(s.semitrailer2.Fz(:,1)+s.semitrailer2.Fz(:,2)+s.semitrailer2.Fz(:,3)+s.semitrailer2.Fz(:,4)+s.semitrailer2.Fz(:,5)+s.semitrailer2.Fz(:,6));

plot(s.time,DLTR1,s.time,DLTR2,s.time,DLTR3,'LineWidth',1.5);
title('Dynamic load transfer ratio');
grid
xlabel('t [s]');
ylabel('DLTR [-]')
legend('tractor','semi-trailer 1','semi-trailer 2');

idx1=find(DLTR1 < -0.999 );
idx2=find(DLTR2 < -0.999 );
idx3=find(DLTR3 < -0.999 );

idx=min([ idx1' idx2' idx3']);
s.time(idx)
s.Vx(idx)
s.steeraxle.acc(idx,2)
s.semitrailer2axle3.acc(idx,2)

print -depsc -tiff ro_LZV_B
