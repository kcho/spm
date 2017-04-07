function GLP_process(dataDir)
% GLP-1 project processing script 
% - It requires spm12
%
% How to run
% - GLP_process(dataDir)
%
% Examples:
% GLP_process('~/Dropbox/project/2016_CHJ/GLP-1/fMRI')
%
%
% 'dataDir' : Root directory of the fMRI directory.
% 'dataDir/dpabi' : Directory containing preprocessed files of all subjects. It should
%                   have a directory called 'FunImgARWS' which contains the preprocessed
%                   image of all subjects.
% 'dataDir/firstLevel'  : Directory containing first level analysis for all contrasts.
% 'dataDir/secondLevel' : Directory containing second level analysis for all contrast
%
% There may be an error stating problem in "modality".
% Running 'spm fmri' in the commandline console first, solves the problem.
%
% See also:
% 1_first_level_analysis
% 2_second_level_analysis
% 3_extract_mean_values_ROI_new.m

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

% Compare interaction, medication effect and group effect
comparisonName = {'Int_', 'ME_', 'GE_'};

%1_first_level_analysis(subjects, treatment, preprocDir, Obese, Lean)
%2_second_level_analysis(subjects, treatment, Obese, Lean)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Whole-brain analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Looping through all contrasts
for contrastNum=1:length(contrastList)
    % Looping through medication / group / interaction effect
    for comparisonNum=1:length(comparisonName)
        contrast = contrastList(contrastNum); % which contrast
        comparison = comparisonName(comparisonNum); % which effect

        pThresh = 0.001; %p-value threshold
        k = 5; %cluter-size threshold
        %%k = 10;
        %%k = 15;
        %%k = 20;


        % Define second level analysis matrix location
        matLoc = sprintf('%s/%s/SPM.mat', ...
                         '/home/kangik/2016_CHJ/GLP_1/IMG_DATA/3_secondLevel_inter_med', ...
                         contrast{1});

        % Return uncorrected GLM result with pThresh and k
        [hReg, SPM, xSPM] = results_uncor(matLoc, comparisonNum, pThresh, k);
        %[hReg, SPM, xSPM] = results(matLoc, comparisonNum);

        % Table output from the GLM comparison
        TabDat = spm_list('List', xSPM, hReg);

        % If there is cluster above the pThresh and k
        if ~isempty(xSPM.XYZ)
            % Save the GLM result
            target_xSPM_loc = sprintf('%s/Inter_Med_Group_uncor_001_K%d_%s_%sxSPM.mat', ...
                                       dataDir, k, contrast{1}, comparison{1})
            save(target_xSPM_loc, 'xSPM', 'hReg', 'SPM')

            %target_xSPM_loc = sprintf('%s/Inter_Med_Group_FWE_%d_%s_%d_xSPM.mat', ...
                                      %dataDir, contrast{1}, comparisonNum)

            % Extract mean beta estimate in the significant cluster                            
            4_extract_mean_values_ROI_new(SPM, xSPM)

            %xSPM
        end
        clear SPM
        clear xSPM
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ROI analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Looping through all contrasts
for contrastNum=1:length(contrastList)
    contrast = contrastList(contrastNum);
    % Looping through all ROIs
    for roiNum=1:length(roiList)
        ROI=roiList(roiNum);
        ROILoc = sprintf('%s/%s',roiDir, ROI{1});
        % Looping through medication / group / interaction effect
        for comparisonNum=1:length(comparisonName)
            comparison = comparisonName(comparisonNum);

            matLoc = sprintf('%s/%s/SPM.mat', ...
                             '/home/kangik/2016_CHJ/GLP_1/IMG_DATA/secondLevel_inter_med', ...
                             contrast{1});

            pThresh = 0.001;
            k = 5;

            %[hReg, SPM, xSPM] = results(matLoc, comparisonNum, ROILoc);
            %[hReg, SPM, xSPM] = results_FDR(matLoc, comparisonNum, ROILoc);
            %[hReg, SPM, xSPM] = results_uncor(matLoc, comparisonNum, ROILoc);
            [hReg, SPM, xSPM] = results_uncor(matLoc, comparisonNum, pThresh, k, ROILoc);
            TabDat = spm_list('List',xSPM,hReg);

            if ~isempty(xSPM.XYZ)
                target_xSPM_loc = sprintf('%s/uncor_001k5_%s_%s_%sxSPM.mat', ...
                                          dataDir, contrast{1}, ROI{1}, comparison{1})
                %display('====================================');
                %display('%s/FWE_%s_%s_%s_xSPM.mat', dataDir, contrast{1}, ROI{1}, comparison{1});
                %display('====================================');
                save(target_xSPM_loc, 'xSPM', 'hReg', 'SPM')
                4_extract_mean_values_ROI_new(SPM, xSPM)
                xSPM
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

cd /home/kangik/2016_CHJ/GLP_1/IMG_DATA
