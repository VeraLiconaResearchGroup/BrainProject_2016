%cd /home/CAM/veralicona/shichao/

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

mex ../GENIE/RT/rtree-c/rtenslearn_c.c;
ext = mexext;
movefile(fullfile(pwd, ['rtenslearn_c' '.' ext]), fullfile('../GENIE/RT/', ...
                                                  ['rtenslearn_c' '.' ext]));

calParams.defwindow='200';
calParams.defoverlap='0';

calParams.defmodelorders='5';
calParams.minfreq='1';
calParams.maxfreq='30';
calParams.stepfreq='0.5';
calParams.defbins='16';
calParams.defMaxDelay='5';



calParams.genieMethod = '1';
calParams.genieNbTrees = '500';
calParams.genieK = '0';

calParams.tigressR = '500';
calParams.tigressAlpha = '0.3';
calParams.tigressL = '3';
calParams.tigressLarsAlgo = '0';
calParams.tigressScoreMethod = '1';

save('nmmParams1.mat','calParams');

calParams.genieMethod = '1';
calParams.genieNbTrees = '500';
calParams.genieK = '-1';

calParams.tigressR = '500';
calParams.tigressAlpha = '0.3';
calParams.tigressL = '3';
calParams.tigressLarsAlgo = '0';
calParams.tigressScoreMethod = '1';

save('nmmParams2.mat','calParams');

calParams.genieMethod = '1';
calParams.genieNbTrees = '500';
calParams.genieK = '3';

calParams.tigressR = '500';
calParams.tigressAlpha = '0.3';
calParams.tigressL = '3';
calParams.tigressLarsAlgo = '0';
calParams.tigressScoreMethod = '0';


save('nmmParams3.mat','calParams');

calParams.genieMethod = '0';
calParams.genieNbTrees = '500';
calParams.genieK = '0';

calParams.tigressR = '500';
calParams.tigressAlpha = '0.3';
calParams.tigressL = '3';
calParams.tigressLarsAlgo = '0';
calParams.tigressScoreMethod = '0';

save('nmmParams4.mat','calParams');

calParams.genieMethod = '0';
calParams.genieNbTrees = '500';
calParams.genieK = '-1';

calParams.tigressR = '2000';
calParams.tigressAlpha = '0.3';
calParams.tigressL = '3';
calParams.tigressLarsAlgo = '0';
calParams.tigressScoreMethod = '1';

save('nmmParams5.mat','calParams');

calParams.genieMethod = '0';
calParams.genieNbTrees = '500';
calParams.genieK = '3';

calParams.tigressR = '2000';
calParams.tigressAlpha = '0.3';
calParams.tigressL = '3';
calParams.tigressLarsAlgo = '0';
calParams.tigressScoreMethod = '1';

save('nmmParams6.mat','calParams');

parfor i = 1:1    
    nc = 50;
    is = 1;
    T = 200;
    prenom = 'sim4';

    
    generateScaleFree(nc, i);
    generateDirectedRandom(nc, 0.05, i);
    
    sfStrct = ['GenerateData/structureN' int2str(nc) 'scaleFree' ...
               int2str(i)];
    rStrct = ['GenerateData/structureN' int2str(nc) 'directedRandom' ...
              int2str(i)];

    sFolder = ['scaleFree' int2str(i) '_params'];
    
    rFolder = ['directedRandom' int2str(i) '_params'];


    mln_generate_fMRI_multi(is, nc, sfStrct, sFolder, ...
                            prenom, 1, T, 6);
    
    mln_generate_fMRI_multi(is, nc, rStrct, rFolder, ...
                            prenom, 1, T, 6);
    
    for j = 1:6
        
        mln_CalEvaN([rFolder int2str(j)], 'sim4', rStrct, ['nmmParams' int2str(j)], ...
                    '50', '1', '200', '1', 'fMRI');
        
        mln_CalEvaN([sFolder int2str(j)], 'sim4', sfStrct, ['nmmParams' int2str(j)], ...
                    '50', '1', '200', '1', 'fMRI');
        
    end
end