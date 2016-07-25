cd /home/CAM/veralicona/sim/

mfilepath=pwd
addpath(fullfile(mfilepath, './MULAN'))
addpath (fullfile(mfilepath, './MULAN/Calculation'))
addpath (fullfile(mfilepath, './MULAN/ClusterComputation'))
addpath (fullfile(mfilepath, './MULAN/Evaluation'))
addpath (fullfile(mfilepath, './MULAN/Examples'))
addpath (fullfile(mfilepath, './MULAN/Examples/data'))
addpath (fullfile(mfilepath, './MULAN/Examples/Results'))
addpath (fullfile(mfilepath, './MULAN/GenerateData'))
addpath (fullfile(mfilepath, './MULAN/Interface'))
addpath (fullfile(mfilepath, './GENIE'))
addpath (fullfile(mfilepath, './GENIE/RT'))
addpath (fullfile(mfilepath, './TIGRESS'))
addpath (fullfile(mfilepath, './TIGRESS/lars'))
addpath (fullfile(mfilepath, './ScaleFree'))
addpath (fullfile(mfilepath, './Helper-scripts'))
cd ./MULAN
mln_generateParams

mex ../GENIE/RT/rtree-c/rtenslearn_c.c;
ext = mexext;
movefile(fullfile(pwd, ['rtenslearn_c' '.' ext]), fullfile('../GENIE/RT/', ...
                                                  ['rtenslearn_c' '.' ext]));
multisub_sims('sim4', '1', '50');