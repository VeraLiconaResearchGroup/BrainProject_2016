%% For converting an edgelist exported from an R igraph into a structure file
%% Parameters
% edgelist: filename of an edgelist, with the head nodes in the first column and corresponding tail nodes in the second
% nodes: number of nodes
% edges: number of edges
%% Example execution: edgelist2str edgelist 50 80
function edgelist2str(edgelist, nodes, edges)

fileID = fopen(edgelist);
orig = textscan(fileID, '%d %d');
fclose(fileID);
nodes1 = cell2mat(orig(1));
nodes2 = cell2mat(orig(2));
PGS = cell(1);
matrix = zeros(2,edges);
for n=1:edges
    matrix(2,n) = int32(nodes1(n,1)+1);
    matrix(1,n) = int32(nodes2(n,1)+1);
end
PGS{1,1} = matrix;
save(['structureN' int2str(nodes) 'L' int2str(edges) '.mat'], 'PGS');
