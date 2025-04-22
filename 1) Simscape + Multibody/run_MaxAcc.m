function []=run_MaxAcc(modelname)

tmax     = 200;
dt       =  0.5;

pose_t0  = [0 0 0 0];    % global x, y, heading and articulation angle (t=0)
Vx       =  0;           % velocity m/s

throttle =  1;           % use cruise control

steer_input   =[0 tmax ;
                0 0];

steer_path(:,1)=[0 1e4 1e5];  % x
steer_path(:,2)=[0 0   0];  % y
steer_path(:,3)=[0 0   0];  % z

brake_input   =[0  2  tmax ;
                0   0  0];

throttle_input=[0        tmax;
                throttle throttle];

Vx_input      =[0 tmax;
                Vx Vx];           

rdfname      ='TNO_FlatRoad.rdf';
rdfname_inner='TNO_FlatRoad.rdf';

filename=[ modelname '_MaxAcc'  ];

sim_wrapper; % call the wrapper around the Simulink "sim" command

return
