%% Runs MULAN with the user specified number of NetSim subject time series
%% Parameters
% simname: name of NetSim data
% first: # of first subject
% last: # of last subject
%% Example execution: multisub_sims sim4 1 50
% Note: multisub_sims will iterate through every consecutive subject number from the start value to the finish value

function multisub_sims(simname, start, finish)
sims = load([simname '.mat']);

%Convert first time series and create structure file
edges = int32(nnz(squeeze(sims.net(1,:,:))) - sims.Nnodes);
strname = ['GenerateData/structureN' int2str(sims.Nnodes) 'L' int2str(edges) '.mat']
if ~exist([strname], 'file')
    PGS = cell(1);
    matrix = [];
    counter = 1;
    Connectivity = squeeze(sims.net(1,:,:));
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
    save(strname, 'PGS');
end

%Convert the remaining time series
extraZero = '00';
for i=str2num(start):str2num(finish)
    if i < 100 & i > 9
        extraZero = '0';
    elseif i >= 100
        extraZero = '';
    end
    foldername = [simname, 'Sub', extraZero, num2str(i)];
    mkdir(foldername);
    dir = foldername;
    mkdir(dir, 'AUC');
    mkdir(dir, 'data');
    mkdir(dir, 'Results');
    mkdir(dir, 'ToutResults');
    
    LFP = sims.ts(((i-1)*sims.Ntimepoints)+1:(i*sims.Ntimepoints),:)';
    Connectivity = squeeze(sims.net(i,:,:));
    Params.fs = 0.500;
    save([foldername, '/data/', foldername, 'fmriCS100S1N', num2str(sims.Ntimepoints), '.mat'], 'LFP', 'Connectivity', 'Params');
end

parfor i=str2num(start):str2num(finish)
    extraZero = '00';
    if i < 100 & i > 9
        extraZero = '0';
    elseif i >= 100
        extraZero = '';
    end

    fname = [simname, 'Sub', extraZero, num2str(i)];
    mln_CalEvaN(fname, fname, ['GenerateData/structureN' int2str(sims.Nnodes) 'L' int2str(edges) '.mat'], 'nmmParams', num2str(sims.Nnodes), '1', num2str(sims.Ntimepoints), '1', 'fMRI');
end
