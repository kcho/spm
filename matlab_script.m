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
    dataDir = '/home/kangik/2016_CHJ/GLP_1/IMG_DATA';
end

preprocDir = sprintf('%s/dpabi/FunImgARWS', dataDir);
roiDir = sprintf('%s/ROIs', dataDir);

subjects = {'CDH','CDJ','CDK','CSJ','HJC','HMS','JHS','JJR','JJY','JTS','KDS','KHS','KJW','KOS','KSO','KTH','KTO','KYC','KYH','LJS','LKB','LKH','MAS','NSW','PJO','SHJ','SJS','YOI','YSS'};
treatment = {'G','S'};

% 0.071428571
Obese = {'HMS', 'NSW', 'HJC', 'JHS', 'CSJ', 'CDJ', 'KTH', 'SHJ', 'KDS', 'LJS', 'KHS', 'KYH', 'KYC', 'JJR'};  %KJS removed;

% 0.066666667
Lean  = {'JTS', 'JJY', 'MAS', 'LKB', 'KJW', 'KOS', 'KTO', 'KSO', 'YSS', 'CDK', 'YOI', 'SJS', 'PJO', 'CDH', 'LKH'};


%contrastList = {'01','02','03','04','05','06','07','08','09','10','11'};
%contrastList = {'01','02','03','04','05','06','07','08','09','10','11','12'};
%contrastList = {'01','02','03','04','05','06','07','08','09','10','11','12'};
contrastList = {'01','02','03','04','05','06'};
%contrastList = {'08','09','10','11','12'};
%contrastList = {'07'};

roiList = {'findlab_lh_DLPFC_thrp_90.nii','findlab_rh_DLPFC_thrp_90.nii','Harvard_lh_accumbens_thrp_70_flirt.nii','Harvard_rh_accumbens_thrp_70_flirt.nii','hypothalamus_10mm_0-10-7.nii','MNI_Amygdala_L.nii','MNI_Amygdala_R.nii','MNI_Caudate_L.nii','MNI_Caudate_R.nii','MNI_Cingulum_Ant_L.nii','MNI_Cingulum_Ant_R.nii','MNI_Frontal_Orb.nii','MNI_Frontal_Orb_L.nii','MNI_Frontal_Orb_R.nii','MNI_Fusiform_L.nii','MNI_Fusiform_R.nii','MNI_Insula_L.nii','MNI_Insula_R.nii','MNI_Putamen_L.nii','MNI_Putamen_R.nii'};

comparisonName = {'Int_', 'ME_', 'GE_'};
%comparisonName = {'GE_', 'ME_', 'Int_'};
%comparisonName = {'GE_', 'ME_'};
%comparisonName = {'Int_', 'ME_'};

%first_level_analysis(subjects, treatment, preprocDir, Obese, Lean)
%second_level_analysis(subjects, treatment, Obese, Lean)


for contrastNum=1:length(contrastList)
    for comparisonNum=1:length(comparisonName)
        contrast = contrastList(contrastNum);
        comparison = comparisonName(comparisonNum);

        pThresh = 0.001;
        %k = 5;
        %k = 10;
        %k = 15;
        %k = 20;

        matLoc = sprintf('%s/%s/SPM.mat', '/home/kangik/2016_CHJ/GLP_1/IMG_DATA/secondLevel_inter_med', contrast{1});
        [hReg, SPM, xSPM] = results_uncor(matLoc, comparisonNum, pThresh, k);
        %[hReg, SPM, xSPM] = results(matLoc, comparisonNum);
        TabDat = spm_list('List',xSPM,hReg);
        if ~isempty(xSPM.XYZ)
            target_xSPM_loc = sprintf('%s/Inter_Med_Group_uncor_001_K%d_%s_%sxSPM.mat', dataDir, k, contrast{1}, comparison{1})
            %target_xSPM_loc = sprintf('%s/Inter_Med_Group_FWE_%d_%s_%d_xSPM.mat', dataDir, contrast{1}, comparisonNum)
            save(target_xSPM_loc, 'xSPM', 'hReg', 'SPM')
            %extract_mean_values_ROI(SPM, xSPM)
            xSPM
        end
        clear SPM
        clear xSPM

    end
end

    %% ROI analysis
    %contrast = contrastList(contrastNum);
    %for roiNum=1:length(roiList)
        %ROI=roiList(roiNum);
        %ROILoc = sprintf('%s/%s',roiDir, ROI{1});
        %for comparisonNum=1:length(comparisonName)
            %comparison = comparisonName(comparisonNum);
            %matLoc = sprintf('%s/%s/SPM.mat', '/home/kangik/2016_CHJ/GLP_1/IMG_DATA/secondLevel_inter_med', contrast{1});

            %pThresh = 0.0001;
            %k = 30;

            %%[hReg, SPM, xSPM] = results(matLoc, comparisonNum, ROILoc);
            %%[hReg, SPM, xSPM] = results_FDR(matLoc, comparisonNum, ROILoc);
            %%[hReg, SPM, xSPM] = results_uncor(matLoc, comparisonNum, ROILoc);
            %[hReg, SPM, xSPM] = results_uncor(matLoc, comparisonNum, pThresh, k);
            %TabDat = spm_list('List',xSPM,hReg);
            %if ~isempty(xSPM.XYZ)
                %target_xSPM_loc = sprintf('%s/uncor_0001k30_%s_%s_%sxSPM.mat', dataDir, contrast{1}, ROI{1}, comparison{1})
                %display('====================================');
                %display('%s/FWE_%s_%s_%s_xSPM.mat', dataDir, contrast{1}, ROI{1}, comparison{1});
                %display('====================================');

                %%target_xSPM_loc = sprintf('%s/FWE_%s_%s_%s_xSPM.mat', dataDir, contrast{1}, ROI{1}, comparison{1});
                %save(target_xSPM_loc, 'xSPM', 'hReg', 'SPM')
                %%extract_mean_values_ROI(SPM, xSPM)
                %xSPM
            %end
            %clear SPM
            %clear xSPM
        %end
    %end
    %display('====================================');
    %display('====================================');
    %display('====================================');
    %display('====================================');
%end

cd /home/kangik/2016_CHJ/GLP_1/IMG_DATA
