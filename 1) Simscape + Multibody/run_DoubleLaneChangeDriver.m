function []=run_DoubleLaneChangeDriver(modelname, Vx_kmh)

dt       =  0.01;

pose_t0  = [0 0 0 0];    % global x, y, heading and articulation angle (t=0)
Vx       =  Vx_kmh/3.6;  % velocity m/s

throttle =  0;           % use cruise control

steer_path(:,1)=[0  50  80 105 130  500];  % x
steer_path(:,2)=[0   0 3.5 3.5   0    0];  % y
%steer_path(:,3)=[0   0   0   0   0    0];  % z

tmax = (max(steer_path(:,1))-100)/Vx;

steer_input   =[0 tmax ;
                0 0];

brake_input   =[0   2  tmax ;
                0   0  0];

throttle_input=[0        tmax;
                throttle throttle];

Vx_input      =[0 tmax;
                Vx Vx];           

rdfname      ='TNO_FlatRoad.rdf';
rdfname_inner='TNO_FlatRoad.rdf';

filename=[ modelname '_DLC_v' num2str(round(Vx_kmh)) ];

sim_wrapper; % call the wrapper around the Simulink "sim" command

return
