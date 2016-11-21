function GLP_process(dataDir)
% Automatic processing of the GLP-1 project. Requires spm12
%
% GLP_process(dataDir)
%
% 'dataDir' : Root directory of the fMRI directory.
% 'dpabi' : Directory containing preprocessed files of all subjects. It should
%           have a directory called 'FunImgARWS' which contains the preprocessed
%           image of all subjects.
% 'firstLevel' : Directory containing first level analysis for all contrasts.
% 'secondLevel' : directory containing second level analysis for all contrast
%
% If there is an error about the modality during running, 
% please run 'spm fmri' in the commandline console first.
%
% Examples:
% GLP_process('~/Dropbox/project/2016_CHJ/GLP-1/fMRI')
%
% See also:
% extract_mean_values
% first_level_analysis

clear;

global defaults;
defaults = spm_get_defaults;

if ~exist('dataDir')
    dataDir = '/home/kangik/2016_CHJ/GLP_1/IMG_DATA/';
end

preprocDir = sprintf('%s/dpabi/FunImgARWS', dataDir);
roiDir = sprintf('%s/ROIs', dataDir);

subjects = {'CDH','CDJ','CDK','CSJ','HJC','HMS','JHS','JJR','JJY','JTS','KDS','KHS','KJW','KOS','KSO','KTH','KTO','KYC','KYH','LJS','LKB','LKH','MAS','NSW','PJO','SHJ','SJS','YOI','YSS'};
treatment = {'G','S'};
Obese = {'HMS', 'NSW', 'HJC', 'JHS', 'CSJ', 'CDJ', 'KTH', 'SHJ', 'KDS', 'LJS', 'KHS', 'KYH', 'KYC', 'JJR'};  %KJS removed;
Lean = {'JTS', 'JJY', 'MAS', 'LKB', 'KJW', 'KOS', 'KTO', 'KSO', 'YSS', 'CDK', 'YOI', 'SJS', 'PJO', 'CDH', 'LKH'};

contrastList = {'01','02','03','04','05','06','07','08','09','10','11'};


roiList = {'findlab_lh_DLPFC_thrp_90.nii','findlab_rh_DLPFC_thrp_90.nii','Harvard_lh_accumbens_thrp_70_flirt.nii','Harvard_rh_accumbens_thrp_70_flirt.nii','hypothalamus_10mm_0-10-7.nii','MNI_Amygdala_L.nii','MNI_Amygdala_R.nii','MNI_Caudate_L.nii','MNI_Caudate_R.nii','MNI_Cingulum_Ant_L.nii','MNI_Cingulum_Ant_R.nii','MNI_Frontal_Orb.nii','MNI_Frontal_Orb_L.nii','MNI_Frontal_Orb_R.nii','MNI_Fusiform_L.nii','MNI_Fusiform_R.nii','MNI_Insula_L.nii','MNI_Insula_R.nii','MNI_Putamen_L.nii','MNI_Putamen_R.nii'};

comparisonName = {'GE_', 'ME_', 'Int_'};
%comparisonName = {'GE_', 'ME_'};

%first_level_analysis(subjects, treatment, preprocDir)
%second_level_analysis(subjects, treatment, Obese, Lean)

significance = {};
for contrastNum=1:length(contrastList)
    contrast = contrastList(contrastNum);
    for roiNum=1:length(roiList)
        ROI=roiList(roiNum);
        ROILoc = strcat(roiDir, ROI);
        for comparisonNum=1:length(comparisonName)
            [hReg, SPM, xSPM] = results(contrast{1}, comparisonNum, ROILoc{1});
            TabDat = spm_list('List',xSPM,hReg);
            if ~isempty(xSPM.XYZ)
                target_xSPM_loc = sprintf('%s/%s_%s_%d_xSPM.mat', dataDir, contrast{1}, ROI{1}, comparisonNum)
                save(target_xSPM_loc, 'xSPM')
                %extract_mean_values_ROI(SPM, xSPM)
            end
            clear SPM
            clear xSPM
        end
    end
    display('====================================');
    display('====================================');
    display('====================================');
    display('====================================');
end
