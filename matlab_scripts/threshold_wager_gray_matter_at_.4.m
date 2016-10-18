% List of open inputs
nrun = X; % enter the number of runs here
jobfile = {'/Users/utooley/Documents/Kable Lab/CogTrain/CogTrain/matlab_scripts/threshold_wager_gray_matter_at_.4_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
