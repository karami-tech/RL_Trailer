function []=run_SingleSine(modelname, Vx_kmh, freq_Hz, ampl_deg)

tmax     = 20;
dt       =  0.01;

pose_t0  = [0 0 0 0];    % global x, y, heading and articulation angle (t=0)
Vx       =  Vx_kmh/3.6;  % velocity m/s

throttle =  0;           % use cruise control

delta=ampl_deg*pi/180;    %

% single sine after 5 sec.

ts=linspace(0,1,100)/freq_Hz;
as=delta*sin(2*pi*ts*freq_Hz);

steer_input   =[0  5+ts tmax ;
                0  as      0];

steer_path(:,1)=[0 1e4 1e5];  % x
steer_path(:,2)=[0 0   0];  % y
%steer_path(:,3)=[0 0   0];  % z

brake_input   =[0  tmax ;
                0     0];

throttle_input=[0         tmax;
                throttle  throttle];

Vx_input      =[0  tmax;
                Vx Vx];

rdfname      ='TNO_FlatRoad.rdf';
rdfname_inner='TNO_FlatRoad.rdf';

filename=[ modelname '_SingleSine_v' num2str(round(Vx_kmh)) '_f' num2str(round(freq_Hz*100)) ];

sim_wrapper; % call the wrapper around the Simulink "sim" command

return
