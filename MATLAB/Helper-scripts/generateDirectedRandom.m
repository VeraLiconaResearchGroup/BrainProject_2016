function PGS = generateDirectedRandom(nodes, p, iter)
mat = random_directed_graph(nodes,p);

PGS = cell(1);
matrix = zeros(2, sum(sum(mat)));
counter = 1;
for i=1:nodes
    for j=1:nodes
        if mat(i,j)==1
            matrix(2,counter)=i;
            matrix(1,counter)=j;
            counter = counter + 1;
        end
    end
end
PGS{1,1} = matrix;
save(['GenerateData/structureN' int2str(nodes) 'directedRandom' int2str(iter) '.mat'], 'PGS');
