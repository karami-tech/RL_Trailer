%% Vehicle Initizialization Script
%% Clean Slate Protocol 
clear all
close all
clc
%% Add Paths
addpath([pwd filesep 'CAD Models']);
addpath([pwd filesep 'Pictures']);
addpath([pwd filesep 'postprocessing']);
%% Floor parameters
Floor.l = 1000;  % m
Floor.w = 1000;  % m
Floor.h = 0.1; % m

%% Grid parameters

Grid.clr = [1 1 1]*1;
Grid.numSqrs = 250;
Grid.lineWidth = 0.02;
Grid.box_h = (Floor.l-(Grid.lineWidth*(Grid.numSqrs+1)))/Grid.numSqrs;
Grid.box_l = (Floor.l-(Grid.lineWidth*(1+1)))/1;
Grid.extr_data = Extr_Data_Mesh(Floor.w,Floor.w,Grid.numSqrs,1,Grid.box_h,Grid.box_l);
%% Tire Parameters 
% tire_param=simscape.multibody.tirread('Truck_430_50R38.tir');
% tire_param2=simscape.multibody.tirread('Truck_430_50R38.tir');
 tire_param_steer = simscape.multibody.tirread('STEER_315_70R22.5_9b_MF62.tir');
 tire_width = 0.318; % Steer and Drive axle: Nominal section width of the tyre
 tire_param_drive = simscape.multibody.tirread('DRIVE_315_70R22.5_9b_MF62.tir');
 tire_param_trailer = simscape.multibody.tirread('TRAILER_385_65R22.5_9b0_MF62.tir');
 trailer_tire_width = 0.385; % Trailer : Nominal section width of the tyre
%% Default Setting (Static) 

tmax     = 10;
dt       = 0.001; % Time step 
sp_t     = 0.01;  % Sampling time for data 
%%%%input_force=500; % input force at 6DOF for testing [in Newtons] 
pose_t0  = [0 0 0 0]; % global x, y, heading and articulation angle (t=0)
Vx       =  0;        % velocity m/s

throttle =  0;  

steer_input   =[0  tmax ;
                0     0];

% steer_input   =[0  2   10     40       tmax ;
%                 0  0   0     7  7];

steer_path(:,1)=[0 1e4 1e5];  % x
steer_path(:,2)=[0 0   0];  % y
% steer_path(:,3)=[0 0   0];  % z

% brake_input   =[0  49 50 tmax ;
%                 0   0 0.2 0.2 ];

brake_input   =[0   tmax ;
                0   0 ];

throttle_input=[0         tmax;
                throttle  throttle];

Vx_input      =[0  tmax;
                Vx  Vx];

% Vx_input = [0 10 40 tmax;
%             0 0 15 15];

%% controller parameters 

LD= 1; % lookahead distance (we typically use 1 for docking maneuvers at 1 m/s
L_0f = 3.8 ; % tractor wheelbase
v_0 = 1; % target speed (it does not do speed control but needs this to determine driving direction)

% %% Roundabout Generator initialisation (Default exit : 3 ) 
% p_roundabout_OCD= 29 ; % outer diameter of the roundabout
% p_roundabout_lanewidth= 3.5 ; % entry lane width  
% p_roundabout_exit = 3 ; % exit number of the roundabout
% 
% % The Roundabout Generator (Default exit set to 3)
% [rx,ry,boundary_inx,boundary_iny,boundary_outx,boundary_outy,centerx,centery] = make_roundabout_lines_optimize_v4(p_roundabout_OCD,p_roundabout_lanewidth,p_roundabout_exit);
% 
% p_roundabout_boundaryin = [boundary_inx',boundary_iny'];
% p_roundabout_boundaryout = [boundary_outx',boundary_outy'];
% p_roundabout_center=[centerx,centery];
% 
% % if ~exist("rx","var") || ~exist("ry","var")
% %     try
% %         [rx,ry,boundary_inx,boundary_iny,boundary_outx,boundary_outy] = make_roundabout_lines_optimize_v1(15,3.5,3);
% %     catch
% %         error('No path defined!')
% %     end
% % end
% 
% % PLotting the path as a final check before simulations
% steer_path=[rx,ry]; % Define path
% figure(1)
% plot(rx,ry,'Color','#0072BD','LineStyle', '--','LineWidth', 1.2); 
% hold on 
% plot(boundary_outx', boundary_outy', 'k', 'LineWidth', 1);
% plot(boundary_inx', boundary_iny', 'k', 'LineWidth', 1);
% plot(centerx', centery', 'Color','#77AC30', 'LineWidth', 1.5);
% axis equal;
% grid on;
% legend('Nominal Path','Boundary Roundabout','Boundary Roundabout', 'Inner Boundary','Location','best')
% hold off
% final_x=rx(end); %% To end simulation at the final point
% final_y=ry(end); %% To end simulation at the final point
steer_ratio=20;
steer_sens=1;

%% PLotting the path as a final check before simulations for MPC
%% For exit 3
% load("inner.mat");
% load("outer.mat");
% load("xhistory_270.mat"); 
% 
% %% For exit 2
% %load("inner.mat");
% %load("outer.mat");
% load("xhist_180_14_113.mat"); 
% %%
% pose_t0  = [xhistory(1,1) xhistory(1,2) 90 0]; % global x, y, heading and articulation angle (t=0)
% Vx       =  2;        % velocity m/s
% steer_path=[xhistory(:,1),xhistory(:,2)]; % Define path
% rx=steer_path(:,1);
% ry=steer_path(:,2);
% boundary_inx=inner(:,1)';
% boundary_iny=inner(:,2)';
% boundary_outx=outer(:,1)';
% boundary_outy=outer(:,2)';
% 
% figure(2)
% plot(xhistory(:,1),xhistory(:,2),'r'); 
% hold on 
% plot(boundary_outx', boundary_outy', 'k', 'LineWidth', 1);
% plot(boundary_inx', boundary_iny', 'k', 'LineWidth', 1);
% axis equal;
% grid on;
% hold off
% final_x=xhistory(end,1); %% To end simulation at the final point
% final_y=xhistory(end,2);
% steer_ratio=20;
% steer_sens=1;