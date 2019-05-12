%% setup
test_folder = fileparts( mfilename( 'fullpath' ) );

stl_path = fullfile( test_folder, 'base_plate.stl' );
option_path = which( 'oo_options.json' );
objective_variables_path = which( 'objective_variables.json' );
angles = [ pi/4 pi/3 ];
slurm_array_job_id = 1;
slurm_job_id = 314159;
output_folder = fullfile( test_folder, 'output' );

%% base case
[ c_path, f_path ] = generate_base_case_data( ...
    option_path, ...
    stl_path, ...
    output_folder ...
    );

%% trial case
generate_csvs_on_hpc( ...
    c_path, ...
    f_path, ...
    option_path, ...
    objective_variables_path, ...
    angles, ...
    slurm_array_job_id, ...
    slurm_job_id, ...
    output_folder ...
    );

