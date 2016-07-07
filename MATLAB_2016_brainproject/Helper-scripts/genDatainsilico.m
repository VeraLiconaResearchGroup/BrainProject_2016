%% Takes pre-existing in silico time series already in MULAN format and runs CalEvaN using a dummy Connectivity matrix
%% Parameters
% filename: filename of in silico's data
% foldername: name of directory for MULAN results to be created
%% Example execution: genData SF_1fmriCS100S1N204.mat SF_1
% Note: genData is called by multisub so generally no need to call genData independently
function genData(filename, foldername)
    fileID=fopen(['datafolderinsilico/', filename]);
%     header  = textscan(fileID, '%s', 49);
%     LFP = textscan(fileID, ['%f', repmat('%f',[1,48])], 204);
    LFP = cell2mat(LFP);
%     LFP = LFP';
    Connectivity = ones(49,49);
    Params.fs = 0.500;
    save([foldername, '/data/', foldername,'fmriCS100S1N204.mat'], 'LFP', 'Connectivity', 'Params');
    mln_CalEvaN([foldername],[foldername], 'GenerateData/structureN49L0', 'nmmParams', '49', '1', '204', '1', 'fMRI');
%Examples: mln_CalEvaN pipeline wk6 GenerateData/structureN5L5 nmmParams 49 1 204 1 fMRI
