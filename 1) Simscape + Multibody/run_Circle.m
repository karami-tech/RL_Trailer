function []=run_Circle(modelname,delta_deg,Vx_kmh)

tmax     = 60;
dt       =  0.001;

pose_t0  = [0 0 0 0];    % global x, y, heading and articulation angle (t=0)
Vx       =  Vx_kmh/3.6;  % velocity m/s

throttle =  0.0;         % use cruise control

delta=delta_deg*pi/180  *20;  % steering ratio = 20

steer_input   =[0  2   10     13       tmax ;
                0  0   0    delta   delta];

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

filename=[ modelname '_circle' ];

% sim_wrapper; % call the wrapper around the Simulink "sim" command
sim_wrapper_TNO; % call the wrapper around the Simulink "sim" command

return
