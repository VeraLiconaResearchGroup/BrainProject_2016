function mln_calcMatMITime_priordata(Resultfile,VMethlog,lfp,params)

%% to calculate the connectivity matrix for Mvar_based methods in Methlog
% Methlog:  'MVAR': MVAR
% Huifang Wang, June 8, 2012, Inserm U1106, Marseille
if iscell(VMethlog)
    Methlog=char(VMethlog{1});
else
    Methlog=VMethlog;
end
NMlog=length(Methlog);

%% if there is not the result then calculate

[Nchannel, Ntime]=size(lfp);

if ~params.overlap==0
    overlap_p=params.wins*params.overlap;
    Nwindows=floor((Ntime-overlap_p)/(params.wins-overlap_p));
else
    overlap_p=0;
    Nwindows=floor(Ntime/params.wins);
end
% initialization
Dmatt=[Nchannel,Nchannel,Nwindows];
NMeths=length(VMethlog);
for i=1:NMeths
    iMeth=char(VMethlog{i});
    if ~isempty(iMeth)       
        Mat.(iMeth)=zeros(Dmatt);
    end
end


VMethodlog=fieldnames(Mat);
Nmethod=length(VMethodlog);
for i=1:Nwindows
    i_lfp=lfp(:,floor((i-1)*(params.wins-overlap_p)+1):floor(i*params.wins-(i-1)*overlap_p));
    iMat=mln_icalcMatMITime(i_lfp,params);
    for j=1:Nmethod
        jMethodlog=char(VMethodlog(j));
        if istimeM(jMethodlog)
            Mat.(jMethodlog)(:,:,i)=iMat.(jMethodlog);
        else
            Mat.(jMethodlog)(:,:,:,i)=iMat.(jMethodlog);
        end
    end
end

updateResult(Resultfile,Mat,params);