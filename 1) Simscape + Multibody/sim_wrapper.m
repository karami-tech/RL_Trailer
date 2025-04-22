assignin('base','tmax',tmax);
assignin('base','dt',dt);
assignin('base','pose_t0',pose_t0);
assignin('base','Vx',Vx);
assignin('base','rdfname',rdfname);
assignin('base','rdfname_inner',rdfname_inner);
assignin('base','steer_input',steer_input);
assignin('base','steer_path',steer_path);
assignin('base','brake_input',brake_input);
assignin('base','throttle_input',throttle_input);
assignin('base','Vx_input',Vx_input);



%tic;
sim(modelname,[],simset('DstWorkspace','base'));
%toc;

evalin('base',['save ..\simresults\',filename,' p dt'])		

