function [outer,inner,f,k] = custom_roundabout_seperate(radius,theta_input)
% radius = 15;
% theta_input = 270;
initial_pose = [1.9;-45;pi/2;0];      %target states
target_pose = [50;-1.9;0;0];          %target states

%% Offset
ctheta = -theta_input + 90;
extra = (theta_input-90)*pi/180;

%% Outer(a) inner(b) and width(d) of the roundabout

Rbu_chart = (12.5:7.5/30:20)'; % Outer radius chart
Rbi_chart = (6.5:8.5/30:15)';  % Inner radius chart

Bc = (5:1/30:6);        
B_chart = fliplr(Bc);                 % Width chart

Rt_1 = repmat(8,5,1);
Rt_2 = repmat(12,26,1);
Rt_chart = [Rt_1;Rt_2];              % Entry radius chart
               
Ra_1 = repmat(12,5,1);
Ra_2 = repmat(15,26,1);
Ra_chart = [Ra_1;Ra_2];               % Exit radius chart 

Bt_1 = repmat(4,5,1);
Bt_2 = repmat(3.5,17,1);
Bt_3 = repmat(4,9,1);
Bt_chart = [Bt_1;Bt_2;Bt_3];          %Entry width chart 

Ba_1 = repmat(4.5,5,1);
Ba_2 = repmat(4,17,1);
Ba_3 = repmat(4.5,9,1);
Ba_chart = [Ba_1;Ba_2;Ba_3];          % Exit width chart

col = find(Rbu_chart == radius);      % To find the outer radius position

Rbu = Rbu_chart(col);             % Outer 
Rbi = Rbi_chart(col);
B = B_chart(col);                 % Width
Bt = Bt_chart(col);
Ba = Ba_chart(col);
Rt = Rt_chart(col);               % Entry radius
Ra = Ra_chart(col);               % Exit radius
Bm = 3;                           % Splitter Island

%% Entry parameters

Rentry = Rt+Rbu;

widthy1 = Bt + Rt;
widthy2 = Bt + Bm/2 + Rt;
widthy11 = repmat(widthy1,5,1);
widthy22 = repmat(widthy2,26,1);
widthy_chart = [widthy11;widthy22];
y1 = widthy_chart(col);

theta_entry = asin(y1/Rentry);
x1 = Rentry*cos(theta_entry);

%% Exit parameters

Rexit = (Ra+Rbu);

widthx1 = (Ba + Ra);
widthx2 = Ba + Bm/2 + Ra;
widthx11 = repmat(widthx1,5,1);
widthx22 = repmat(widthx2,26,1);
widthx_chart = [widthx11;widthx22];
x2 = widthx_chart(col);

theta_exit = asin(x2/Rexit);
y2 = Rexit*cos(theta_exit);

%% Outer | inner |overrun area

x = 0;
y = 0;
                             
overrun_area = Rbu-B-3;                            % inner - overrun = 18-5.25 = 12.75-3 
theta1 = linspace(3*pi/2,2*pi,50);                         % 0 to 360 at 100 points

overrun_radiusx1 = (overrun_area)*cos(theta1) + x ;
overrun_radiusy1 = (overrun_area)*sin(theta1) + y ;

theta = linspace(3*pi/2,2*pi+extra,50);                                     % 0 to 360 at 100 points
inner_radiusx = Rbi*cos(theta) + x;                                         % x is measured using R
inner_radiusy = Rbi*sin(theta) + y;                                         % y is measured using R

overrun_radiusx = (overrun_area)*cos(theta) + x ;
overrun_radiusy = (overrun_area)*sin(theta) + y ;

%% Entry arc for the roundabout - 12m R

theta_entryarc = linspace(pi/2+theta_entry,pi,50);           
entry_arcx = Rt*cos(theta_entryarc) + y1;
entry_arcy = Rt*sin(theta_entryarc) - x1;

%% Exit arc for the roundabout - 15m R

theta_exitarc = linspace(pi/2,pi-theta_exit,50);     
exit_arcx = Ra*cos(theta_exitarc) + y2;
exit_arcy = Ra*sin(theta_exitarc) - x2;

xfin = (exit_arcx)*cos((ctheta)*pi/180) + (exit_arcy)*sin((ctheta)*pi/180) ;
yfin = -(exit_arcx)*sin((ctheta)*pi/180) + (exit_arcy)*cos((ctheta)*pi/180);

%% Outer arc

theta_outer = linspace(3*pi/2+theta_entry,2*pi-theta_exit + extra,100);           
outer_arcx = Rbu*cos(theta_outer) + y;
outer_arcy = Rbu*sin(theta_outer) - x;

