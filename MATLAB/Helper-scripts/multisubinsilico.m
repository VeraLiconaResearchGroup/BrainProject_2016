%% Loops through a data folder and creates names and dummy directories for the results of the mln_calEvaN function
%% Parameters
% name: name of the data
% start: # of first subject
% finish: # of last subject
%% Example execution: multisub SF 1 5
% Note: multisub will iterate through every consecutive subject number from the start value to the finish value
function multisubinsilico(name, start, finish)
  parfor i=str2num(start):str2num(finish)

    foldername = [name, '_', num2str(i)];
    mkdir(foldername);
    dir = [foldername];
    mkdir(dir, 'AUC');
    mkdir(dir, 'data');
    mkdir(dir, 'Results');
    mkdir(dir, 'ToutResults');
    genDatainsilico([foldername,'.mat'], foldername);
  end
