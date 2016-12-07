%% First level analysis
function first_level_analysis(subjects, treatment, preprocDir)
for i=1:length(subjects)
    for j=1:length(treatment)
        preprocData = strcat(preprocDir,'/', subjects(i), '_', treatment(j), '/swra', subjects(i), '_', treatment(j), '.nii')
        display(preprocData)
        outputDir = strcat('/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/', subjects(i), '_', treatment(j))

        matlabbatch{1}.spm.stats.fmri_spec.dir = outputDir;
        matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
        matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2;
        matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 34;
        matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 17;

        scanList = {}
        for num=1:176
            scanList = [scanList; strcat(preprocData{1}, ',', int2str(num))];
        end
        class(scanList)
        %%
        matlabbatch{1}.spm.stats.fmri_spec.sess.scans = scanList;
        %%
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).name = 'baseline';
        %%
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).onset = [0
                                                                 26
                                                                 56
                                                                 86
                                                                 116
                                                                 146
                                                                 176
                                                                 202
                                                                 232
                                                                 262
                                                                 292
                                                                 322];
        %%
        %%
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).duration = [5
                                                                    9
                                                                    9
                                                                    9
                                                                    9
                                                                    9
                                                                    5
                                                                    9
                                                                    9
                                                                    9
                                                                    9
                                                                    9];
        %%
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).orth = 1;
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).name = 'high_calorie';
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).onset = [5
                                                                 125
                                                                 211
                                                                 271];
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).duration = [21
                                                                    21
                                                                    21
                                                                    21];
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).orth = 1;
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).name = 'low_calorie';
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).onset = [35
                                                                 95
                                                                 181
                                                                 301];
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).duration = [21
                                                                    21
                                                                    21
                                                                    21];
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).orth = 1;
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).name = 'neutral';
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).onset = [65
                                                                 155
                                                                 241
                                                                 331];
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).duration = [21
                                                                    21
                                                                    21
                                                                    21];
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
        matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).orth = 1;
        matlabbatch{1}.spm.stats.fmri_spec.sess.multi = {''};
        matlabbatch{1}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});

        motionText = strcat('/home/kangik/2016_CHJ/GLP_1/IMG_DATA/dpabi/RealignParameter/',subjects(i), '_', treatment(j),'/rp_a', subjects(i), '_', treatment(j),'.txt');

        matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = motionText;
        matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 128;
        matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
        matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
        matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
        matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
        matlabbatch{1}.spm.stats.fmri_spec.mthresh = -Inf;
        matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
        matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';


        matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.', 'val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
        matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
        matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

        matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.', 'val', '{}',{1}), substruct('.','spmmat'));
        matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'high_calorie > low_calorie';
        matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = [0 1 -1];
        matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
        matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'high calorie > neutral';
        matlabbatch{3}.spm.stats.con.consess{2}.tcon.weights = [0 1 0 -1];
        matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
        matlabbatch{3}.spm.stats.con.consess{3}.tcon.name = 'low calorie > neutral';
        matlabbatch{3}.spm.stats.con.consess{3}.tcon.weights = [0 0 1 -1];
        matlabbatch{3}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
        matlabbatch{3}.spm.stats.con.consess{4}.tcon.name = 'high_low_food > neutral';
        matlabbatch{3}.spm.stats.con.consess{4}.tcon.weights = [0 0.5 0.5 -1];
        matlabbatch{3}.spm.stats.con.consess{4}.tcon.sessrep = 'none';
        matlabbatch{3}.spm.stats.con.consess{5}.tcon.name = 'low calorie > high calorie';
        matlabbatch{3}.spm.stats.con.consess{5}.tcon.weights = [0 -1 1];
        matlabbatch{3}.spm.stats.con.consess{5}.tcon.sessrep = 'none';
        matlabbatch{3}.spm.stats.con.consess{6}.tcon.name = 'neutral > high calorie';
        matlabbatch{3}.spm.stats.con.consess{6}.tcon.weights = [0 -1 0 1];
        matlabbatch{3}.spm.stats.con.consess{6}.tcon.sessrep = 'none';
        matlabbatch{3}.spm.stats.con.consess{7}.tcon.name = 'neutral > low calorie';
        matlabbatch{3}.spm.stats.con.consess{7}.tcon.weights = [0 0 -1 1];
        matlabbatch{3}.spm.stats.con.consess{7}.tcon.sessrep = 'none';
        matlabbatch{3}.spm.stats.con.consess{8}.tcon.name = 'high_calorie > baseline';
        matlabbatch{3}.spm.stats.con.consess{8}.tcon.weights = [-1 1];
        matlabbatch{3}.spm.stats.con.consess{8}.tcon.sessrep = 'none';
        matlabbatch{3}.spm.stats.con.consess{9}.tcon.name = 'low calorie > baseline';
        matlabbatch{3}.spm.stats.con.consess{9}.tcon.weights = [-1 0 1];
        matlabbatch{3}.spm.stats.con.consess{9}.tcon.sessrep = 'none';
        matlabbatch{3}.spm.stats.con.consess{10}.tcon.name = 'baseline > high calorie';
        matlabbatch{3}.spm.stats.con.consess{10}.tcon.weights = [1 -1];
        matlabbatch{3}.spm.stats.con.consess{10}.tcon.sessrep = 'none';
        matlabbatch{3}.spm.stats.con.consess{11}.tcon.name = 'baseline > low calorie';
        matlabbatch{3}.spm.stats.con.consess{11}.tcon.weights = [1 0 -1];
        matlabbatch{3}.spm.stats.con.consess{11}.tcon.sessrep = 'none';
        matlabbatch{3}.spm.stats.con.consess{12}.tcon.name = 'high_low_food < neutral';
        matlabbatch{3}.spm.stats.con.consess{12}.tcon.weights = [0 -0.5 -0.5 1];
        matlabbatch{3}.spm.stats.con.delete = 0;

        outlist = spm_jobman('run', matlabbatch);
    end
end
