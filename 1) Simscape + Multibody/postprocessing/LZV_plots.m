close all
%font(30,1)

txt  ={'tractor semitrailer','truck trailer','truck drawbar trailer','A','B','C','D','E','F','G'};


VL  =[16.50  18.75  18.72  25.28  25.25  22.90  25.25  25.22  21.80  23.00];
SP  =[5.5762 4.7638 4.2810 5.5939 7.2358 5.2544 6.0926 4.9661 6.2290 5.8512];
RA  =[1.4001 1.9594 1.7465 2.4947 1.5765 2.4696 2.0620 3.6100 1.4493 1.6900];
DLTR=[0.2689 0.2859 0.3023 0.4799 0.2315 0.4869 0.2950 0.7009 0.2613 0.3348];

plot(VL,SP,'o','Linewidth',2)
grid
hold on
for i=1:length(txt)
    text(VL(i)+0.2,SP(i),txt(i));
end
hold off
axis([15 30 4 8])
xlabel('vehicle length [m]')
ylabel('swept path (tyres centre) [m]')

print -depsc -tiff LZV_plot1



figure
plot(RA,DLTR,'o','Linewidth',2)
grid
hold on
for i=1:length(txt)
    text(RA(i)+0.1,DLTR(i),txt(i));
end
hold off
axis([0 5 0 1])
xlabel('rearward amplification [-]')
ylabel('dynamic load transfer ratio [-]')

print -depsc -tiff LZV_plot2



figure
plot(SP,DLTR,'o','Linewidth',2)
grid
hold on
for i=1:length(txt)
    text(SP(i)+0.1,DLTR(i),txt(i));
end
hold off
%axis([0 5 0 1])
xlabel('swept path (tyres) [m]')
ylabel('dynamic load transfer ratio [-]')
print -depsc -tiff LZV_plot3



figure
plot(SP,RA,'o','Linewidth',2)
grid
hold on
for i=1:length(txt)
    text(SP(i)+0.1,RA(i),txt(i));
end
hold off
%axis([0 5 0 1])
xlabel('swept path (tyres) [m]')
ylabel('rearward amplification [-]')

print -depsc -tiff LZV_plot4

