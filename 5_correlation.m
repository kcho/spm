function correlation(ROILoc, contrastNum)

% Correlation between the 
% - contrast beta estimates
% - variables
%
% Variables include
% - K-BDI
% - TAS-20K
% - PANAS
% - DEBQ
% - Yale
% - VAS

% Contrast
% 1

% If you have the statistics toolbox
%a = [1 4 6 3 4 6 7 8]; 
%b = [34 56 34 56 79 23 48 28];
%[RHO,PVAL] = corr(a',b','Type','Spearman');


Y = spm_read_vols(spm_vol(ROILoc), 1);
indx = find(Y>0);
[x,y,z] = ind2sub(size(Y), indx);
XYZ = [x y z]';
ROI = XYZ;

obese_means_G = [];
obese_means_S = [];
lean_means_G = [];
lean_means_S = [];

FL_Loc = '/home/kangik/2016_CHJ/GLP_1/IMG_DATA/firstLevel';
FL_dirs = dir(FL_Loc);

con_list = [];
for i=1:length(FL_dirs)
    % remove non-folders
    if FL_dirs(i).isdir && ~strcmpi(FL_dirs(i).name, '.') && ~strcmpi(FL_dirs(i).name, '..')
        nameparts = strsplit(FL_dirs(i).name,'_');

        group = nameparts{1};
        medication = nameparts{2};
        initial = nameparts{3};

        conLoc = sprintf('%s/%s/con_00%s.nii ', FL_Loc, FL_dirs(i).name, contrastNum);

        % append the contrast map to the contrast file list
        if strcmp(group, 'obese') && strcmp(medication, 'G')
            obese_means_G = [obese_means_G conLoc];
        elseif strcmp(group, 'obese') && strcmp(medication,'S')
            obese_means_S = [obese_means_S conLoc];
        elseif strcmp(group, 'lean') && strcmp(medication, 'G')
            lean_means_G = [lean_means_G conLoc];
        else
            lean_means_S = [lean_means_S conLoc];
        end

    end
end

obese_means_G = strsplit(obese_means_G, ' ');
obese_means_S = strsplit(obese_means_S, ' ');
lean_means_G =  strsplit(lean_means_G , ' ');
lean_means_S =  strsplit(lean_means_S , ' ');



%structure
obese_means_G_avg = mean(spm_get_data(obese_means_G, ROI), 2);
obese_means_S_avg = mean(spm_get_data(obese_means_S, ROI), 2);
lean_means_G_avg = mean(spm_get_data(lean_means_G, ROI), 2);
lean_means_S_avg = mean(spm_get_data(lean_means_S, ROI), 2);

obesePoints = [obese_means_S_avg'; obese_means_G_avg'];
leanPoints = [lean_means_S_avg'; lean_means_G_avg'];

obesePoints_avg = [mean(obese_means_S_avg); mean(obese_means_G_avg)];
leanPoints_avg = [mean(lean_means_S_avg); mean(lean_means_G_avg)];

FigHandle = figure('Position', [100, 100, 1049, 895]);
hold on

% graph settings
ax = gca;

set(gcf,'color','w'); % white background
set(gca,'FontSize',15);

set(ax,'ylim',[-1,1])
ylabel('Change in beta estimates');

set(ax,'xlim',[0.5,2.5])
ax.XTickLabel = {'Saline','GLP'};

% set x-axis
ax.XTick = [1,2];

x = [1;2];

% each lines
p3 = plot(x, obesePoints, 'r');
p4 = plot(x, leanPoints, 'b');
p3 = plot(x, obesePoints, 'ro');
p4 = plot(x, leanPoints, 'bo');

% average line
p1 = plot(x, obesePoints_avg, 'r', 'Linewidth',5);
p2 = plot(x, leanPoints_avg, 'b', 'Linewidth',5);

legend([p1(1),p2(1)], 'Obese', 'Lean')

% make contrast name from contrastNum
if strcmp(contrastNum, '01')
    contrastStr = 'high calorie > low calorie';
elseif strcmp(contrastNum, '02')
    contrastStr = 'high calorie < low calorie';
elseif strcmp(contrastNum, '03')
    contrastStr = 'high calorie > neutral';
elseif strcmp(contrastNum, '04')
    contrastStr = 'high calorie < neutral';
elseif strcmp(contrastNum, '05')
    contrastStr = 'high_low_food > neutral';
elseif strcmp(contrastNum, '06')
    contrastStr = 'high_low_food < neutral';
end

% grep basename of the ROILoc
[pathstr,roiname,ext] = fileparts(ROILoc);

% allow "_"s in the plot title
set(0,'DefaulttextInterpreter','none')
title(sprintf('%s : %s', contrastStr, roiname), 'FontSize', 20)

%write table
outTable = table([obese_means_G_avg;nan], [obese_means_S_avg;nan], lean_means_G_avg, lean_means_S_avg, 'VariableNames', {'ObeseG', 'ObeseS', 'LeanG', 'LeanS'})
writetable(outTable, sprintf('%s_%s.txt',contrastNum, roiname))

print(sprintf('%s_%s',contrastNum, roiname),'-dpng')
close(FigHandle)
