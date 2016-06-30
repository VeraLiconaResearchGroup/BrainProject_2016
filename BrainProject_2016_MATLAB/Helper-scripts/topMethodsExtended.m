function topMethodsExtended(path)

cd(path);
d = dir;
isub = [d(:).isdir];
folderNames = {d(isub).name}';
folderNames(ismember(folderNames,{'.','..'})) = [];

meths = cell.empty(48,0);
aucs = double.empty(48,0);
ppv = double.empty(48,0);
acc = double.empty(48,0);

%Average
for k=1:length(folderNames)
    dirname = ['./', folderNames{k}, '/AUC/'];
    filename = dir([dirname '*.mat']);
    [x, y] = filename.name;
        
    l = load([dirname y]);
    
    meths = l.Meths.Methodnames;
    aucs = horzcat(aucs, l.Meths.MSAUC);
    ppv = horzcat(ppv, max(l.Meths.PPV,[], 2));
    acc = horzcat(acc, max(l.Meths.ACC,[], 2));
    
end

disp({'Method name' 'AUC Mean' 'AUC Std'});
means = mean(aucs,2);
stds = std(aucs, 0, 2);
[result, index] = sortrows(horzcat(meths, num2cell(means), num2cell(stds)), -2);
disp(result)

disp({'Method name' 'PPV Mean' 'PPV Std'});
means = mean(ppv,2);
stds = std(ppv, 0, 2);
[result, index] = sortrows(horzcat(meths, num2cell(means), num2cell(stds)), -2);
disp(result)

disp({'Method name' 'ACC Mean' 'ACC Std'});
means = mean(acc,2);
stds = std(acc, 0, 2);
[result, index] = sortrows(horzcat(meths, num2cell(means), num2cell(stds)), -2);
disp(result)


meths = cell.empty(48,0);
aucs = int64.empty(48,0);
ppv = int64.empty(48,0);
acc = int64.empty(48,0);

%Rank
for k=1:length(folderNames)
    dirname = ['./', folderNames{k}, '/AUC/'];
    filename = dir([dirname '*.mat']);
    [x, y] = filename.name;
     
    l = load([dirname y]);
    
    meths = l.Meths.Methodnames;
    aucRank = tiedrank(l.Meths.MSAUC);
    ppvRank = tiedrank(max(l.Meths.PPV,[], 2));
    accRank = tiedrank(max(l.Meths.ACC,[], 2));
    
    aucs = horzcat(aucs, aucRank);
    ppv = horzcat(ppv, ppvRank);
    acc = horzcat(acc, accRank);    
end

disp({'Method name' 'Rank Score (AUC)'});
sums = sum(aucs,2);
[result, index] = sortrows(horzcat(meths, num2cell(sums)), -2);
disp(result)

disp({'Method name' 'Rank Score (PPV)'});
sums = sum(ppv,2);
[result, index] = sortrows(horzcat(meths, num2cell(sums)), -2);
disp(result)

disp({'Method name' 'Rank Score (ACC)'});
sums = sum(acc,2);
[result, index] = sortrows(horzcat(meths, num2cell(sums)), -2);
disp(result)