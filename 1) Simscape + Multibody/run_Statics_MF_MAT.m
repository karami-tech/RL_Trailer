load ../simresults/Tractor_Semitrailer_MF_FT_statics.mat

idx=find(p.time>9);

Fz_front_axle1    = mean(MF_Tire_FL(idx,3))+ mean(MF_Tire_FR(idx,3));
Fz_rear_axle1     = mean(MF_Tire_W1RL(idx,3))+ mean(MF_Tire_W2RL(idx,3)+MF_Tire_W2RR(idx,3))+ mean(MF_Tire_W1RR(idx,3));

Fz_trailer1_axle1 = mean(MF_Tire_Trailer1_FL(idx,3))+ mean(MF_Tire_Trailer1_FL(idx,3));
Fz_trailer1_axle2 = mean(MF_Tire_Trailer2_FL(idx,3))+ mean(MF_Tire_Trailer2_FL(idx,3));
Fz_trailer1_axle3 = mean(MF_Tire_Trailer3_FL(idx,3))+ mean(MF_Tire_Trailer3_FL(idx,3));

mass=(Fz_front_axle1+Fz_rear_axle1+...
      Fz_trailer1_axle1+Fz_trailer1_axle2+Fz_trailer1_axle3)/9.81;

disp('')
disp('Static axle loads truck trailer : MF_MAT ');
disp(sprintf('--------------------------------------'));
disp(sprintf('Front axle        %6.0f N (%6.0f kg)',Fz_front_axle1,Fz_front_axle1/9.81));
disp(sprintf('Rear axle         %6.0f N (%6.0f kg)',Fz_rear_axle1,Fz_rear_axle1/9.81));
disp(sprintf('Trailer axle1     %6.0f N (%6.0f kg)',Fz_trailer1_axle1,Fz_trailer1_axle1/9.81));
disp(sprintf('Trailer axle2     %6.0f N (%6.0f kg)',Fz_trailer1_axle2,Fz_trailer1_axle2/9.81));
disp(sprintf('Trailer axle2     %6.0f N (%6.0f kg)',Fz_trailer1_axle2,Fz_trailer1_axle3/9.81));
disp(sprintf('--------------------------------------'));
disp(sprintf('total mass                  %6.0f kg ',mass));
