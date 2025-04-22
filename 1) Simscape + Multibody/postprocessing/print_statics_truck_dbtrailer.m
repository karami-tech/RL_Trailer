load ../simresults/truck_dbtrailer_statics.mat

idx=find(s.time>9);

Fz_front_axle1    = mean(s.tyre.Fz(idx,1))+ mean(s.tyre.Fz(idx,2));
Fz_rear_axle1     = mean(s.tyre.Fz(idx,3))+ mean(s.tyre.Fz(idx,4)+s.tyre.Fz(idx,5))+ mean(s.tyre.Fz(idx,6));
Fz_rear_axle2     = mean(s.tyre.Fz(idx,7))+ mean(s.tyre.Fz(idx,8)+s.tyre.Fz(idx,9))+ mean(s.tyre.Fz(idx,10));

Fz_trailer1_axle1    = mean(s.trailer1.Fz(idx,1))+ mean(s.trailer1.Fz(idx,2));
Fz_trailer1_axle2    = mean(s.trailer1.Fz(idx,3))+ mean(s.trailer1.Fz(idx,4));

mass=(Fz_front_axle1+Fz_rear_axle1+Fz_rear_axle2+...
      Fz_trailer1_axle1+Fz_trailer1_axle2)/9.81;

disp('')
disp('Static axle loads Truck drawbar trailer');
disp(sprintf('--------------------------------------'));
disp(sprintf('Front axle        %6.0f N (%6.0f kg)',Fz_front_axle1,Fz_front_axle1/9.81));
disp(sprintf('Rear axle1        %6.0f N (%6.0f kg)',Fz_rear_axle1,Fz_rear_axle1/9.81));
disp(sprintf('Rear axle2        %6.0f N (%6.0f kg)',Fz_rear_axle2,Fz_rear_axle2/9.81));
disp(sprintf('Trailer1 axle1    %6.0f N (%6.0f kg)',Fz_trailer1_axle1,Fz_trailer1_axle1/9.81));
disp(sprintf('Trailer1 axle2    %6.0f N (%6.0f kg)',Fz_trailer1_axle2,Fz_trailer1_axle2/9.81));
disp(sprintf('--------------------------------------'));
disp(sprintf('total mass                  %6.0f kg ',mass));
