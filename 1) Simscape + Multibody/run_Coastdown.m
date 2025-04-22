function []=run_Coastdown(modelname, Vx_kmh, throttle)

tmax     = 300;
tmax     = 11;

dt       =   0.5;

pose_t0  = [0 0 0 0];    % global x, y, heading and articulation angle (t=0)
Vx       =  Vx_kmh/3.6;  % velocity m/s

steer_input   =[0 tmax ;
                0 0];

steer_path(:,1)=[0 1e4 1e5];  % x
steer_path(:,2)=[0 0   0];  % y
steer_path(:,3)=[0 0   0];  % z

brake_input   =[0  2  tmax ;
                0  0  0];

throttle_input=[0        10         10.0001 tmax;
                throttle throttle   0       0];

Vx_input      =[0 tmax;
                Vx Vx];           

rdfname      ='TNO_FlatRoad.rdf';
rdfname_inner='TNO_FlatRoad.rdf';

filename=[ modelname '_Coastdown_v' num2str(round(Vx_kmh)) ];

sim_wrapper; % call the wrapper around the Simulink "sim" command

return
