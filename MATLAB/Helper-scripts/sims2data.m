%% Converts the NetSim data into a MULAN time series dataset
%% Parameters
% simname: name of a NetSim file
%% Example execution: sims2data sim4

function sims2data(simname)
sims = load([simname '.mat']);
LFP = sims.ts(1:sims.Ntimepoints,:)';
Connectivity = squeeze(sims.net(1,:,:));
Params.fs = 0.500;
save([simname,'_1fmriCS100S1N', num2str(sims.Ntimepoints), '.mat'], 'LFP', 'Connectivity', 'Params');

%Convert first time series and create structure file
PGS = cell(1);
matrix = [];
edges = int32(nnz(Connectivity) - sims.Nnodes);
counter = 1;
for i=1:sims.Nnodes;
    for j=1:sims.Nnodes;
        if Connectivity(i,j)>0
            matrix(2,counter)=i;
            matrix(1,counter)=j;
            counter = counter + 1;
        end
    end
end
PGS{1,1} = matrix;
save(['structureN' int2str(sims.Nnodes) 'L' int2str(edges) '.mat'], 'PGS');

%Convert the remaining time series
for n=2:sims.Nsubjects
   LFP = sims.ts(((n-1)*sims.Ntimepoints)+1:(n*sims.Ntimepoints),:)';
   Connectivity = squeeze(sims.net(n,:,:));
   Params.fs = 0.500;
   save([simname,'_', num2str(n), 'fmriCS100S1N', num2str(sims.Ntimepoints), '.mat'], 'LFP', 'Connectivity', 'Params');
end
