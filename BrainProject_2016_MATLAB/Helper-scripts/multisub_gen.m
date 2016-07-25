%% Evaluate MULAN results
%% Parameters
% name: name of directory with MULAN results
% first: # of first subject
% last: # of last subject
% time: length of time series
%% Example execution: multisub_gen sim4 1 50 200
% Note: multisub_gen will iterate through every consecutive subject number from the start value to the finish value

function multisub_gen(name, start, finish, time)
    extraZero = '00';
    for i=str2num(start):str2num(finish)
      if i < 100 & i > 9
        extraZero = '0';
      elseif i >= 100
        extraZero = '';
      end
      foldername = [name, '_Sub', extraZero, num2str(i)];
      mln_MethodStructuresAUCextended([foldername],[foldername, 'fmriCS100S1N', time]);
    end
