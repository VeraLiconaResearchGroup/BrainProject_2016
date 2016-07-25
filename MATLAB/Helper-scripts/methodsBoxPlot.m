function methodsBoxPlot(path)

cd(path);
d = dir;
isub = [d(:).isdir];
folderNames = {d(isub).name}';
folderNames(ismember(folderNames,{'.','..'})) = [];

meths = cell.empty(44,0);
aucs = double.empty(44,0);

for k=1:length(folderNames)
    dirname = ['./', folderNames{k}, '/AUC/'];
    filename = dir([dirname '*.mat']);
    filename = filename.name;
    l = load([dirname filename]);
    
    if (isempty(meths))
        meths = l.Meths.Methodnames;
    end
    
    meths = l.Meths.Methodnames;
    aucs = horzcat(aucs, l.Meths.MSAUC);
end

boxplot(aucs', 'labels', meths, 'labelorientation', 'inline');
