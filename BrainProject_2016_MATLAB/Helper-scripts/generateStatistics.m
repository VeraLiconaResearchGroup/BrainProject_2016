function generateStatistics(path)

cd(path);
d = dir;
isub = [d(:).isdir];
folderNames = {d(isub).name}';
folderNames(ismember(folderNames,{'.','..'})) = [];
display(length(folderNames))

parfor k=1:length(folderNames)
    dirname = ['./', folderNames{k}, '/AUC/'];
    display(dirname)
    filename = dir([dirname '*.mat']);
    display(filename)
    filename = filename.name;
    
    prenom = strsplit(filename, {'_', '.'});
    mln_MethodStructuresAUC(folderNames{k},prenom{2});
end