% Step 0: Load pre-trained agent
load('trained_RL_agent5.mat', 'agentObj');

%% Step 1: Define Observation and Action Info
obsInfo = rlNumericSpec([9 1], 'LowerLimit', -1, 'UpperLimit', 1);  % 9 normalized signals
obsInfo.Name = 'observations';

actInfo = rlNumericSpec([1 1], 'LowerLimit', -1, 'UpperLimit', 1);
actInfo.Name = 'torque_request';

%% Step 2: Create the Environment Interface
env = rlSimulinkEnv('ICE_Tractor_KRAKER_etrailer_v3_0', 'ICE_Tractor_KRAKER_etrailer_v3_0/Tractor_semitrailer/KRAKER e-trailer/Etrailer-Controller/RL_Agent', obsInfo, actInfo);
env.ResetFcn = @(in) in;  % Optional: custom reset logic

%% Step 3: Create Actor and Critic Networks
% Critic Network
statePath = featureInputLayer(obsInfo.Dimension(1), 'Name', 'obs');
actionPath = featureInputLayer(actInfo.Dimension(1), 'Name', 'act');
commonPath = [
    concatenationLayer(1, 2, 'Name', 'concat')
    fullyConnectedLayer(400, 'Name', 'fc1')
    reluLayer('Name', 'relu1')
    fullyConnectedLayer(300, 'Name', 'fc2')
    reluLayer('Name', 'relu2')
    fullyConnectedLayer(1, 'Name', 'output')];

criticNet = layerGraph(statePath);
criticNet = addLayers(criticNet, actionPath);
criticNet = addLayers(criticNet, commonPath);
criticNet = connectLayers(criticNet, 'obs', 'concat/in1');
criticNet = connectLayers(criticNet, 'act', 'concat/in2');

criticOpts = rlRepresentationOptions('LearnRate', 1e-03, 'GradientThreshold', 1);
critic = rlQValueRepresentation(criticNet, obsInfo, actInfo, ...
    'Observation', {'obs'}, 'Action', {'act'}, criticOpts);

% Actor Network
actorNet = [
    featureInputLayer(obsInfo.Dimension(1), 'Name', 'obs')
    fullyConnectedLayer(400, 'Name', 'fc1')
    reluLayer('Name', 'relu1')
    fullyConnectedLayer(300, 'Name', 'fc2')
    reluLayer('Name', 'relu2')
    fullyConnectedLayer(1, 'Name', 'fc3')
    tanhLayer('Name', 'tanh')];  % Output between -1 and 1

actorOpts = rlRepresentationOptions('LearnRate', 1e-04, 'GradientThreshold', 1);
actor = rlDeterministicActorRepresentation(actorNet, obsInfo, actInfo, ...
    'Observation', {'obs'}, 'Action', {'tanh'}, actorOpts);

%% Step 4: DDPG Agent Options
agentOpts = rlDDPGAgentOptions(...
    'SampleTime', 0.1, ...
    'TargetSmoothFactor', 1e-3, ...
    'ExperienceBufferLength', 1e6, ...
    'DiscountFactor', 0.99, ...
    'MiniBatchSize', 64);

% Add exploration noise
agentOpts.NoiseOptions.Variance = 0.4;
agentOpts.NoiseOptions.VarianceDecayRate = 1e-5;
agentOpts.NoiseOptions.VarianceMin = 0.05;

% Create the agent
agentObj = rlDDPGAgent(actor, critic, agentOpts);

%% Step 5: Training Options
trainOpts = rlTrainingOptions(...
    'MaxEpisodes', 10, ...
    'MaxStepsPerEpisode', 20000, ...
    'ScoreAveragingWindowLength', 5, ...
    'Verbose', true, ...
    'Plots','training-progress', ...
    'StopTrainingCriteria','AverageReward', ...
    'StopTrainingValue', 1000);

