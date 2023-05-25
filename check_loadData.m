function [data, props] = check_loadData(dirs, files)
global opts;
data = [];
% check func data
cd(dirs.datapath)

% anatomical image
if isempty(files.anat)
disp('no anatomical has been specified in the seeVR_set_variables.mat file')
else
try %does anat path exist
f = fullfile(dirs.datapath, dirs.anat);
cd(f)
disp('anatomical directory found: checking for data')
try % does anat data exist
sourcefile = ls(['*',files.anat]);
disp(['attempting to load: ',fullfile(f, sourcefile)])
[data.anat,~] = loadAnat(f,sourcefile);
[props.xdim_T1, aprops.ydim_T1, props.zdim_T1] = size(data.anat);     
disp('anat data loaded succesfully')
data.anat = double(imrotate(data.anat,90)); %cast inputs to double
props.isT1 = 1;
catch
error('The functional data filename appears incorrect. Please check for ambiguous filenames or update the seeVR_set_variables.m file')
end 
catch
error('The path to functional data appears incorrect. Please check directory structure or update the seeVR_set_variables.m file')
end

try %does func path exist
f = fullfile(dirs.datapath, dirs.func);
cd(f)
disp('functional directory found: checking for data')
try % does func data exist
sourcefile = ls(['*',files.func])
disp(['attempting to load: ',fullfile(f, sourcefile)])
[data.sourceData,~] = loadTimeseries(f,sourcefile);
[props.xdim, props.ydim, props.zdim, props.vols] = size(data.sourceData);     
disp('func data loaded succesfully')
data.sourceData = double(imrotate(data.sourceData,90)); %cast inputs to double
catch
error('The functional data filename appears incorrect. Please check for ambiguous filenames or update the seeVR_set_variables.m file')
end 
catch
error('The path to functional data appears incorrect. Please check directory structure or update the seeVR_set_variables.m file')
end

disp('checking for masks...')

if isempty(files.func_brain)
disp('no whole brain mask is specified; running brain extraction tool using default parameters')
matrix_size = [props.xdim, props.ydim, props.zdim];
voxel_size = opts.voxelsize;
data.mask = BET(mean(data.sourceData,4),matrix_size,voxel_size,0.5);
else
    disp('checking for whole brain func mask')
    try % does func brain mask exist
    maskfile = ls(['*',files.func_brain])
    disp(['attempting to load: ',fullfile(f, maskfile)])
    [data.mask.WB,~] = loadMask(f,maskfile);
    disp('func data brain mask loaded succesfully')
    data.mask.WB = logical(imrotate(data.mask.WB,90)); %cast mask to logical
    catch
    error('The mask filename appears incorrect. Please check for ambiguous filenames or update the seeVR_set_variables.m file')
    end
end

% GM mask
if isempty(files.func_GM)
disp('no GM mask has been specified in the seeVR_set_variables.mat file')
else
    disp('checking for GM func mask')
    try % does func GM mask exist
    maskfile = ls(['*',files.func_GM]);
    disp(['attempting to load: ',fullfile(f, maskfile)])
    [data.mask.GM,~] = loadMask(f,maskfile);
    disp('func GM mask loaded succesfully')
    data.mask.GM = logical(imrotate(data.mask.GM,90)); %cast mask to logical
    catch
    error('The GM mask filename appears incorrect. Please check for ambiguous filenames or update the seeVR_set_variables.m file')
    end
end

% WM mask
if isempty(files.func_WM)
disp('no WM mask has been specified in the seeVR_set_variables.mat file')
else
    disp('checking for WM func mask')
    try % does func WM mask exist
    maskfile = ls(['*',files.func_GM]);
    disp(['attempting to load: ',fullfile(f, maskfile)])
    [data.mask.WM,~] = loadMask(f,maskfile);
    disp('func WM mask loaded succesfully')
    data.mask.WM = logical(imrotate(data.mask.WM,90));  %cast mask to logical
    catch
    error('The WM mask filename appears incorrect. Please check for ambiguous filenames or update the seeVR_set_variables.m file')
    end
end

% CSF mask
if isempty(files.func_CSF)
disp('no CSF mask has been specified in the seeVR_set_variables.mat file')
else
    disp('checking for WM func mask')
    try % does func CSF mask exist
    maskfile = ls(['*',files.func_CSF]);
    disp(['attempting to load: ',fullfile(f, maskfile)])
    [data.mask.CSF,~] = loadMask(f,maskfile);
    disp('func CSF mask loaded succesfully')
    data.mask.CSF = logical(imrotate(data.mask.CSF,90));  %cast mask to logical
    catch
    error('The CSF mask filename appears incorrect. Please check for ambiguous filenames or update the seeVR_set_variables.m file')
    end
end 

cd(dirs.datapath)
end

