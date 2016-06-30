function consensusNetworks(path)

cd(path);
d = dir;
isub = [d(:).isdir];
folderNames = {d(isub).name}';
folderNames(ismember(folderNames,{'.','..'})) = [];

parfor k=1:length(folderNames)
    dirname = ['./', folderNames{k}, '/data/'];
    filename = dir([dirname '*.mat']);
    filename = filename.name;
    prenom = strsplit(filename, {'_', '.'});
    prenom = prenom{1};
    
    addConsensusNetworks(folderNames{k}, prenom);
    mln_MethodStructuresAUC(folderNames{k}, [prenom '_extended']);
end