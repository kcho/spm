function extract_mean_values_ROI(SPM, ROI)


Obese = {'HMS', 'NSW', 'HJC', 'JHS', 'CSJ', 'CDJ', 'KTH', 'SHJ', 'KDS', 'LJS', 'KHS', 'KYH', 'KYC', 'JJR'};  %KJS removed;
Lean = {'JTS', 'JJY', 'MAS', 'LKB', 'KJW', 'KOS', 'KTO', 'KSO', 'YSS', 'CDK', 'YOI', 'SJS', 'PJO', 'CDH', 'LKH'};


averages = mean(spm_get_data(SPM.xY.P, ROI), 2)

obese_means = []
lean_means = []

for i=1:length(SPM.xY.P)
    subjectFileLoc = SPM.xY.P{i};
    startIndex = regexp(subjectFileLoc, '\/[A-Z]{3}_[A-Z]{1}\/');
    subjectName = SPM.xY.P{i}(startIndex+1:startIndex+3);
    if any(strcmp(Obese,subjectName))
        group='Obese';
        obese_means = [obese_means averages(i)];
    else
        group='Lean';
        lean_means = [lean_means averages(i)];
    end
end

%mean_velocity = [0.2574, 0.1225, 0.1787]; % mean velocity
%std_velocity = [0.3314, 0.2278, 0.2836];  % standard deviation of velocity

%figure
%hold on
%bar(1:3,mean_velocity)
%errorbar(1:3,mean_velocity,std_velocity,'.')

figure
hold on
y = [mean(obese_means); mean(lean_means)];
x = [1;2];
y_std = [std(obese_means); std(lean_means)]
h = bar(x,y);
errorbar(y,y_std,'.');

%l = ['Obese';'Lean'];
%legend(h,l);
ax = gca;
ax.XTick = [1,2];
ax.XTickLabel = {'Obese','Lean'};
ylabel('Percent Signal Change, %')
