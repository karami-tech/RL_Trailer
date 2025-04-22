%% 1G Model 
idx=find(s.time>9);

Fz_front_axle    = mean(s.tyre.Fz(idx,1))+ mean(s.tyre.Fz(idx,2));
Fz_rear_axle     = mean(s.tyre.Fz(idx,3))+ mean(s.tyre.Fz(idx,4)+s.tyre.Fz(idx,5))+ mean(s.tyre.Fz(idx,6));

Fz_semitrailer1_axle1 = mean(s.semitrailer.Fz(idx,1))+ mean(s.semitrailer.Fz(idx,2));
Fz_semitrailer1_axle2 = mean(s.semitrailer.Fz(idx,3))+ mean(s.semitrailer.Fz(idx,4));
Fz_semitrailer1_axle3 = mean(s.semitrailer.Fz(idx,5))+ mean(s.semitrailer.Fz(idx,6));

Fz_semitrailer2_axle1 = mean(s.semitrailer2.Fz(idx,1))+ mean(s.semitrailer2.Fz(idx,2));
Fz_semitrailer2_axle2 = mean(s.semitrailer2.Fz(idx,3))+ mean(s.semitrailer2.Fz(idx,4));
Fz_semitrailer2_axle3 = mean(s.semitrailer2.Fz(idx,5))+ mean(s.semitrailer2.Fz(idx,6));

mass=(Fz_front_axle+Fz_rear_axle+...
      Fz_semitrailer1_axle1+Fz_semitrailer1_axle2+Fz_semitrailer1_axle3+...
      Fz_semitrailer2_axle2+Fz_semitrailer2_axle2+Fz_semitrailer2_axle3)/9.81;

disp('')
disp('Static axle loads LZV B - 1G');
disp(sprintf('--------------------------------------'));
disp(sprintf('Front axle        %6.0f N (%6.0f kg)',Fz_front_axle,Fz_front_axle/9.81));
disp(sprintf('Rear axle         %6.0f N (%6.0f kg)',Fz_rear_axle,Fz_rear_axle/9.81));
disp(sprintf('Semitrailer axle1 %6.0f N (%6.0f kg)',Fz_semitrailer1_axle1,Fz_semitrailer1_axle1/9.81));
disp(sprintf('Semitrailer axle2 %6.0f N (%6.0f kg)',Fz_semitrailer1_axle2,Fz_semitrailer1_axle2/9.81));
disp(sprintf('Semitrailer axle3 %6.0f N (%6.0f kg)',Fz_semitrailer1_axle3,Fz_semitrailer1_axle3/9.81));
disp(sprintf('Semitrailer axle1 %6.0f N (%6.0f kg)',Fz_semitrailer2_axle1,Fz_semitrailer2_axle1/9.81));
disp(sprintf('Semitrailer axle2 %6.0f N (%6.0f kg)',Fz_semitrailer2_axle2,Fz_semitrailer2_axle2/9.81));
disp(sprintf('Semitrailer axle3 %6.0f N (%6.0f kg)',Fz_semitrailer2_axle3,Fz_semitrailer2_axle3/9.81));
disp(sprintf('--------------------------------------'));
disp(sprintf('total mass                  %6.0f kg ',mass));
%% 2G Models
idx2=find(p.time>9);

Fz_front_axle    = mean(p.tyre.Fz(idx2,1))+ mean(p.tyre.Fz(idx2,2));
Fz_rear_axle     = mean(p.tyre.Fz(idx2,3))+ mean(p.tyre.Fz(idx2,4)+p.tyre.Fz(idx2,5))+ mean(p.tyre.Fz(idx2,6));

Fz_semitrailer1_axle1 = mean(p.semitrailer.Fz(idx2,1))+ mean(p.semitrailer.Fz(idx2,2));
Fz_semitrailer1_axle2 = mean(p.semitrailer.Fz(idx2,3))+ mean(p.semitrailer.Fz(idx2,4));
Fz_semitrailer1_axle3 = mean(p.semitrailer.Fz(idx2,5))+ mean(p.semitrailer.Fz(idx2,6));

Fz_semitrailer2_axle1 = mean(p.semitrailer2.Fz(idx2,1))+ mean(p.semitrailer2.Fz(idx2,2));
Fz_semitrailer2_axle2 = mean(p.semitrailer2.Fz(idx2,3))+ mean(p.semitrailer2.Fz(idx2,4));
Fz_semitrailer2_axle3 = mean(p.semitrailer2.Fz(idx2,5))+ mean(p.semitrailer2.Fz(idx2,6));

mass=(Fz_front_axle+Fz_rear_axle+...
      Fz_semitrailer1_axle1+Fz_semitrailer1_axle2+Fz_semitrailer1_axle3+...
      Fz_semitrailer2_axle2+Fz_semitrailer2_axle2+Fz_semitrailer2_axle3)/9.81;

disp('')
disp('Static axle loads LZV B - 2G');
disp(sprintf('--------------------------------------'));
disp(sprintf('Front axle        %6.0f N (%6.0f kg)',Fz_front_axle,Fz_front_axle/9.81));
disp(sprintf('Rear axle         %6.0f N (%6.0f kg)',Fz_rear_axle,Fz_rear_axle/9.81));
disp(sprintf('Semitrailer axle1 %6.0f N (%6.0f kg)',Fz_semitrailer1_axle1,Fz_semitrailer1_axle1/9.81));
disp(sprintf('Semitrailer axle2 %6.0f N (%6.0f kg)',Fz_semitrailer1_axle2,Fz_semitrailer1_axle2/9.81));
disp(sprintf('Semitrailer axle3 %6.0f N (%6.0f kg)',Fz_semitrailer1_axle3,Fz_semitrailer1_axle3/9.81));
disp(sprintf('Semitrailer axle1 %6.0f N (%6.0f kg)',Fz_semitrailer2_axle1,Fz_semitrailer2_axle1/9.81));
disp(sprintf('Semitrailer axle2 %6.0f N (%6.0f kg)',Fz_semitrailer2_axle2,Fz_semitrailer2_axle2/9.81));
disp(sprintf('Semitrailer axle3 %6.0f N (%6.0f kg)',Fz_semitrailer2_axle3,Fz_semitrailer2_axle3/9.81));
disp(sprintf('--------------------------------------'));
disp(sprintf('total mass                  %6.0f kg ',mass));