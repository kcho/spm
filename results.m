<<<<<<< HEAD
% function xSPM = results(contrast, comparisonNum, ROI)
function [hReg, SPM, xSPM] = results(contrast, comparisonNum, ROI)

% contrast must be a 'str' eg contrast='01'
=======
function [hReg, SPM, xSPM] = results(matFile, comparisonNum, ROI)
% matFile : SPM.mat from second level analysis
>>>>>>> 710930e66b5366dd615549bda4f5dfc2e925e7a6
% comparisonNum
% 1 = group effect
% 2 = medication effect
% 3 = interaction

clear 'ROI'

contNameList = {'high_calorie > low_calorie' 'high calorie > neutral' 'low calorie > neutral' 'high_low_food > neutral' 'low calorie > high calorie' 'neutral > high calorie' 'neutral > low calorie' 'high_calorie > baseline' 'low calorie > baseline' 'baseline > high calorie' 'baseline > low calorie', 'high_low_food < neutral'};

comparisonName = {'GE_', 'ME_', 'Int_'};

if ~exist('ROI')
    [spmLoc, scriptName, ext] = fileparts(which('spm'));
    ROI=sprintf('%s/tpm/mask_ICV.nii', spmLoc);
end

[matFileDir, matFileName, matFileExt] = fileparts(which('matFile'));
[secondLevelDir, contrast] = fileparts(matFileDir);

clear xSPM 
clear SPM
<<<<<<< HEAD
%spmMat = strcat('/home/kangik/2016_CHJ/GLP_1/IMG_DATA/secondLevel/',contList(contNum),'/SPM.mat')
matFileName = sprintf('/home/kangik/2016_CHJ/GLP_1/IMG_DATA/secondLevel/%s/SPM.mat', contrast);
load(matFileName)
%spm_list('List', xSPM, hReg)
%spm_list('List',SPM,hReg)
% xSPM      - structure containing SPM, distribution & filtering details
=======
load(matFile)

>>>>>>> 710930e66b5366dd615549bda4f5dfc2e925e7a6
xSPM = SPM;
try
    xSPM.title    = strcat(comparisonName(comparisonNum), contNameList(str2num(contrast)));
catch
    xSPM.title    = sprintf('%s_%s', contrast, comparisonNum); 
    
xSPM.Ic       = comparisonNum;
xSPM.n        = 1;
xSPM.Z        = [];
xSPM.Im       = strcat(ROI,',1');
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
%xSPM.roi      = ROI;
xSPM.units = {'mm'  'mm'  'mm'};

<<<<<<< HEAD

%[SPM,xSPM] = spm_getSPM(xSPM);
[hReg,xSPM,SPM] = spm_results_ui('Setup',xSPM);
TabDat = spm_list('List',xSPM,hReg);
=======
[hReg,xSPM,SPM] = spm_results_ui('Setup',xSPM);
>>>>>>> 710930e66b5366dd615549bda4f5dfc2e925e7a6
