load ../simresults/Tractor_Semitrailer_Model_1G_2G_Test_circle.mat

idx=find(s.time>10);
R = (max(s.steeraxle.pos(idx,1))-min(s.steeraxle.pos(idx,1)))/2
R = (max(s.steeraxle.pos(idx,2))-min(s.steeraxle.pos(idx,2)))/2

x = VR_tractor.signals.values(idx,5+7);
y = VR_tractor.signals.values(idx,7+7);

Rmax= (max(x)-min(x))/2
Rmax= (max(y)-min(y))/2

Rmin=Rmax;

for i=1:10
  x = VR_semitrailer.signals.values(idx,5+(i-1)*7);
  y = VR_semitrailer.signals.values(idx,7+(i-1)*7);
  R= (max(x)-min(x))/2;
  R= (max(y)-min(y))/2;
  
  if (R < Rmin)
    Rmin=R
    i
  end
end

Rmax-Rmin
