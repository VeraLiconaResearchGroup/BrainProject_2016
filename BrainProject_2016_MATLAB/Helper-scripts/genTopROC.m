%% Takes AUC results from MULAN and number of best AUC results to plot the top ROC curves
function genTopROC(filename, number)
  load(filename);
  AUC = Meths.MSAUC;
  row = zeros(size(AUC):1);
  for i=1:size(AUC)
    row(i,1) = i;
  end
  AUC = horzcat(AUC, row);
  AUC = sortrows(AUC, 1);
  AUC = AUC(size(AUC)-number+1:size(AUC),1:2);
  FPR = Meths.Fpr';
  TPR = Meths.Tpr';
  x = FPR(:,AUC(1,2));
  y = TPR(:,AUC(1,2));
  count = 1;
  names = cell(number, 1);
  name = sprintf('%s %s', Meths.Methodnames{1}, num2str(AUC(1, 1)));
  names(count,:) = {name};
  
  for i=2:number
    x = horzcat(x, FPR(:,AUC(i,2)));
    y = horzcat(y, TPR(:,AUC(i,2)));
    count = count + 1;
    name = sprintf('%s %s', Meths.Methodnames{AUC(i,2)}, num2str(AUC(i,1)));
    names(count,:) = {name};
  end
  
  figure();
  set(gcf,'Visible', 'off');
  plot(x,y);
  legend(names, 'Fontsize', 7, 'location','eastoutside');
  
  hold on;
  m = 1; b = 0; x = 0:1;
  plot(x, m*x+b, '--k');
  hold off;
  
  saveas(gcf, [filename(1,1:size(filename,2)-4) '_top' int2str(number) 'ROC.pdf']);
