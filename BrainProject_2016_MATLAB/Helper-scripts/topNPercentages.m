function topNPercentages(path, N)

cd(path);
d = dir;
isub = [d(:).isdir];
folderNames = {d(isub).name}';
folderNames(ismember(folderNames,{'.','..'})) = [];

mapObj = containers.Map;
total = 0.0;

for k=1:length(folderNames)
    dirname = ['./', folderNames{k}, '/AUC/'];
    filename = dir([dirname '*.mat']);
    filename = filename.name;
    l = load([dirname filename]);
    
    mat = horzcat(num2cell(l.Meths.MSAUC), l.Meths.Methodnames);
    [mat, index] = sortrows(mat, -1);
    
    for j = 1:N
        name = mat{j, 2};
        
        if isKey(mapObj, name)
            mapObj(name) = mapObj(name) + 1; 
        else
            mapObj(name) = 1;
        end
    end
    
    total = total + 1;
end

Methods = keys(mapObj);
Percentages = values(mapObj);

for k=1:length(Percentages)
    Percentages(k) = {Percentages{k}/double(total)};
end

[result, index] = sortrows(horzcat(Methods', Percentages'), -2);

disp(result);