%% Splitter Island

%Splitter island outer path is present only from 13.75, therefore, if r>=13.75 code for 
% splitter formation will be taken orelse 

Lm1 = Rbu+10+0.5;
Lm2 = Rbu+0.5;

if radius>=13.75 

W1 = Bt+Bm/2;
W2 = Ba+Bm/2;

%% Entry splitter

xena = linspace(W1,W1,15);
yena = linspace(-x1,-x1-4.75,15);
xenb = linspace(W1,Bt+0.3,15);
yenb = linspace(-x1-4.75,-Lm1-7.5,15);
xenc = linspace(Bt+0.3,Bt+0.3,30);
yenc = linspace(-Lm1-7.5,-Lm1-34,30);

Xena =  linspace(overrun_radiusx1(1,1),0,15);
Yena =  linspace(overrun_radiusy1(1,1),-Lm2,15);
Xenb =  linspace(0,Bm/2,5);
Yenb =  linspace(-Lm2,-Lm2,5);
Xenc =  linspace(Bm/2,Bm/2,15);
Yenc =  linspace(-Lm2,-Lm1,15);
Xend =  linspace(Bm/2,0,15);
Yend =  linspace(-Lm1,-Lm1-7,15);
Xene =  linspace(0,overrun_radiusx1(1,1),30);
Yene =  linspace(-Lm1-7,-Lm1-34,30);

%% Exit splitter

Xexa1 = linspace(overrun_radiusx1(1,50),Lm2,15);
Yexa1 = linspace(overrun_radiusy1(1,50),0,15);
Xexa = (Xexa1)*cos((ctheta)*pi/180) + (Yexa1)*sin((ctheta)*pi/180) ;
Yexa = -(Xexa1)*sin((ctheta)*pi/180) + (Yexa1)*cos((ctheta)*pi/180);

Xexb1 = linspace(Lm2,Lm2,5);
Yexb1 = linspace(0,-Bm/2,5);
Xexb = (Xexb1)*cos((ctheta)*pi/180) + (Yexb1)*sin((ctheta)*pi/180);
Yexb = -(Xexb1)*sin((ctheta)*pi/180) + (Yexb1)*cos((ctheta)*pi/180);

Xexc1 = linspace(Lm2,Lm1,15);
Yexc1 = linspace(-Bm/2,-Bm/2,15);
Xexc = (Xexc1)*cos((ctheta)*pi/180) + (Yexc1)*sin((ctheta)*pi/180) ;
Yexc = -(Xexc1)*sin((ctheta)*pi/180) + (Yexc1)*cos((ctheta)*pi/180);

Xexd1 = linspace(Lm1,Lm1+7,15);
Yexd1 = linspace(-Bm/2,0,15);
Xexd = (Xexd1)*cos((ctheta)*pi/180) + (Yexd1)*sin((ctheta)*pi/180) ;
Yexd = -(Xexd1)*sin((ctheta)*pi/180) + (Yexd1)*cos((ctheta)*pi/180);

Xexe1 = linspace(Lm1+7,Lm1+34,30);
Yexe1 = linspace(0,overrun_radiusy1(1,50),30);
Xexe = (Xexe1)*cos((ctheta)*pi/180) + (Yexe1)*sin((ctheta)*pi/180) ;
Yexe = -(Xexe1)*sin((ctheta)*pi/180) + (Yexe1)*cos((ctheta)*pi/180);

%
xexa1 = linspace(y2,y2+3.25,15);
yexa1 = linspace(-W2,-W2,15);
xexa = (xexa1)*cos((ctheta)*pi/180) + (yexa1)*sin((ctheta)*pi/180) ;
yexa = -(xexa1)*sin((ctheta)*pi/180) + (yexa1)*cos((ctheta)*pi/180);

xexb1 = linspace(y2+3.25,Lm1+7,15);
yexb1 = linspace(-W2,-Ba,15);
xexb = (xexb1)*cos((ctheta)*pi/180) + (yexb1)*sin((ctheta)*pi/180) ;
yexb = -(xexb1)*sin((ctheta)*pi/180) + (yexb1)*cos((ctheta)*pi/180);

xexc1 = linspace(Lm1+7,Lm1+34,30);
yexc1 = linspace(-Ba,-Ba,30);
xexc = (xexc1)*cos((ctheta)*pi/180) + (yexc1)*sin((ctheta)*pi/180) ;
yexc = -(xexc1)*sin((ctheta)*pi/180) + (yexc1)*cos((ctheta)*pi/180);

