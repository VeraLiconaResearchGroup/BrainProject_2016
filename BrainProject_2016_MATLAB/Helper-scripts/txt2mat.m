%%Converts a DREAM5 method results text file into a mat format for MULAN to evaluate
%% Parameters
% filename: name of a GENIE or TIGRESS result file, a list of edges in the format: [head node] [tail node] [edge weight]
%% Example execution: txt2mat results

function txt2mat(filename)
fileID = fopen([filename, '.txt']);
orig = textscan(fileID, '%s %s %f');
fclose(fileID);
nodes1 = cell2mat(orig(1));
nodes2 = cell2mat(orig(2));
connections = cell2mat(orig(3));

% Convert each node label to its index
B = char(nodes1);
C = B';
D = C(2:end,:);
nodes1 = str2num(D');
clear B C D

B = char(nodes2);
C = B';
D = C(2:end,:);
nodes2 = str2num(D');
clear B C D

% May be unecessary, so just in case
max1 = max(nodes1);
max2 = max(nodes2);
if max1 > max2
  results = zeros(max1,max1);
else
  results = zeros(max2,max2);
end

% save connections to matrix and export
N = size(nodes1);
for n=1:N
  results(nodes1(n,1),nodes2(n,1)) = connections(n,1);
end
save([filename,'.mat'], 'results', '-double');
