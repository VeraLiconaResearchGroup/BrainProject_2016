%% Loops through a data folder and creates names and dummy directories for the results of the mln_calEvaN function
%% Parameters
% name: name of the data
% start: # of first subject
% finish: # of last subject
%% Example execution: multisub SF 1 5
% Note: multisub will iterate through every consecutive subject number from the start value to the finish value
function multisubinsilico_slidewin(name, start, finish, winlength, winoverlap)
winlength = str2num(winlength);
winoverlap = str2num(winoverlap);
  parfor i=str2num(start):str2num(finish)
    t = 1;
    wincount=1;
    t_end = winlength;
    
    while (t_end <= 204)
        OGdatafile = [name, '_', num2str(i)];
        foldername = [name, '_', num2str(i), '_', 'L', num2str(winlength), 'O', num2str(winoverlap), 'win', num2str(t)];
        mkdir(foldername);
        dir = [foldername];
        mkdir(dir, 'AUC');
        mkdir(dir, 'data');
        mkdir(dir, 'Results');
        mkdir(dir, 'ToutResults');
        genDatainsilico_slidewin([OGdatafile, '.mat'], foldername, t, t_end);
        
        t = t + winlength - winoverlap;
        t_end = t + winlength - 1;
        wincount = wincount + 1;
    end
  end
