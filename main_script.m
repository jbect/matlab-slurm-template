%% main_script

fprintf ('[%s] Starting main_script.m\n\n', datestr (now, 'HH:MM:SS'));

% Set to true to ignore environment variables
IGNORE_ENV = false;


%% Choice of experiment name

EXPERIMENT = getenv ('EXPERIMENT');
if IGNORE_ENV || (isempty (EXPERIMENT))
    EXPERIMENT = 'main_script';
end


%% Choice of method

METHOD = getenv ('METHOD');
if IGNORE_ENV || (isempty (METHOD))
    METHOD = 'GreatMethod';
end


%% Choice of test problem

PROBLEM = getenv ('PROBLEM');
if IGNORE_ENV || (isempty (PROBLEM))
    PROBLEM = 'DifficultProblem';
end


%% Simulation number

SIMULATION_IDX = str2double (getenv ('SLURM_ARRAY_TASK_ID'));
if IGNORE_ENV || (isnan (SIMULATION_IDX))
    SIMULATION_IDX = 1;
end


%% Display main parameters

fprintf ('EXPERIMENT     = %s\n',   EXPERIMENT);
fprintf ('METHOD         = %s\n',   METHOD);
fprintf ('PROBLEM        = %s\n',   PROBLEM);
fprintf ('SIMULATION_IDX = %d\n\n', SIMULATION_IDX);


%% Do the actual work

result = 2 * SIMULATION_IDX + 1;

output_file = sprintf ('result_%d.mat', SIMULATION_IDX);
save (output_file, 'result');
