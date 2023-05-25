
function [seeVR elastix] = seeVR_set_variables(  )

%% Specify the directories of the toolbox here
seeVR     = 'E:\seeVR-main\'; %specify toolbox path with trailing slash

if ispc
elastix   = [seeVR,'elastix\']; 
else
elastix   = [seeVR,'elastix/'];   
end
addpath(genpath(seeVR));

% if you have standardized filenames from pre-processing steps, set them

end