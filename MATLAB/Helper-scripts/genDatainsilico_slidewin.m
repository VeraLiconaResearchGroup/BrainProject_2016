%% Takes pre-existing in silico time series already in MULAN format and runs CalEvaN using a dummy Connectivity matrix
%% Parameters
% filename: filename of in silico's data
% foldername: name of directory for MULAN results to be created
%% Example execution: genData SF_1fmriCS100S1N204.mat SF_1
% Note: genData is called by multisub so generally no need to call genData independently
function genDatainsilico_slidewin(OGdatafile, foldername, startwin, endwin)
    fileID=load(['datafolderinsilico/', OGdatafile]);
%      header  = textscan(fileID, '%s', 49);
%      LFP = textscan(fileID, ['%f', repmat('%f',[1,48])], 204);
    LFP = fileID.LFP;
    LFP = LFP(:,startwin:endwin);
%     LFP = LFP';
    Connectivity = fileID.Connectivity;
    Params.fs = 0.500;
    save([foldername, '/data/', foldername,'fmriCS100S1N204.mat'], 'LFP', 'Connectivity', 'Params');
    mln_CalEvaN_slidewin([foldername],[foldername], 'GenerateData/structureN49scaleFree1', 'nmmParams', '49', '1', '204', '1', 'fMRI'); %dummy line: not generating new data
%Examples: mln_CalEvaN_slidewin pipeline wk6 GenerateData/structureN5L5 nmmParams 49 1 204 1 fMRI
