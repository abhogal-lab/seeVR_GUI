
function [seeVR elastix] = seeVR_set_variables(  )

%% Specify the directories of the toolbox here
seeVR     = 'E:\seeVR-main\'; %specify toolbox path with trailing slash
seeVR = fullfile(seeVR);

elastix   = 'C:\Users\abhogal\MATLAB\Projects\seeVR_GUI\functions\elastix'
elastix   = fullfile(elastix);

addpath(genpath(seeVR));

% if you have standardized filenames from pre-processing steps, set them

end