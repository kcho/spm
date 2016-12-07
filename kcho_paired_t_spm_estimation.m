function kcho_paired_t_spm_estimation()
dirList={'01' '02' '03' '04' '05' '06' '07' '08' '09' '10' '11'};
contNameList = {'high_calorie > low_calorie' 'high calorie > neutral' 'low calorie > neutral' 'high_low_food > neutral' 'low calorie > high calorie' 'neutral > high calorie' 'neutral > low calorie' 'high_calorie > baseline' 'low calorie > baseline' 'baseline > high calorie' 'baseline > low calorie'};

for i=1:length(dirList)
    comparisonName = contNameList(i);
    numStr = dirList(i);
    matlabbatch{1}.spm.stats.factorial_design.dir = strcat('/home/kangik/2016_CHJ/GLP_1/IMG_DATA/GLP_vs_Saline_pairedT/', numStr);

    subjects = {'CDH', 'CDJ', 'CDK', 'CSJ', 'HJC', 'HMS', 'JHS', 'JJR', 'JJY', 'JTS', 'KDS', 'KHS', 'KJW', 'KOS', 'KSO', 'KTH', 'KTO', 'KYC', 'KYH', 'LJS', 'LKB', 'LKH', 'MAS', 'NSW', 'PJO', 'SHJ', 'SJS', 'YOI', 'YSS'};

    for subjNum=1:29
        subjInitials = subjects(subjNum);
        line_1 = sprintf('/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/%s_G/beta_00%s.nii,1', subjInitials{1}, numStr{1});
        line_2 = sprintf('/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/%s_S/beta_00%s.nii,1', subjInitials{1}, numStr{1});
        matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(subjNum).scans = {
              line_1
              line_2
              };
    end

    matlabbatch{1}.spm.stats.factorial_design.des.pt.gmsca = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.pt.ancova = 0;
    matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
    matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
    matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
    matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
    matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
    matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
    matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
    matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
    matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
    matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
    matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
    matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'GLP > Saline';
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = [1 -1];
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'GLP < Saline';
    matlabbatch{3}.spm.stats.con.consess{2}.tcon.weights = [-1 1];
    matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.delete = 0;
    outlist = spm_jobman('run', matlabbatch);
end


    %load 01/paired_t_beta_01.mat
    %newDir = strcat(pwd, '/', dirList(i));
    %newConNum = strcat('00', dirList(i));
    %matlabbatch{1}.spm.stats.factorial_design.dir = newDir;
  
    %for subjNum=1:29
        %for cellNum=1:2
            %orig=matlabbatch{1,1}.spm.stats.factorial_design.des.pt.pair(subjNum).scans{cellNum, 1};
            %new = regexprep(orig, 'beta_0001',strcat('con_', newConNum));      
            %matlabbatch{1,1}.spm.stats.factorial_design.des.pt.pair(subjNum).scans{cellNum, 1} = new;

        %end
        
    %end
    %outlist = spm_jobman('run', matlabbatch)    
%end



