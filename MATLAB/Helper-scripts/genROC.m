%% Generate ROC curves for all methods
%% Parameters
% Meths: Meths struct from the AUC file saved in the AUC folder after each run
%% Example execution: genROC Meths
% Note: AUC file will typically be in the format: AUC_[folder name]fmriCS100S1N[length of time series].mat
% Meths is extracted by loading that AUC file and then typing in the command line: genROC Meths
function genROC(Meths)
  x = Meths.Fpr;
  y = Meths.Tpr;
  x = x';
  y = y';
  figure;
  plot(x,y);
  legend(Meths.Methodnames, 'Location', 'southoutside');
  saveas(gcf, 'AUCplot.pdf');
