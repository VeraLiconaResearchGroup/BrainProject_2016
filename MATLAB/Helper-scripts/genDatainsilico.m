%% Takes pre-existing in silico time series already in MULAN format and runs CalEvaN using a dummy Connectivity matrix
%% Parameters
% filename: filename of in silico's data
% foldername: name of directory for MULAN results to be created
%% Example execution: genData SF_1fmriCS100S1N204.mat SF_1
% Note: genData is called by multisub so generally no need to call genData independently
function genDatainsilico(filename, foldername)
    fileID=load(['datafolderinsilico/', filename]);
%      header  = textscan(fileID, '%s', 49);
%      LFP = textscan(fileID, ['%f', repmat('%f',[1,48])], 204);
    LFP = fileID.LFP;
%     LFP = LFP';
    Connectivity = fileID.Connectivity;
    Params.fs = 0.500;
    save([foldername, '/data/', filename], 'LFP', 'Connectivity', 'Params'); %do not change: fmri... is necessary so mln_CalEvaN doesn't generate new data
    
% This is Tiffany trying to avoid calling mln_CalEvaN of any sort    
    VGroupMethlog={'TimeBasic','FreqBasic','Hsquare','FreqAH','MutualInform','TE', 'Genie', 'Tigress'};
    strfile1=which(['nmmParams','.mat']);
    copyfile (strfile1, ['./',foldername]);

    MULANCalMUltiBP(foldername,foldername,'nmmParams',VGroupMethlog);
    mln_MethodStructuresAUC(foldername,foldername);
    
   % mln_CalEvaN_priordata([foldername],[foldername], 'GenerateData/structureN49scaleFree1', 'nmmParams', '49', '1', '204', '1', 'fMRI'); %dummy line since not generating new data
%Examples: mln_CalEvaN pipeline wk6 GenerateData/structureN5L5 nmmParams 49 1 204 1 fMRI