%%-----------------------------------------------------------------------
%% Job saved on 28-Oct-2016 16:34:55 by cfg_util (rev $Rev: 6460 $)
%% spm SPM - SPM12 (6685)
%% cfg_basicio BasicIO - Unknown
%%-----------------------------------------------------------------------
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(1).scans = {
                                                                  %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/CDH_G/beta_0001.nii,1'
                                                                  %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/CDH_S/beta_0001.nii,1'
                                                                  %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(2).scans = {
                                                                  %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/CDJ_G/beta_0001.nii,1'
                                                                  %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/CDJ_S/beta_0001.nii,1'
                                                                  %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(3).scans = {
                                                                  %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/CDK_G/beta_0001.nii,1'
                                                                  %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/CDK_S/beta_0001.nii,1'
                                                                  %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(4).scans = {
                                                                  %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/CSJ_G/beta_0001.nii,1'
                                                                  %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/CSJ_S/beta_0001.nii,1'
                                                                  %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(5).scans = {
                                                                  %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/HJC_G/beta_0001.nii,1'
                                                                  %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/HJC_S/beta_0001.nii,1'
                                                                  %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(6).scans = {
                                                                  %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/HMS_G/beta_0001.nii,1'
                                                                  %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/HMS_S/beta_0001.nii,1'
                                                                  %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(7).scans = {
                                                                  %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/JHS_G/beta_0001.nii,1'
                                                                  %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/JHS_S/beta_0001.nii,1'
                                                                  %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(8).scans = {
                                                                  %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/JJR_G/beta_0001.nii,1'
                                                                  %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/JJR_S/beta_0001.nii,1'
                                                                  %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(9).scans = {
                                                                  %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/JJY_G/beta_0001.nii,1'
                                                                  %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/JJY_S/beta_0001.nii,1'
                                                                  %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(10).scans = {
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/JTS_G/beta_0001.nii,1'
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/JTS_S/beta_0001.nii,1'
                                                                   %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(11).scans = {
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/KDS_G/beta_0001.nii,1'
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/KDS_S/beta_0001.nii,1'
                                                                   %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(12).scans = {
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/KHS_G/beta_0001.nii,1'
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/KHS_S/beta_0001.nii,1'
                                                                   %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(13).scans = {
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/KJW_G/beta_0001.nii,1'
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/KJW_S/beta_0001.nii,1'
                                                                   %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(14).scans = {
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/KOS_G/beta_0001.nii,1'
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/KOS_S/beta_0001.nii,1'
                                                                   %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(15).scans = {
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/KSO_G/beta_0001.nii,1'
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/KSO_S/beta_0001.nii,1'
                                                                   %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(16).scans = {
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/KTH_G/beta_0001.nii,1'
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/KTH_S/beta_0001.nii,1'
                                                                   %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(17).scans = {
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/KTO_G/beta_0001.nii,1'
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/KTO_S/beta_0001.nii,1'
                                                                   %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(18).scans = {
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/KYC_G/beta_0001.nii,1'
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/KYC_S/beta_0001.nii,1'
                                                                   %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(19).scans = {
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/KYH_G/beta_0001.nii,1'
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/KYH_S/beta_0001.nii,1'
                                                                   %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(20).scans = {
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/LJS_G/beta_0001.nii,1'
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/LJS_S/beta_0001.nii,1'
                                                                   %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(21).scans = {
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/LKB_G/beta_0001.nii,1'
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/LKB_S/beta_0001.nii,1'
                                                                   %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(22).scans = {
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/LKH_G/beta_0001.nii,1'
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/LKH_S/beta_0001.nii,1'
                                                                   %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(23).scans = {
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/MAS_G/beta_0001.nii,1'
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/MAS_S/beta_0001.nii,1'
                                                                   %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(24).scans = {
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/NSW_G/beta_0001.nii,1'
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/NSW_S/beta_0001.nii,1'
                                                                   %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(25).scans = {
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/PJO_G/beta_0001.nii,1'
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/PJO_S/beta_0001.nii,1'
                                                                   %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(26).scans = {
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/SHJ_G/beta_0001.nii,1'
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/SHJ_S/beta_0001.nii,1'
                                                                   %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(27).scans = {
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/SJS_G/beta_0001.nii,1'
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/SJS_S/beta_0001.nii,1'
                                                                   %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(28).scans = {
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/YOI_G/beta_0001.nii,1'
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/YOI_S/beta_0001.nii,1'
                                                                   %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(29).scans = {
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/YSS_G/beta_0001.nii,1'
                                                                   %'/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/YSS_S/beta_0001.nii,1'
                                                                   %};
%matlabbatch{1}.spm.stats.factorial_design.des.pt.gmsca = 0;
%matlabbatch{1}.spm.stats.factorial_design.des.pt.ancova = 0;
%matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
%matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
%matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
%matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
%matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
%matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
%matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
%matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
%matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
%matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
%matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
%matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
%matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'GLP > Saline';
%matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = [1 -1];
%matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
%matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'GLP < Saline';
%matlabbatch{3}.spm.stats.con.consess{2}.tcon.weights = [-1 1];
%matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
%matlabbatch{3}.spm.stats.con.delete = 0;

