%% Converts Michael's ICA time series into format for MULAN and runs CalEvaN using a dummy Connectivity matrix
%% Parameters
% filename: filename of Michael's data
% foldername: name of directory for MULAN results to be created
%% Example execution: genData ADHD_Sub001.txt ADHD_Sub001
% Note: genData is called by multisub so generally no need to call genData independently
function genData(filename, foldername)
    fileID=fopen(['datafolder/', filename]);
    header  = textscan(fileID, '%s', 49);
    LFP = textscan(fileID, ['%f', repmat('%f',[1,48])], 204);
    LFP = cell2mat(LFP);
    LFP = LFP';
    Connectivity = ones(49,49);
    Params.fs = 0.500;
    save([foldername, '/data/', foldername,'fmriCS100S1N204.mat'], 'LFP', 'Connectivity', 'Params');
    mln_CalEvaN([foldername],[foldername], 'GenerateData/structureN49L0', 'nmmParams', '49', '1', '204', '1', 'fMRI');