else
W1 = Bt;
W2 = Ba;

xen = linspace(W1,W1,25);
yen = linspace(-x1,-x1-25,25);
Xen = linspace(overrun_radiusx(1,1),overrun_radiusx(1,1),40);
Yen = linspace(overrun_radiusy(1,1),-42,40);

xex = linspace(y2,y2+26,25);
yex = linspace(-W2,-W2,25);
xex1 = (xex)*cos((ctheta)*pi/180) + (yex)*sin((ctheta)*pi/180) ;
yex1 = -(xex)*sin((ctheta)*pi/180) + (yex)*cos((ctheta)*pi/180);

Xex = linspace(overrun_radiusx1(1,50),45,40);
Yex = linspace(overrun_radiusy1(1,50),overrun_radiusy1(1,50),40);
Xex1 = (Xex)*cos((ctheta)*pi/180) + (Yex)*sin((ctheta)*pi/180) ;
Yex1 = -(Xex)*sin((ctheta)*pi/180) + (Yex)*cos((ctheta)*pi/180);

end

if radius<= 13.5

Infra_structure1 = ([fliplr(xen),fliplr(entry_arcx),outer_arcx,fliplr(xfin),xex,fliplr(Xex),fliplr(overrun_radiusx),Xen])';
Infras_tructure2 =  ([fliplr(yen),fliplr(entry_arcy),outer_arcy,fliplr(yfin),yex,fliplr(Yex),fliplr(overrun_radiusy),Yen])';
else

Infra_structure1 = ([fliplr(xenc),fliplr(xenb),fliplr(xena),fliplr(entry_arcx),outer_arcx,fliplr(xfin),xexa,xexb,xexc, ...
    fliplr(Xexe),fliplr(Xexd),fliplr(Xexc),fliplr(Xexb),fliplr(Xexa),fliplr(overrun_radiusx),Xena,Xenb,Xenc,Xend,Xene])';
Infras_tructure2 =  ([fliplr(yenc),fliplr(yenb),fliplr(yena),fliplr(entry_arcy),outer_arcy,fliplr(yfin),yexa,yexb,yexc, ...
    fliplr(Yexe),fliplr(Yexd),fliplr(Yexc),fliplr(Yexb),fliplr(Yexa),fliplr(overrun_radiusy),Yena,Yenb,Yenc,Yend,Yene])';

Infra_structurex1 = ([fliplr(xenc),fliplr(xenb),fliplr(xena),fliplr(entry_arcx),outer_arcx,fliplr(xfin),xexa,xexb,xexc, ...
    fliplr(Xexe),fliplr(Xexd),fliplr(Xexc),fliplr(Xexb),fliplr(Xexa),fliplr(overrun_radiusx),Xena,Xenb,Xenc,Xend,Xene])';
Infras_tructure2 =  ([fliplr(yenc),fliplr(yenb),fliplr(yena),fliplr(entry_arcy),outer_arcy,fliplr(yfin),yexa,yexb,yexc, ...
    fliplr(Yexe),fliplr(Yexd),fliplr(Yexc),fliplr(Yexb),fliplr(Yexa),fliplr(overrun_radiusy),Yena,Yenb,Yenc,Yend,Yene])';

% hold on
end
Infra_outerx = ([fliplr(xenc),fliplr(xenb),fliplr(xena),fliplr(entry_arcx),outer_arcx,fliplr(xfin),xexa,xexb,xexc])';
Infra_outery =  ([fliplr(yenc),fliplr(yenb),fliplr(yena),fliplr(entry_arcy),outer_arcy,fliplr(yfin),yexa,yexb,yexc])';

