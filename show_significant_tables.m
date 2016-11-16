function [hReg, xSPM, SPM] = show_significant_tables(xSPMLoc)

xSPM = load(xSPMLoc);
xSPM = xSPM.xSPM;

[hReg,xSPM,SPM] = spm_results_ui('Setup',xSPM);
TabDat = spm_list('List',xSPM,hReg);
extract_mean_values_ROI(xSPM)


cd /home/kangik/2016_CHJ/GLP_1/IMG_DATA
