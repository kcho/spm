roiDir = '/home/kangik/2016_CHJ/GLP_1/IMG_DATA/ROIs';
file_list = dir(roiDir);
contrastNum = {'01','02','03','04','05','06'};

for j = 1:length(contrastNum)
    contrastNumStr = contrastNum(j);
    contrastNumStr = contrastNumStr{1};

    for i =1:length(file_list)
        if any(regexp(file_list(i).name, 'nii$'))
            file_list(i).name;
            4_extract_mean_values_ROI_new(file_list(i).name, contrastNumStr)
        end
    end
end


