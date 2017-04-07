function extract_mean_values_ROI(xSPM)
ROILoc = '/home/kangik/2016_CHJ/GLP_1/IMG_DATA/ROIs/hypothalamus_10mm_0-10-7.nii';

%Y = spm_read_vols(spm_vol(ROILoc), 1);
%indx = find(Y>0);
%[x,y,z] = ind2sub(size(Y), indx);
%XYZ = [x y z]';

%ROI = XYZ;

XYZ = [30    42    18     
30    43    18     
29    41    19     
30    41    19     
29    42    19     
30    42    19     
28    40    20     
28    41    20     
29    41    20     
29    42    20     
30    42    20     
28    41    21     
29    41    21];

ROI = XYZ';

% get overlapping XYZ

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


obese_means_G = [];
obese_means_S = [];
lean_means_G = [];
lean_means_S = [];

for i=1:length(SPM.xY.P)
    subjectFileLoc = SPM.xY.P{i};
    basename = regexp(subjectFileLoc, '(lean|obese)_[A-Z]{1}_([A-Z]{3})', 'match');
    basename = basename{1};
    medication = basename(end-4);
    subjectName = basename(end-2:end);
    if any(strcmp(Obese,subjectName))
        if medication == 'G'
            obese_means_G = [obese_means_G averages(i)];
        elseif medication == 'S'
            obese_means_S = [obese_means_S averages(i)];
        end
    else
        if medication == 'G'
            lean_means_G = [lean_means_G averages(i)];
        elseif medication == 'S'
            lean_means_S = [lean_means_S averages(i)];
        end
    end
end


figure
hold on
%obesePoints = [mean(obese_means_S); mean(obese_means_G)];
%leanPoints = [mean(lean_means_S); mean(lean_means_G)];

obesePoints = [obese_means_S; obese_means_G]
leanPoints = [lean_means_S; lean_means_G]
x = [1;2];
ax=gca;
ax.XTick = [1,2];

ylabel('Change in beta estimates');
p1 = plot(x, obesePoints, 'r');
p2 = plot(x, leanPoints, 'b');

ax.XTickLabel = {'Saline','GLP'};
legend([p1(1),p2(1)], 'Obese', 'Lean')