Infra_innerx = fliplr(([fliplr(Xexe),fliplr(Xexd),fliplr(Xexc),fliplr(Xexb),fliplr(Xexa),fliplr(overrun_radiusx),Xena,Xenb,Xenc,Xend,Xene])');
Infra_innery =  fliplr(([fliplr(Yexe),fliplr(Yexd),fliplr(Yexc),fliplr(Yexb),fliplr(Yexa),fliplr(overrun_radiusy),Yena,Yenb,Yenc,Yend,Yene])');

outer = curvspace([Infra_outerx,Infra_outery],500);
hold on
inner = curvspace([Infra_innerx,Infra_innery],500);
figure(4)
plot(Infra_outerx,Infra_outery,'o')
hold on
plot(Infra_innerx,Infra_innery,'-')
% c = curvspace([Infra_structure1,Infras_tructure2],500);
% Infrastructure1 = c(:,1);
% Infrastructure2 = c(:,2);
% plot(Infrastructure1,Infrastructure2,'o')

%% Reference

% Entry 
enx1 = initial_pose(1);
eny1 = initial_pose(2);

l2s = (xenb(1,15)-Xend(1,15))/2;
enx2 = Xend(1,15) + l2s;
eny2 = Yend(1,15);

l3s = (xena(1,15)-Xenc(1,15))/2;
enx3 = Xenc(1,15) + l3s;
eny3 = Yenc(1,15);

% Exit
m3s = (yexa1(1,15)-Yexc1(1,15))/2;
exy31 = Yexc1(1,15) + m3s;
exx31 = Xexc1(1,15);
exy3 = -(exx31)*sin((ctheta)*pi/180) + (exy31)*cos((ctheta)*pi/180);
exx3 = (exx31)*cos((ctheta)*pi/180) + (exy31)*sin((ctheta)*pi/180) ;

m2s = (yexb1(1,15)-Yexd1(1,15))/2;
exy21 = Yexd1(1,15) + m2s;
exx21 = Xexd1(1,15);
exy2 = -(exx21 )*sin((ctheta)*pi/180) + (exy21 )*cos((ctheta)*pi/180);
exx2 = (exx21)*cos((ctheta)*pi/180) + (exy21)*sin((ctheta)*pi/180) ;

exy11 = Yexd1(1,15) + m2s;
exx11 = Xexd1(1,15) + 15;
exy1 = -(exx11)*sin((ctheta)*pi/180) + (exy11)*cos((ctheta)*pi/180);
exx1 = (exx11)*cos((ctheta)*pi/180) + (exy11)*sin((ctheta)*pi/180);

gh = (Rbu - Rbi)/2;
gx = gh + Rbi;

g = gx*cos(linspace(3*pi/2+pi/12,2*pi-pi/12+extra,30));
h = gx*sin(linspace(3*pi/2+pi/12,2*pi-pi/12+extra,30));

linex1 = linspace(enx1,enx2,20);
liney1 = linspace(eny1,eny2,20);

linex2 = linspace(enx2,enx3,10);
liney2 = linspace(eny2,eny3,10);

linex3 = linspace(enx3,g(1,1),20);
liney3 = linspace(eny3,h(1,1),20);

linex4 = linspace(g(1,30),exx3,20);
liney4 = linspace(h(1,30),exy3,20);

linex5 = linspace(exx3,exx2,10);
liney5 = linspace(exy3,exy2,10);

linex6 = linspace(exx2,exx1,20);
liney6 = linspace(exy2,exy1,20);

f = [linex1,linex2,linex3,g,linex4,linex5,linex6];
k = [liney1,liney2,liney3,h,liney4,liney5,liney6];
 
c = curvspace([f',k'],100);
f = c(:,1);
k = c(:,2);
% plot(c(:,1),c(:,2),'o');


%% Plots

figure(1)
plot(inner_radiusx,inner_radiusy,'--',overrun_radiusx,overrun_radiusy,'k','linewidth',0.5)
hold on
% plot(exit_arcx,exit_arcy,'k','linewidth',0.5)
plot(xfin,yfin,'k','linewidth',0.5)
hold on
plot(entry_arcx,entry_arcy,'k','linewidth',0.5)
hold on
plot(outer_arcx,outer_arcy,'k','linewidth',0.5)
hold on
if radius<=13.5
plot(Xen,Yen,'k',xen,yen,'k',Xex1,Yex1,'k',xex1,yex1,'k','linewidth',0.5);
else
plot(Xena,Yena,'k',Xenb,Yenb,'k',Xenc,Yenc,'k',Xend,Yend,'k',Xene,Yene,'k', ...
   xena,yena,'k',xenb,yenb,'k',xenc,yenc,'k', ...
   xexa,yexa,'k',xexb,yexb,'k',xexc,yexc,'k', ...
   Xexa,Yexa,'k',Xexb,Yexb,'k',Xexc,Yexc,'k',Xexd,Yexd,'k',Xexe,Yexe,'k','linewidth',0.5);
end
hold on
% plot(c(:,1),c(:,2),'--')
% xlim([-50 50])
% ylim([-50 50])
axis equal
% title('\fontsize{20}Approach angle of 270 degrees - outer radius of 14 meters')
xlabel({'\fontsize{20}X (m)'});
ylabel({'\fontsize{20}Y (m)'});
% legend('','Boundary','k','Planned path');
% grid on
% end




