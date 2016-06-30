%% Generates a random graph with the specified number of nodes and edges
%% Parameters
% nodes: # of nodes
% edges: # of edges
%% Example execution: genstrfile 50 200
function strfile = genstrfile(nodes, edges)

PGS = cell(1);
matrix = zeros(2, edges);
used = diag(ones(1,nodes));
min = 1;
max = nodes;

% Assigns random connections between nodes
for e=1:edges
  disp(e);
  matrix(1,e) = cast(((max-min).*rand + min),'int16');
  val = cast(((max-min).*rand + min),'int16');
  while (used(matrix(1,e),val) == 1)
    val = cast(((max-min).*rand + min),'int16');
  end
  matrix(2,e) = val;
  used(matrix(1,e),val) = 1;
end
PGS{1,1} = matrix;
save(['structureN' int2str(nodes) 'L' int2str(edges) '.mat'], 'PGS');
