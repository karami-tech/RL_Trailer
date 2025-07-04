load ../simresults/LZV_D_Model_1G_2G_StaticsL0.mat
%% 1G Model
idx=find(s.time>9);

Fz_front_axle1    = mean(s.tyre.Fz(idx,1))+ mean(s.tyre.Fz(idx,2));
Fz_rear_axle1     = mean(s.tyre.Fz(idx,3))+ mean(s.tyre.Fz(idx,4)+s.tyre.Fz(idx,5))+ mean(s.tyre.Fz(idx,6));
Fz_rear_axle2     = mean(s.tyre.Fz(idx,7))+ mean(s.tyre.Fz(idx,8)+s.tyre.Fz(idx,9))+ mean(s.tyre.Fz(idx,10));

Fz_dolly_axle1    = mean(s.dolly.Fz(idx,1))+ mean(s.dolly.Fz(idx,2));
Fz_dolly_axle2    = mean(s.dolly.Fz(idx,3))+ mean(s.dolly.Fz(idx,4));

Fz_trailer1_axle1 = mean(s.semitrailer.Fz(idx,1))+ mean(s.semitrailer.Fz(idx,2));
Fz_trailer1_axle2 = mean(s.semitrailer.Fz(idx,3))+ mean(s.semitrailer.Fz(idx,4));
Fz_trailer1_axle3 = mean(s.semitrailer.Fz(idx,5))+ mean(s.semitrailer.Fz(idx,6));

mass=(Fz_front_axle1+Fz_rear_axle1+Fz_rear_axle2+...
      Fz_dolly_axle1+Fz_dolly_axle2+...
      Fz_trailer1_axle1+Fz_trailer1_axle2+Fz_trailer1_axle3)/9.81;

disp('')
disp('Static axle loads LZV D - 1G');
disp(sprintf('--------------------------------------'));
disp(sprintf('Front axle1       %6.0f N (%6.0f kg)',Fz_front_axle1,Fz_front_axle1/9.81));
disp(sprintf('Rear axle1        %6.0f N (%6.0f kg)',Fz_rear_axle1,Fz_rear_axle1/9.81));
disp(sprintf('Rear axle2        %6.0f N (%6.0f kg)',Fz_rear_axle2,Fz_rear_axle2/9.81));
disp(sprintf('Dolly axle1       %6.0f N (%6.0f kg)',Fz_dolly_axle1,Fz_dolly_axle1/9.81));
disp(sprintf('Dolly axle2       %6.0f N (%6.0f kg)',Fz_dolly_axle2,Fz_dolly_axle2/9.81));
disp(sprintf('Trailer axle1     %6.0f N (%6.0f kg)',Fz_trailer1_axle1,Fz_trailer1_axle1/9.81));
disp(sprintf('Trailer axle2     %6.0f N (%6.0f kg)',Fz_trailer1_axle2,Fz_trailer1_axle2/9.81));
disp(sprintf('Trailer axle3     %6.0f N (%6.0f kg)',Fz_trailer1_axle3,Fz_trailer1_axle3/9.81));
disp(sprintf('--------------------------------------'));
disp(sprintf('total mass                  %6.0f kg ',mass));
%% 2G Model
idx2=find(p.time>9);

Fz_front_axle1    = mean(p.tyre.Fz(idx2,1))+ mean(p.tyre.Fz(idx2,2));
Fz_rear_axle1     = mean(p.tyre.Fz(idx2,3))+ mean(p.tyre.Fz(idx2,4)+p.tyre.Fz(idx2,5))+ mean(p.tyre.Fz(idx2,6));
Fz_rear_axle2     = mean(p.tyre.Fz(idx2,7))+ mean(p.tyre.Fz(idx2,8)+p.tyre.Fz(idx2,9))+ mean(p.tyre.Fz(idx2,10));

Fz_dolly_axle1    = mean(p.trailer1.Fz(idx2,1))+ mean(p.trailer1.Fz(idx2,2));
Fz_dolly_axle2    = mean(p.trailer1.Fz(idx2,3))+ mean(p.trailer1.Fz(idx2,4));

Fz_trailer1_axle1 = mean(p.semitrailer.Fz(idx2,1))+ mean(p.semitrailer.Fz(idx2,2));
Fz_trailer1_axle2 = mean(p.semitrailer.Fz(idx2,3))+ mean(p.semitrailer.Fz(idx2,4));
Fz_trailer1_axle3 = mean(p.semitrailer.Fz(idx2,5))+ mean(p.semitrailer.Fz(idx2,6));

mass=(Fz_front_axle1+Fz_rear_axle1+Fz_rear_axle2+...
      Fz_dolly_axle1+Fz_dolly_axle2+...
      Fz_trailer1_axle1+Fz_trailer1_axle2+Fz_trailer1_axle3)/9.81;

disp('')
disp('Static axle loads LZV D - 2G');
disp(sprintf('--------------------------------------'));
disp(sprintf('Front axle1       %6.0f N (%6.0f kg)',Fz_front_axle1,Fz_front_axle1/9.81));
disp(sprintf('Rear axle1        %6.0f N (%6.0f kg)',Fz_rear_axle1,Fz_rear_axle1/9.81));
disp(sprintf('Rear axle2        %6.0f N (%6.0f kg)',Fz_rear_axle2,Fz_rear_axle2/9.81));
disp(sprintf('Dolly axle1       %6.0f N (%6.0f kg)',Fz_dolly_axle1,Fz_dolly_axle1/9.81));
disp(sprintf('Dolly axle2       %6.0f N (%6.0f kg)',Fz_dolly_axle2,Fz_dolly_axle2/9.81));
disp(sprintf('Trailer axle1     %6.0f N (%6.0f kg)',Fz_trailer1_axle1,Fz_trailer1_axle1/9.81));
disp(sprintf('Trailer axle2     %6.0f N (%6.0f kg)',Fz_trailer1_axle2,Fz_trailer1_axle2/9.81));
disp(sprintf('Trailer axle3     %6.0f N (%6.0f kg)',Fz_trailer1_axle3,Fz_trailer1_axle3/9.81));
disp(sprintf('--------------------------------------'));
disp(sprintf('total mass                  %6.0f kg ',mass));