%% Check for Existing Simulink Data
if ~exist('logsout', 'var')
    error('logsout variable not found. Run the Simulink model first to generate simulation data.');
end

%% Extract Observations from Simulink Logs
% Find signals in logs
FKP_signal = logsout.get('FKP').Values.Data;
Vx_signal = logsout.get('Vx').Values.Data;
Mb_trailer_signal = logsout.get('Mb_trailer').Values.Data;
Throttle_signal = logsout.get('throttle').Values.Data;
Brake_signal = logsout.get('brake').Values.Data;
SOC_signal = logsout.get('SOC').Values.Data;
Axle_load1_signal = logsout.get('Fz1').Values.Data;
Axle_load2_signal = logsout.get('Fz2').Values.Data;
Axle_load3_signal = logsout.get('Fz3').Values.Data;

%% Compute Maximum Absolute Values for Normalization (Avoid Division by Zero)
epsilon = 1e-6; % Small constant to prevent division by zero
max_FKP = max(abs(FKP_signal)) + epsilon;
max_Vx = max(abs(Vx_signal)) + epsilon;
max_Mb_trailer = max(abs(Mb_trailer_signal)) + epsilon;
max_Throttle = max(abs(Throttle_signal)) + epsilon; % Should be between 0-1 already
max_Brake = max(abs(Brake_signal)) + epsilon; % Should be between 0-1 already
max_SOC = max(abs(SOC_signal)) + epsilon; % Should be between 0-100
max_Axle_load = max([max(abs(Axle_load1_signal)), max(abs(Axle_load2_signal)), max(abs(Axle_load3_signal))]) + epsilon;

%% Display Single Normalization Factor Per Sensor
fprintf('\nNormalization Factors for Observations:\n');
fprintf('FKP Max: %.2f → Normalization Factor: 1/%.2f\n', max_FKP, max_FKP);
fprintf('Vx Max: %.2f → Normalization Factor: 1/%.2f\n', max_Vx, max_Vx);
fprintf('Mb_trailer Max: %.2f → Normalization Factor: 1/%.2f\n', max_Mb_trailer, max_Mb_trailer);
fprintf('Throttle Max: %.2f → Normalization Factor: No Change (0-1)\n', max_Throttle);
fprintf('Brake Max: %.2f → Normalization Factor: No Change (0-1)\n', max_Brake);
fprintf('SOC Max: %.2f → Normalization Factor: 1/%.2f (Convert to 0-1)\n', max_SOC, max_SOC);
fprintf('Axle Load Max: %.2f → Normalization Factor: 1/%.2f\n', max_Axle_load, max_Axle_load);

%% Suggested Normalized Values (Element-Wise Division)
FKP_norm = FKP_signal ./ max_FKP;
Vx_norm = Vx_signal ./ max_Vx;
Mb_trailer_norm = Mb_trailer_signal ./ max_Mb_trailer;
SOC_norm = SOC_signal ./ max_SOC;
Axle_load_norm = Axle_load1_signal ./ max_Axle_load; % Example for first axle