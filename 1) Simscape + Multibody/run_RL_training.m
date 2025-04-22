
%% Step 6: Train the Agent
trainingStats = train(agentObj, env, trainOpts);
save('trained_RL_agent6.mat', 'agentObj');