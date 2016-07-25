%% Converts the time series from a MULAN dataset into a DREAM5 software compatible format
% Parameters
% filename: name of MULAN mat file to be converted into txt file
%% Example execution: mat2txt testfile
function mat2txt(filename)
load([filename, '.mat']);
outfile = [filename, '.txt'];
header={1:size(LFP)};
fid = fopen(outfile, 'w');
fprintf(fid, '%d\t', header{:});
fprintf(fid, '\n');
fclose(fid);
dlmwrite(outfile,LFP','delimiter','\t','-append');​
