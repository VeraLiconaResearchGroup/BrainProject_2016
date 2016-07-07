function PGS = generateScaleFree(nodes, iter)
mat = BAgraph_dir(nodes, 2, 1);

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
save(['GenerateData/structureN' int2str(nodes) 'scaleFree' int2str(iter) '.mat'], 'PGS');