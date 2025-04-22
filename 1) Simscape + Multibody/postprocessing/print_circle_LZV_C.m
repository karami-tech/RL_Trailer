load ../simresults/LZV_C_circle.mat

idx=find(s.time>10);
R = (max(s.steeraxle.pos(idx,1))-min(s.steeraxle.pos(idx,1)))/2;
R = (max(s.steeraxle.pos(idx,2))-min(s.steeraxle.pos(idx,2)))/2;

x = VR.tractor.signals.values(idx,5+7);
y = VR.tractor.signals.values(idx,7+7);

Rmax= (max(x)-min(x))/2;
Rmax= (max(y)-min(y))/2

Rmin=Rmax;
imin=0;

for i=1:12
  x = VR.trailer.signals.values(idx,5+(i-1)*7);
  y = VR.trailer.signals.values(idx,7+(i-1)*7);
  R= (max(x)-min(x))/2;
  R= (max(y)-min(y))/2;
  
  if (R < Rmin)
    Rmin=R;
    imin=i;
  end
end
Rmin
imin

Rmax-Rmin
