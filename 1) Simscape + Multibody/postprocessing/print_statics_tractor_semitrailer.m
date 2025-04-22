%load ../simresults/Tractor_Semitrailer_Model_1G_2G_Test_StaticsUL0.mat

idx2=find(p.time>9);


Fz2_front_axle    = mean(p.tyre.tractor.Fz(idx2,1))+ mean(p.tyre.tractor.Fz(idx2,2));

Fz2_rear_axle     = mean(p.tyre.tractor.Fz(idx2,3))+ mean(p.tyre.tractor.Fz(idx2,4)+p.tyre.tractor.Fz(idx2,5))+ mean(p.tyre.tractor.Fz(idx2,6));

Fz2_trailer_axle1 = mean(p.tyre.semitrailer.Fz(idx2,1))+ mean(p.tyre.semitrailer.Fz(idx2,2));

Fz2_trailer_axle2 = mean(p.tyre.semitrailer.Fz(idx2,3))+ mean(p.tyre.semitrailer.Fz(idx2,4));

Fz2_trailer_axle3 = mean(p.tyre.semitrailer.Fz(idx2,5))+ mean(p.tyre.semitrailer.Fz(idx2,6));


mass2=(Fz2_front_axle+Fz2_rear_axle+Fz2_trailer_axle1+Fz2_trailer_axle2+Fz2_trailer_axle3)/9.81;

disp('')
disp('Static axle loads tractor semitrailer 2G');
fprintf('----------------------------------\n');
fprintf('Front axle    %6.0f N (%6.0f kg)\n',Fz2_front_axle,Fz2_front_axle/9.81);
fprintf('Rear axle     %6.0f N (%6.0f kg)\n',Fz2_rear_axle,Fz2_rear_axle/9.81);
fprintf('Trailer axle1 %6.0f N (%6.0f kg)\n',Fz2_trailer_axle1,Fz2_trailer_axle1/9.81);
fprintf('Trailer axle2 %6.0f N (%6.0f kg)\n',Fz2_trailer_axle2,Fz2_trailer_axle2/9.81);
fprintf('Trailer axle3 %6.0f N (%6.0f kg)\n',Fz2_trailer_axle3,Fz2_trailer_axle3/9.81);
fprintf('----------------------------------\n');
fprintf('total mass              %6.0f kg \n',mass2);
