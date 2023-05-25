
function [dirs, files] = seeVR_set_variables(  )

%% Specify the directories of the toolbox here
dirs.seeVR     = 'C:\Users\abhogal\MATLAB\Projects\seeVR'; %specify toolbox path with trailing slash

dirs.elastix   = 'C:\Users\abhogal\MATLAB\Projects\seeVR_GUI\functions\elastix'; 
addpath(genpath(dirs.seeVR));

%% Specify tags used to identify folders

% Functional data and anatomical data should be in seperate folders
% This can be in accordance with BIDS (i.e. func, anat) else you can set
% your own structure using unique tags

dirs.func = 'BOLD';
dirs.anat = 'T1';

%% Specify tags used to identify images for loading

% if you have standardized files from pre-processing steps, set them
% if you do not have standardized names, then make them

%fMRI data
files.func = '_applytopup.nii*';
%fMRI masks; 
%if unavailable, set as impty ( i.e. files.func.brain_mask = []; )
files.func_brain = '_mean_brain_mask.nii*';
files.func_CSF = [];
files.func_GM = 'seg1toBOLD.nii*';
files.func_WM = 'seg2toBOLD.nii*';
files.func_lesion = []; %future implementation
files.func_edema = []; %future implementation

%anatomical data
files.anat = 'T1.nii*';

end