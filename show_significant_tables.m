function [hReg, xSPM, SPM] = show_significant_tables(xSPMLoc)

xSPM = load(xSPMLoc);
xSPM = xSPM.xSPM;

[hReg,xSPM,SPM] = spm_results_ui('Setup',xSPM);
TabDat = spm_list('List',xSPM,hReg);
