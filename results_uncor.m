function [hReg, SPM, xSPM] = results_uncor(matFile, comparisonNum, pThresh, k, ROI)
% matFile : SPM.mat from second level analysis
% comparisonNum
% 1 = group effect
% 2 = medication effect
% 3 = interaction

%clear 'ROI'

%contNameList = {'high_calorie > low_calorie' 'high calorie > neutral' 'low calorie > neutral' 'high_low_food > neutral' 'low calorie > high calorie' 'neutral > high calorie' 'neutral > low calorie' 'high_calorie > baseline' 'low calorie > baseline' 'baseline > high calorie' 'baseline > low calorie', 'high_low_food < neutral'};
contNameList = {'high calorie > low calorie', 'high calorie < low calorie', 'high calorie > neutral', 'high calorie < neutral', 'high_low_food > neutral', 'high_low_food < neutral'};


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
end
    
xSPM.Ic       = comparisonNum;
xSPM.n        = 1;
xSPM.Z        = [];
xSPM.Im       = {strcat(ROI,',1')};
xSPM.pm       = [];
xSPM.Ex       = [];

if comparisonNum == 3
    xSPM.STAT = 'F';
    xSPM.u        = pThresh;
    %xSPM.u        = 15.8427;
else
    xSPM.STAT = 'T';
    xSPM.u        = pThresh;
end

xSPM.k         = k;
xSPM.thresDesc = 'none';
%xSPM.thresDesc = 'FWE';
%xSPM.roi      = ROI;
xSPM.units = {'mm'  'mm'  'mm'};

%[SPM,xSPM] = spm_getSPM(xSPM);
[hReg,xSPM,SPM] = spm_results_ui('Setup',xSPM);
TabDat = spm_list('List',xSPM,hReg);

cd /home/kangik/2016_CHJ/GLP_1/IMG_DATA
