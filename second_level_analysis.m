function second_level_analysis(subjects, treatment, Obese, Lean)
clear matlabbatch
% Second level analysis
contList={'01' '02' '03' '04' '05' '06' '07' '08' '09' '10' '11'};
for contNum=1:length(contList) %contrast number
    outDir_second = strcat('/home/kangik/2016_CHJ/GLP_1/IMG_DATA/secondLevel/',contList(contNum))
    matlabbatch{1}.spm.stats.factorial_design.dir = outDir_second;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).name = 'subject';
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).dept = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).variance = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).gmsca = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).ancova = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).name = 'Group';
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).dept = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).variance = 1;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).gmsca = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).ancova = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).name = 'Condition';
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).dept = 1;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).variance = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).gmsca = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).ancova = 0;

    for i=1:length(subjects)
        imgList = {}
        for j=1:length(treatment)
            firstLevel_cont_img = strcat('/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/',subjects(i), '_', treatment(j),'/con_00',contList(contNum),'.nii,1');
            imgList = [imgList; firstLevel_cont_img];
        end
        matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(i).scans = imgList;

        if ismember(subjects(i), Obese)
            condMat = [1 2;1 1];
        else
            condMat = [2 2;2 1];
        end
        matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(i).conds = condMat
    end

    matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{1}.fmain.fnum = 1;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{2}.fmain.fnum = 2;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{3}.fmain.fnum = 3;
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{4}.inter.fnums = [2
                                                                                      3];
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
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'Group_effect';
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = [1 -1 0 0 0.5 0.5 -0.5 -0.5 -0.0666666666666667 0.0714285714285714 -0.0666666666666667 0.0714285714285714 0.0714285714285714 0.0714285714285714 0.0714285714285714 0.0714285714285714 -0.0666666666666667 -0.0666666666666667 0.0714285714285714 0.0714285714285714 -0.0666666666666667 -0.0666666666666667 -0.0666666666666667 0.0714285714285714 -0.0666666666666667 0.0714285714285714 0.0714285714285714 0.0714285714285714 -0.0666666666666667 -0.0666666666666667 -0.0666666666666667 0.0714285714285714 -0.0666666666666667 0.0714285714285714 -0.0666666666666667 -0.0666666666666667 -0.0666666666666667];
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'Medication_effect';
    matlabbatch{3}.spm.stats.con.consess{2}.tcon.weights = [0 0 1 -1 0.482758620689655 -0.482758620689655 0.517241379310345 -0.517241379310345 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.consess{3}.fcon.name = 'Interaction';
    matlabbatch{3}.spm.stats.con.consess{3}.fcon.weights = [0 0 0 0 1 -1 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    matlabbatch{3}.spm.stats.con.consess{3}.fcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.delete = 0;

    savefile = strcat('second_level_matlabbatch_cont_',contList(contNum))
    save(savefile{1},'matlabbatch')
    outlist = spm_jobman('run', matlabbatch);
end
