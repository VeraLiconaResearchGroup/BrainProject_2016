%% Converts an adjacency matrix into an edgelist and saves as a MULAN structure file
%% Parameters
% adj: name of n x n adjacency matrix
% nodes: number of nodes
% edges: number of edges
%% Example execution: adj2str adjmatrix 50 80
function adj2str(adj, nodes, edges)

PGS = cell(1);
matrix = zeros(2,edges);
counter = 1;
for i=1:nodes
    for j=1:nodes
        if adj(i,j)~=0 & i~=j
            matrix(2,counter)=i;
            matrix(1,counter)=j;
            counter = counter + 1;
        end
    end
end
PGS{1,1} = matrix;
save(['structureN' int2str(nodes) 'L' int2str(edges) '.mat'], 'PGS');
