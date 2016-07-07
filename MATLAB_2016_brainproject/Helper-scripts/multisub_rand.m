%% Runs MULAN with random networks, starting with edge lists of random networks
%% Parameters
% first: # of first subject
% last: # of last subject
%% Example execution: multisub_rand rand 1 100
% Note: multisub_rand will iterate through every consecutive subject number from the start value to the finish value
% Edge list of random networks must be stored in a directory called randnetedges in the MULAN directory, with the
% format: [head node] [tail node]

function multisub_rand(start, finish)
  extraZero = '00';
  
  % Iterate through random network edge lists
  for i=str2num(start):str2num(finish)
    if i < 100 && i > 9
        extraZero = '0';
    elseif i >= 100
        extraZero = '';
    end
    
    % Extract edge lists
    fileID = fopen(['randnetedges/rand_' extraZero int2str(i) '.txt']);
    orig = textscan(fileID, '%d %d');
    fclose(fileID);
    fileID = fopen('randnetedges/attributes.txt');
    att = textscan(fileID, '%d %d');
    fclose(fileID);
    nodes = cell2mat(att(1));
    edges = cell2mat(att(2));
    nodes1 = cell2mat(orig(1));
    nodes2 = cell2mat(orig(2));
    PGS = cell(1);
    matrix = zeros(2,edges);
    
    % Generate MULAN structure file from random network edge list
    for n=1:edges(i,1)
        matrix(2,n) = int32(nodes1(n,1)+1);
        matrix(1,n) = int32(nodes2(n,1)+1);
    end
    PGS{1,1} = matrix;
    save(['GenerateData/structure_rand' int2str(i) 'N' int2str(nodes(i,1)) 'L' int2str(edges(i,1)) '.mat'], 'PGS');
  end
  
  % Run MULAN with random network structure file
  parfor i=str2num(start):str2num(finish)
     extraZero = '00';
     if i < 100 && i > 9
        extraZero = '0';
    elseif i >= 100
        extraZero = '';
    end
    foldername = ['rand_Sub', extraZero, num2str(i)];
    mln_CalEvaN(foldername, foldername, ['GenerateData/structure_rand' int2str(i) 'N' int2str(nodes(i,1)) 'L' int2str(edges(i,1))], 'nmmParams', [int2str(nodes(i,1))], '1', '204', '1', 'fMRI');
  end
