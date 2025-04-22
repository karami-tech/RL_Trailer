%% 1G Model
load ../simresults/LZV_A_Model_1G_2G_StaticsL0.mat

idx=find(s.time>9);

Fz_front_axle    = mean(s.tyre.Fz(idx,1))+ mean(s.tyre.Fz(idx,2));
Fz_rear_axle     = mean(s.tyre.Fz(idx,3))+ mean(s.tyre.Fz(idx,4)+s.tyre.Fz(idx,5))+ mean(s.tyre.Fz(idx,6));

Fz_semitrailer_axle1 = mean(s.semitrailer.Fz(idx,1))+ mean(s.semitrailer.Fz(idx,2));
Fz_semitrailer_axle2 = mean(s.semitrailer.Fz(idx,3))+ mean(s.semitrailer.Fz(idx,4));
Fz_semitrailer_axle3 = mean(s.semitrailer.Fz(idx,5))+ mean(s.semitrailer.Fz(idx,6));

Fz_trailer_axle1 = mean(s.trailer.Fz(idx,1))+ mean(s.trailer.Fz(idx,2));
Fz_trailer_axle2 = mean(s.trailer.Fz(idx,3))+ mean(s.trailer.Fz(idx,4));

mass=(Fz_front_axle+Fz_rear_axle+...
      Fz_semitrailer_axle1+Fz_semitrailer_axle2+Fz_semitrailer_axle3+...
      Fz_trailer_axle1+Fz_trailer_axle2)/9.81;

disp('')
disp('Static axle loads LZV A - 1G');
fprintf('--------------------------------------\n');
fprintf('Front axle        %6.0f N (%6.0f kg)\n',Fz_front_axle,Fz_front_axle/9.81);
fprintf('Rear axle         %6.0f N (%6.0f kg)\n',Fz_rear_axle,Fz_rear_axle/9.81);
fprintf('Semitrailer axle1 %6.0f N (%6.0f kg)\n',Fz_semitrailer_axle1,Fz_semitrailer_axle1/9.81);
fprintf('Semitrailer axle2 %6.0f N (%6.0f kg)\n',Fz_semitrailer_axle2,Fz_semitrailer_axle2/9.81);
fprintf('Semitrailer axle3 %6.0f N (%6.0f kg)\n',Fz_semitrailer_axle3,Fz_semitrailer_axle3/9.81);
fprintf('Trailer axle1     %6.0f N (%6.0f kg)\n',Fz_trailer_axle1,Fz_trailer_axle1/9.81);
fprintf('Trailer axle2     %6.0f N (%6.0f kg)\n',Fz_trailer_axle2,Fz_trailer_axle2/9.81);
fprintf('--------------------------------------\n');
fprintf('total mass                  %6.0f kg \n',mass);

%% 2G Model 
idx2=find(p.time>9);

Fz_front_axle    = mean(p.tyre.Fz(idx2,1))+ mean(p.tyre.Fz(idx2,2));
Fz_rear_axle     = mean(p.tyre.Fz(idx2,3))+ mean(p.tyre.Fz(idx2,4)+p.tyre.Fz(idx2,5))+ mean(p.tyre.Fz(idx2,6));

Fz_semitrailer_axle1 = mean(p.semitrailer.Fz(idx2,1))+ mean(p.semitrailer.Fz(idx2,2));
Fz_semitrailer_axle2 = mean(p.semitrailer.Fz(idx2,3))+ mean(p.semitrailer.Fz(idx2,4));
Fz_semitrailer_axle3 = mean(p.semitrailer.Fz(idx2,5))+ mean(p.semitrailer.Fz(idx2,6));

Fz_trailer_axle1 = mean(p.trailer1.Fz(idx2,1))+ mean(p.trailer1.Fz(idx2,2));
Fz_trailer_axle2 = mean(p.trailer1.Fz(idx2,3))+ mean(p.trailer1.Fz(idx2,4));

mass=(Fz_front_axle+Fz_rear_axle+...
      Fz_semitrailer_axle1+Fz_semitrailer_axle2+Fz_semitrailer_axle3+...
      Fz_trailer_axle1+Fz_trailer_axle2)/9.81;

disp('')
disp('Static axle loads LZV A - 2G');
fprintf('--------------------------------------\n');
fprintf('Front axle        %6.0f N (%6.0f kg)\n',Fz_front_axle,Fz_front_axle/9.81);
fprintf('Rear axle         %6.0f N (%6.0f kg)\n',Fz_rear_axle,Fz_rear_axle/9.81);
fprintf('Semitrailer axle1 %6.0f N (%6.0f kg)\n',Fz_semitrailer_axle1,Fz_semitrailer_axle1/9.81);
fprintf('Semitrailer axle2 %6.0f N (%6.0f kg)\n',Fz_semitrailer_axle2,Fz_semitrailer_axle2/9.81);
fprintf('Semitrailer axle3 %6.0f N (%6.0f kg)\n',Fz_semitrailer_axle3,Fz_semitrailer_axle3/9.81);
fprintf('Trailer axle1     %6.0f N (%6.0f kg)\n',Fz_trailer_axle1,Fz_trailer_axle1/9.81);
fprintf('Trailer axle2     %6.0f N (%6.0f kg)\n',Fz_trailer_axle2,Fz_trailer_axle2/9.81);
fprintf('--------------------------------------\n');
fprintf('total mass                  %6.0f kg \n',mass);
