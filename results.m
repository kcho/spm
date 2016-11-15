function results()
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
