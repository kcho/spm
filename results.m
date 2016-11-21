function [hReg, SPM, xSPM] = results(matFile, comparisonNum, ROI)
% matFile : SPM.mat from second level analysis
% comparisonNum
% 1 = group effect
% 2 = medication effect
% 3 = interaction

clear 'ROI'

contNameList = {'high_calorie > low_calorie' 'high calorie > neutral' 'low calorie > neutral' 'high_low_food > neutral' 'low calorie > high calorie' 'neutral > high calorie' 'neutral > low calorie' 'high_calorie > baseline' 'low calorie > baseline' 'baseline > high calorie' 'baseline > low calorie'};

comparisonName = {'GE_', 'ME_', 'Int_'};

if ~exist('ROI')
    [spmLoc, scriptName, ext] = fileparts(which('spm'));
    ROI=sprintf('%s/tpm/mask_ICV.nii', spmLoc);
end

[matFileDir, matFileName, matFileExt] = fileparts(which('matFile'));
[secondLevelDir, contrast] = fileparts(matFileDir);

clear xSPM 
clear SPM
load(matFile)

xSPM = SPM;
try
    xSPM.title    = strcat(comparisonName(comparisonNum), contNameList(str2num(contrast)));
catch
    xSPM.title    = sprintf('%s_%s', contrast, comparisonNum); 
    
xSPM.Ic       = comparisonNum;
xSPM.n        = 1;
xSPM.Z        = [];
xSPM.Im       = [];
xSPM.pm       = [];
xSPM.Ex       = [];

if comparisonNum == 3
    xSPM.STAT = 'F';
    xSPM.u        = 0.05;
    %xSPM.u        = 15.8427;
else
    xSPM.STAT = 'T';
    xSPM.u        = 0.05;
end

xSPM.k        = 0;
xSPM.thresDesc = 'FWE';
xSPM.roi      = ROI;
xSPM.units = {'mm'  'mm'  'mm'};

[hReg,xSPM,SPM] = spm_results_ui('Setup',xSPM);
