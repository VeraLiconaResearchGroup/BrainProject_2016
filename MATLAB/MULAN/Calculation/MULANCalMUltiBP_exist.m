function MULANCalMUltiBP_exist(dirname,prenom,paramsfile,VGroupMethlog)
% Huifang Wang, Marseille, August 26, 2013, Calculate all datasets with
% basic prenom
paramsfile=[dirname,'/',paramsfile];
load(paramsfile,'calParams')

MulanCal_exist(dirname,prenom,calParams,VGroupMethlog);
mln_Result2file(dirname,prenom,VGroupMethlog)

