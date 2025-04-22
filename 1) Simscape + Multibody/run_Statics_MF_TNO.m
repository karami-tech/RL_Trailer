load ../simresults/Tractor_Semitrailer_MF_TNO_statics.mat

idx=find(p.time>9);

Fz_front_axle1    = mean(p.tyre.Fz(idx,1))+ mean(p.tyre.Fz(idx,2));
Fz_rear_axle1     = mean(p.tyre.Fz(idx,3))+ mean(p.tyre.Fz(idx,4)+p.tyre.Fz(idx,5))+ mean(p.tyre.Fz(idx,6));

Fz_trailer1_axle1 = mean(p.semitrailer.Fz(idx,1))+ mean(p.semitrailer.Fz(idx,2));
Fz_trailer1_axle2 = mean(p.semitrailer.Fz(idx,3))+ mean(p.semitrailer.Fz(idx,4));
Fz_trailer1_axle3 = mean(p.semitrailer.Fz(idx,5))+ mean(p.semitrailer.Fz(idx,6));

mass=(Fz_front_axle1+Fz_rear_axle1+...
      Fz_trailer1_axle1+Fz_trailer1_axle2+Fz_trailer1_axle3)/9.81;

disp('')
disp('Static axle loads truck trailer');
disp(sprintf('--------------------------------------'));
disp(sprintf('Front axle        %6.0f N (%6.0f kg)',Fz_front_axle1,Fz_front_axle1/9.81));
disp(sprintf('Rear axle         %6.0f N (%6.0f kg)',Fz_rear_axle1,Fz_rear_axle1/9.81));
disp(sprintf('Trailer axle1     %6.0f N (%6.0f kg)',Fz_trailer1_axle1,Fz_trailer1_axle1/9.81));
disp(sprintf('Trailer axle2     %6.0f N (%6.0f kg)',Fz_trailer1_axle2,Fz_trailer1_axle2/9.81));
disp(sprintf('Trailer axle2     %6.0f N (%6.0f kg)',Fz_trailer1_axle2,Fz_trailer1_axle3/9.81));
disp(sprintf('--------------------------------------'));
disp(sprintf('total mass                  %6.0f kg ',mass));