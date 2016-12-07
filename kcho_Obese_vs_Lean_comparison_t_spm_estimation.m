function contrastSummary = kcho_Obese_vs_Lean_comparison_t_spm_estimation()
% This script runs the following
% 1. Set up a second level analysis for Obese vs Lean comparison
%    in each timepoints (S, G)
% 2. Estimates the second level analysis and adds contrast to the mat file
% 3. Runs spm_results, restricting the region to each ROIs.
%    The ROIs are located in '../ROIs'

dirList={'01' '02' '03' '04' '05' '06' '07' '08' '09' '10' '11'};
contNameList = {'high_calorie > low_calorie' 'high calorie > neutral' 'low calorie > neutral' 'high_low_food > neutral' 'low calorie > high calorie' 'neutral > high calorie' 'neutral > low calorie' 'high_calorie > baseline' 'low calorie > baseline' 'baseline > high calorie' 'baseline > low calorie'};
medStates = {'S', 'G'};

dataDir = '/home/kangik/2016_CHJ/GLP_1/IMG_DATA';
roiList = {'findlab_lh_DLPFC_thrp_90.nii','findlab_rh_DLPFC_thrp_90.nii','Harvard_lh_accumbens_thrp_70_flirt.nii','Harvard_rh_accumbens_thrp_70_flirt.nii','hypothalamus_10mm_0-10-7.nii','MNI_Amygdala_L.nii','MNI_Amygdala_R.nii','MNI_Caudate_L.nii','MNI_Caudate_R.nii','MNI_Cingulum_Ant_L.nii','MNI_Cingulum_Ant_R.nii','MNI_Frontal_Orb.nii','MNI_Frontal_Orb_L.nii','MNI_Frontal_Orb_R.nii','MNI_Fusiform_L.nii','MNI_Fusiform_R.nii','MNI_Insula_L.nii','MNI_Insula_R.nii','MNI_Putamen_L.nii','MNI_Putamen_R.nii'};
roiDir = '/home/kangik/2016_CHJ/GLP_1/IMG_DATA/ROIs/';

%subjects = {'CDH', 'CDJ', 'CDK', 'CSJ', 'HJC', 'HMS', 'JHS', 'JJR', 'JJY', 'JTS', 'KDS', 'KHS', 'KJW', 'KOS', 'KSO', 'KTH', 'KTO', 'KYC', 'KYH', 'LJS', 'LKB', 'LKH', 'MAS', 'NSW', 'PJO', 'SHJ', 'SJS', 'YOI', 'YSS'};

for contrastNum=1:length(dirList);
    contrastStr=dirList(contrastNum);
    % for each time points
    for medStateNum=1:length(medStates)
        clear matlabbatch
        medState = medStates(medStateNum);
        medState = medState{1};

        % output directory
        outputDir = sprintf('%s/Obese_vs_Lean_%s/%s', dataDir, medState, contrastStr{1});
        matlabbatch{1}.spm.stats.factorial_design.dir = {outputDir};


        groups = {'Obese', 'Lean'};
        for groupNum=1:length(groups)
            if groupNum==1
                subjectList = {'HMS', 'NSW', 'HJC', 'JHS', 'CSJ', 'CDJ', 'KTH', 'SHJ', 'KDS', 'LJS', 'KHS', 'KYH', 'KYC', 'JJR'};  %KJS removed;
                groupDataList = {};
                for subjNum=1:length(subjectList)
                    subjInitials = subjectList(subjNum);
                    subjInitials = subjInitials{1};

                    subjData = sprintf('%s/firstLevel/%s_%s/con_00%s.nii,1', ...
                                            dataDir, subjInitials, medState, contrastStr{1});
                    groupDataList{subjNum} = subjData;
                end
                matlabbatch{1}.spm.stats.factorial_design.des.t2.scans1 = transpose(groupDataList);

            elseif groupNum==2
                subjectList = {'JTS', 'JJY', 'MAS', 'LKB', 'KJW', 'KOS', 'KTO', 'KSO', 'YSS', 'CDK', 'YOI', 'SJS', 'PJO', 'CDH', 'LKH'};
                groupDataList = {};
                for subjNum=1:length(subjectList)
                    subjInitials = subjectList(subjNum);
                    subjInitials = subjInitials{1};

                    subjData = sprintf('%s/firstLevel/%s_%s/con_00%s.nii,1', ...
                                            dataDir, subjInitials, medState, contrastStr{1});
                    groupDataList{subjNum} = subjData;
                end
                matlabbatch{1}.spm.stats.factorial_design.des.t2.scans2 = transpose(groupDataList);
            end
        end

        matlabbatch{1}.spm.stats.factorial_design.des.t2.dept = 0;
        matlabbatch{1}.spm.stats.factorial_design.des.t2.variance = 1;
        matlabbatch{1}.spm.stats.factorial_design.des.t2.gmsca = 0;
        matlabbatch{1}.spm.stats.factorial_design.des.t2.ancova = 0;
        matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
        matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
        matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
        matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
        matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
        matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
        matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
        matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;


        %estimation
        matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
        matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
        matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

        %contrast setting
        matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
        matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'Obese > Lean';
        matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = [1 -1];
        matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
        matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'Obese < Lean';
        matlabbatch{3}.spm.stats.con.consess{2}.tcon.weights = [-1 1];
        matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
        matlabbatch{3}.spm.stats.con.delete = 0;

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %outlist = spm_jobman('run', matlabbatch);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        % Results
        % Looping through all ROIs
        
        for roiNum=1:length(roiList)
            roiName = roiList(roiNum);
            roiNameStr = roiName{1};
            roiLoc = sprintf('%s/%s', roiDir, roiNameStr);

            for comparisonNum=1:2
                if ~exist('ROI')
                    ROI='/home/kangik/Downloads/spm12/tpm/mask_ICV.nii';
                end

                clear xSPM 
                clear SPM
                matLocation = sprintf('%s/SPM.mat', outputDir);
                load(matLocation)
                xSPM = SPM;
                xSPM.swd      = outputDir;
                comparisonName = contNameList(str2num(contrastStr{1}));
                comparisonName = comparisonName{1};
                if comparisonNum ==1
                    xSPM.title    = sprintf('%s Obese > Lean / %s', medState, comparisonName);
                else
                    xSPM.title    = sprintf('%s Obese < Lean / %s', medState, comparisonName);
                end
                xSPM.Ic       = comparisonNum;
                xSPM.n        = 1;
                xSPM.Z        = [];
                xSPM.Im       = [];
                xSPM.Im       = strcat(roiLoc, ',1');
                xSPM.pm       = [];
                xSPM.Ex       = 0;
                xSPM.STAT = 'T';
                xSPM.u        = 0.05;
                xSPM.k        = 0;
                xSPM.thresDesc = 'FWE';
                %xSPM.roi      = roiLoc;
                xSPM.units = {'mm'  'mm'  'mm'};

                [hReg,xSPM,SPM] = spm_results_ui('Setup',xSPM);
                TabDat = spm_list('List',xSPM,hReg);
                outData{comparisonNum} = xSPM;

                if ~isempty(xSPM.XYZ)
                    target_xSPM_loc = sprintf('%s/Obese_vs_Lean_%s_%s_%d_xSPM.mat',...
                        dataDir, contrastNum, medState, comparisonNum)
                    save(target_xSPM_loc, 'xSPM')
                end
            end
            roiSummary{roiNum} = outData;
        end
        medStateSummary.(medState) = roiSummary;
    end
    contrastSummary{contrastNum}= medStateSummary;
end

save('contrastSummary', 'contrastSummary')
