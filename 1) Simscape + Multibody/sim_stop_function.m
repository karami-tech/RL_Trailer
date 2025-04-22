function []=sim_stop_function()

% add this function to your SIMULINK Model
% set_param('modelname','StopFcn','sim_stop_function')

disp('executing sim_stop_function: creating p-structure...')

evalin('base',['p =[];']);                 %... remove old p structure

evalin('base',[' p.modelname =get_param(gcs,''Name''); ']);  % store model name in the 'p' structure

str1=evalin('base','who(''p_*'')');       %... select Simulink output (p_*)
for i=1:length(str1)
  name=char(str1(i));
  idx=find(double(name)==95);             %... find underscores
  name2=name;name2(idx)='.';              %... create new structure name by replacing "_" by "."
  evalin('base',[ name2 '=' name ';'])    %... copy data into structure
  evalin('base',['clear ' name ]);        %... remove "p_" variables
end
