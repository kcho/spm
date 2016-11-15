clear;
global defaults
defaults = spm_get_defaults;

subjects = {'CDH','CDJ','CDK','CSJ','HJC','HMS','JHS','JJR','JJY','JTS','KDS','KHS','KJW','KOS','KSO','KTH','KTO','KYC','KYH','LJS','LKB','LKH','MAS','NSW','PJO','SHJ','SJS','YOI','YSS'};
treatment = {'G','S'};
Obese = {'HMS', 'NSW', 'HJC', 'JHS', 'CSJ', 'CDJ', 'KTH', 'SHJ', 'KDS', 'LJS', 'KHS', 'KYH', 'KYC', 'JJR'};  %KJS removed;
Lean = {'JTS', 'JJY', 'MAS', 'LKB', 'KJW', 'KOS', 'KTO', 'KSO', 'YSS', 'CDK', 'YOI', 'SJS', 'PJO', 'CDH', 'LKH'};

preprocDir = '/home/kangik/2016_CHJ/GLP_1/IMG_DATA/dpabi/FunImgARWS';


%% First level analysis
%for i=1:length(subjects)
    %for j=1:length(treatment)
        %preprocData = strcat(preprocDir,'/', subjects(i), '_', treatment(j), '/swra', subjects(i), '_', treatment(j), '.nii')
        %display(preprocData)
        %outputDir = strcat('/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/', subjects(i), '_', treatment(j))

        %matlabbatch{1}.spm.stats.fmri_spec.dir = outputDir;
        %matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
        %matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2;
        %matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 34;
        %matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 17;

        %scanList = {}
        %for num=1:176
            %scanList = [scanList; strcat(preprocData{1}, ',', int2str(num))];
        %end
        %class(scanList)
        %%%
        %matlabbatch{1}.spm.stats.fmri_spec.sess.scans = scanList;
        %%%
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).name = 'baseline';
        %%%
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).onset = [0
                                                                 %26
                                                                 %56
                                                                 %86
                                                                 %116
                                                                 %146
                                                                 %176
                                                                 %202
                                                                 %232
                                                                 %262
                                                                 %292
                                                                 %322];
        %%%
        %%%
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).duration = [5
                                                                    %9
                                                                    %9
                                                                    %9
                                                                    %9
                                                                    %9
                                                                    %5
                                                                    %9
                                                                    %9
                                                                    %9
                                                                    %9
                                                                    %9];
        %%%
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).tmod = 0;
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).orth = 1;
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).name = 'high_calorie';
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).onset = [5
                                                                 %125
                                                                 %211
                                                                 %271];
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).duration = [21
                                                                    %21
                                                                    %21
                                                                    %21];
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).tmod = 0;
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).orth = 1;
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).name = 'low_calorie';
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).onset = [35
                                                                 %95
                                                                 %181
                                                                 %301];
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).duration = [21
                                                                    %21
                                                                    %21
                                                                    %21];
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).tmod = 0;
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).orth = 1;
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).name = 'neutral';
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).onset = [65
                                                                 %155
                                                                 %241
                                                                 %331];
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).duration = [21
                                                                    %21
                                                                    %21
                                                                    %21];
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).tmod = 0;
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
        %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).orth = 1;
        %matlabbatch{1}.spm.stats.fmri_spec.sess.multi = {''};
        %matlabbatch{1}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});

        %motionText = strcat('/home/kangik/2016_CHJ/GLP_1/IMG_DATA/dpabi/RealignParameter/',subjects(i), '_', treatment(j),'/rp_a', subjects(i), '_', treatment(j),'.txt');

        %matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = motionText;
        %matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 128;
        %matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
        %matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
        %matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
        %matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
        %matlabbatch{1}.spm.stats.fmri_spec.mthresh = -Inf;
        %matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
        %matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';


        %matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.', 'val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
        %matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
        %matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

        %matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.', 'val', '{}',{1}), substruct('.','spmmat'));
        %matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'high_calorie > low_calorie';
        %matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = [0 1 -1];
        %matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
        %matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'high calorie > neutral';
        %matlabbatch{3}.spm.stats.con.consess{2}.tcon.weights = [0 1 0 -1];
        %matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
        %matlabbatch{3}.spm.stats.con.consess{3}.tcon.name = 'low calorie > neutral';
        %matlabbatch{3}.spm.stats.con.consess{3}.tcon.weights = [0 0 1 -1];
        %matlabbatch{3}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
        %matlabbatch{3}.spm.stats.con.consess{4}.tcon.name = 'high_low_food > neutral';
        %matlabbatch{3}.spm.stats.con.consess{4}.tcon.weights = [0 0.5 0.5 -1];
        %matlabbatch{3}.spm.stats.con.consess{4}.tcon.sessrep = 'none';
        %matlabbatch{3}.spm.stats.con.consess{5}.tcon.name = 'low calorie > high calorie';
        %matlabbatch{3}.spm.stats.con.consess{5}.tcon.weights = [0 -1 1];
        %matlabbatch{3}.spm.stats.con.consess{5}.tcon.sessrep = 'none';
        %matlabbatch{3}.spm.stats.con.consess{6}.tcon.name = 'neutral > high calorie';
        %matlabbatch{3}.spm.stats.con.consess{6}.tcon.weights = [0 -1 0 1];
        %matlabbatch{3}.spm.stats.con.consess{6}.tcon.sessrep = 'none';
        %matlabbatch{3}.spm.stats.con.consess{7}.tcon.name = 'neutral > low calorie';
        %matlabbatch{3}.spm.stats.con.consess{7}.tcon.weights = [0 0 -1 1];
        %matlabbatch{3}.spm.stats.con.consess{7}.tcon.sessrep = 'none';
        %matlabbatch{3}.spm.stats.con.consess{8}.tcon.name = 'high_calorie > baseline';
        %matlabbatch{3}.spm.stats.con.consess{8}.tcon.weights = [-1 1];
        %matlabbatch{3}.spm.stats.con.consess{8}.tcon.sessrep = 'none';
        %matlabbatch{3}.spm.stats.con.consess{9}.tcon.name = 'low calorie > baseline';
        %matlabbatch{3}.spm.stats.con.consess{9}.tcon.weights = [-1 0 1];
        %matlabbatch{3}.spm.stats.con.consess{9}.tcon.sessrep = 'none';
        %matlabbatch{3}.spm.stats.con.consess{10}.tcon.name = 'baseline > high calorie';
        %matlabbatch{3}.spm.stats.con.consess{10}.tcon.weights = [1 -1];
        %matlabbatch{3}.spm.stats.con.consess{10}.tcon.sessrep = 'none';
        %matlabbatch{3}.spm.stats.con.consess{11}.tcon.name = 'baseline > low calorie';
        %matlabbatch{3}.spm.stats.con.consess{11}.tcon.weights = [1 0 -1];
        %matlabbatch{3}.spm.stats.con.consess{11}.tcon.sessrep = 'none';
        %matlabbatch{3}.spm.stats.con.delete = 0;

        %outlist = spm_jobman('run', matlabbatch);
    %end
