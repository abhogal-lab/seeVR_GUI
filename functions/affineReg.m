function [image] = affineReg(moveImg, moveMask, refImg, refMask, param_af, regdir, elastixDir)
global opts
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%check for regdir

if ispc
    elastixDir = fullfile(elastixDir,'windows');
else if ismac
        elastixDir = fullfile(elastixDir,'mac');
    else
        elastixDir = fullfile(elastixDir,'linux');
    end
end

affine_command = [fullfile(elastixDir,'elastix'),' -f ',refImg,' -fmask ',refMask, ' -m ',moveImg,' -mmask ',moveMask,' -p ',param_af,' -out ',regdir ];
dos(affine_command);

% load registered image
[image,~] = loadImage(regdir, 'result.0.nii.gz'); 

end

