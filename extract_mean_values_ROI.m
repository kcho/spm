function extract_mean_values_ROI(xSPM)
ROI = xSPM.XYZ;

spmLoc = sprintf('%s/SPM.mat', xSPM.swd);
SPM = load(spmLoc);
SPM = SPM.SPM;

Obese = {'HMS', 'NSW', 'HJC', 'JHS', 'CSJ', 'CDJ', 'KTH', 'SHJ', 'KDS', 'LJS', 'KHS', 'KYH', 'KYC', 'JJR'};  %KJS removed;
Lean = {'JTS', 'JJY', 'MAS', 'LKB', 'KJW', 'KOS', 'KTO', 'KSO', 'YSS', 'CDK', 'YOI', 'SJS', 'PJO', 'CDH', 'LKH'};

GLP = {'HMS_G','NSW_G','HJC_G','JHS_G','CSJ_G','CDJ_G','KTH_G','SHJ_G','KDS_G','LJS_G','KHS_G','KYH_G','KYC_G','JJR_G','JTS_G','JJY_G','MAS_G','LKB_G','KJW_G','KOS_G','KTO_G','KSO_G','YSS_G','CDK_G','YOI_G','SJS_G','PJO_G','CDH_G','LKH_G'};
saline = {'HMS_S','NSW_S','HJC_S','JHS_S','CSJ_S','CDJ_S','KTH_S','SHJ_S','KDS_S','LJS_S','KHS_S','KYH_S','KYC_S','JJR_S','JTS_S','JJY_S','MAS_S','LKB_S','KJW_S','KOS_S','KTO_S','KSO_S','YSS_S','CDK_S','YOI_S','SJS_S','PJO_S','CDH_S','LKH_S'};

averages = mean(spm_get_data(SPM.xY.P, ROI), 2);

obese_means = [];
lean_means = [];
GLP_means = [];
saline_means = [];

for i=1:length(SPM.xY.P)
    subjectFileLoc = SPM.xY.P{i};
    startIndex = regexp(subjectFileLoc, '\/(lean|obese)_[A-Z]{1}_[A-Z]{3}\/');
    %startIndex = regexp(subjectFileLoc '[A-Z]');

    % if the comparison in the xSPM is group comparisons
    if xSPM.Ic == 3
        subjectName = SPM.xY.P{i}(startIndex+8:startIndex+10);
        if any(strcmp(Obese,subjectName))
            %group='Obese';
            obese_means = [obese_means averages(i)];
        else
            %group='Lean';
            lean_means = [lean_means averages(i)];
        end

    % if the comparison in the xSPM is medications
    elseif xSPM.Ic == 2
        subjectName = SPM.xY.P{i}(startIndex+8:startIndex+10);
        if any(strcmp(GLP,subjectName))
            %group='GLP';
            GLP_means = [GLP_means averages(i)];
        else
            %group='saline';
            saline_means = [saline_means averages(i)];
        end
    end

end


figure
hold on
if xSPM.Ic == 3
    y = [mean(obese_means); mean(lean_means)];
    y_std = [std(obese_means); std(lean_means)];
else
    y = [mean(GLP_means); mean(saline_means)];
    y_std = [std(GLP_means); std(saline_means)];
end
x = [1;2];
h = bar(x,y);
errorbar(y,y_std,'.');

%l = ['Obese';'Lean'];
%legend(h,l);
ax = gca;
ax.XTick = [1,2];
if xSPM.Ic == 3
    ax.XTickLabel = {'Obese','Lean'};
else
    ax.XTickLabel = {'GLP','Saline'};
end
ylabel('Change in beta estimates');

%display(xSPM.roi)