%end




%clear matlabbatch
%% Second level analysis
%contList={'01' '02' '03' '04' '05' '06' '07' '08' '09' '10' '11'};
%for contNum=1:length(contList) %contrast number
    %outDir_second = strcat('/home/kangik/2016_CHJ/GLP_1/IMG_DATA/secondLevel/',contList(contNum))
    %matlabbatch{1}.spm.stats.factorial_design.dir = outDir_second;
    %matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).name = 'subject';
    %matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).dept = 0;
    %matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).variance = 0;
    %matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).gmsca = 0;
    %matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).ancova = 0;
    %matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).name = 'Group';
    %matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).dept = 0;
    %matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).variance = 1;
    %matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).gmsca = 0;
    %matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).ancova = 0;
    %matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).name = 'Condition';
    %matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).dept = 1;
    %matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).variance = 0;
    %matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).gmsca = 0;
    %matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).ancova = 0;

    %for i=1:length(subjects)
        %imgList = {}
        %for j=1:length(treatment)
            %firstLevel_cont_img = strcat('/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel/',subjects(i), '_', treatment(j),'/con_00',contList(contNum),'.nii,1');
            %imgList = [imgList; firstLevel_cont_img];
        %end
        %matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(i).scans = imgList;

        %if ismember(subjects(i), Obese)
            %condMat = [1 2;1 1];
        %else
            %condMat = [2 2;2 1];
        %end
        %matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(i).conds = condMat
    %end

    %matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{1}.fmain.fnum = 1;
    %matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{2}.fmain.fnum = 2;
    %matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{3}.fmain.fnum = 3;
    %matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{4}.inter.fnums = [2
                                                                                      %3];
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
    %matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'Group_effect';
    %matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = [1 -1 0 0 0.5 0.5 -0.5 -0.5 -0.0666666666666667 0.0714285714285714 -0.0666666666666667 0.0714285714285714 0.0714285714285714 0.0714285714285714 0.0714285714285714 0.0714285714285714 -0.0666666666666667 -0.0666666666666667 0.0714285714285714 0.0714285714285714 -0.0666666666666667 -0.0666666666666667 -0.0666666666666667 0.0714285714285714 -0.0666666666666667 0.0714285714285714 0.0714285714285714 0.0714285714285714 -0.0666666666666667 -0.0666666666666667 -0.0666666666666667 0.0714285714285714 -0.0666666666666667 0.0714285714285714 -0.0666666666666667 -0.0666666666666667 -0.0666666666666667];
    %matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
    %matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'Medication_effect';
    %matlabbatch{3}.spm.stats.con.consess{2}.tcon.weights = [0 0 1 -1 0.482758620689655 -0.482758620689655 0.517241379310345 -0.517241379310345 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    %matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
    %matlabbatch{3}.spm.stats.con.consess{3}.fcon.name = 'Interaction';
    %matlabbatch{3}.spm.stats.con.consess{3}.fcon.weights = [0 0 0 0 1 -1 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    %matlabbatch{3}.spm.stats.con.consess{3}.fcon.sessrep = 'none';
    %matlabbatch{3}.spm.stats.con.delete = 0;

    %savefile = strcat('second_level_matlabbatch_cont_',contList(contNum))
    %save(savefile{1},'matlabbatch')
    %outlist = spm_jobman('run', matlabbatch);
%end


secondLevelDir = '/home/kangik/2016_CHJ/GLP_1/IMG_DATA/secondLevel';

contList={'01' '02' '03' '04' '05' '06' '07' '08' '09' '10' '11'};
contNameList = {'high_calorie > low_calorie' 'high calorie > neutral' 'low calorie > neutral' 'high_low_food > neutral' 'low calorie > high calorie' 'neutral > high calorie' 'neutral > low calorie' 'high_calorie > baseline' 'low calorie > baseline' 'baseline > high calorie' 'baseline > low calorie'};

comparisonName = {'GE_', 'ME_', 'Int_'};
for contNum=1:1%length(contList) %contrast number
    for comparisonNum=1:length(comparisonName)
        clear SPM
        %spmMat = strcat('/home/kangik/2016_CHJ/GLP_1/IMG_DATA/secondLevel/',contList(contNum),'/SPM.mat')
        matFileName = sprintf('/home/kangik/2016_CHJ/GLP_1/IMG_DATA/secondLevel/%s/SPM.mat', strjoin(contList(contNum)));
        load(matFileName)
        load '/home/kangik/2016_CHJ/GLP_1/IMG_DATA/secondLevel/hReg.mat'
        %spm_list('List', xSPM, hReg)
        %spm_list('List',SPM,hReg)
        % xSPM      - structure containing SPM, distribution & filtering details
        xSPM = SPM;
        xSPM.swd      = sprintf('/home/kangik/2016_CHJ/GLP_1/IMG_DATA/secondLevel/%s', strjoin(contList(contNum)));
        xSPM.title    = strcat(comparisonName(comparisonNum), contNameList(contNum));
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
            xSPM.u        = 0.05;
        end
        
        xSPM.k        = 0;
        xSPM.thresDesc = 'FWE';
        xSPM.roi      = '/home/kangik/2016_CHJ/GLP_1/IMG_DATA/ROIs/hypothalamus_10mm_0-10-7.nii';
        xSPM.units = {'mm'  'mm'  'mm'};

        [SPM,xSPM] = spm_getSPM(xSPM);
        [hreg,xSPM,SPM] = spm_results_ui('Setup',xSPM);
        %TabDat = spm_list('List',xSPM,hReg);
    end
end
