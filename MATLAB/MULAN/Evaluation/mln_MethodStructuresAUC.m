% Huifang Wang, Sep. 26, 2013
% Huifang Wang, Nov. 26, 2013 update Method Structure AUC for mlnI
%% Modified to include PPV and ACC

function flg=mln_MethodStructuresAUC(dirname,prenom)

flg=0; % flg for the error


filename=['./',dirname,'/ToutResults/Tout_',prenom,'.mat'];

calresult=load(filename);
fieldname=fieldnames(calresult);
% remove params and connectivity
fieldname(strcmp('Params',fieldname))=[];

fieldname(strcmp('Connectivity',fieldname))=[];
%%
%idx=find(strcmp('pCOH1',fieldname));
%fieldname(idx)=[];
%%
Nmethod=length(fieldname);
Meths.MSAUC=zeros(Nmethod,1);
Meths.Mth=zeros(Nmethod,1);
Meths.Fpr=zeros(Nmethod,100);
Meths.Tpr=zeros(Nmethod,100);
Meths.PPV=zeros(Nmethod,100);
Meths.ACC=zeros(Nmethod,100);

filesaved=['AUC_',prenom,'.mat'];

Meths.Methodnames=fieldname;

Meths.Connectivity=calresult.Connectivity;
ncheck = true;

for imethod=1:Nmethod
    Methods=fieldname{imethod};
    
    Mat=calresult.(Methods);
    if any(isnan(Mat(:)))
        auc=0;
        chis=1;
        iMat=NaN(size(Mat,1));
        Fpr=zeros(100,1);
        Tpr=zeros(100,1);
        PPV=zeros(100,1);
        ACC=zeros(100,1);
    else     
        iMat=mean(abs(Mat),3);
        iMat=iMat-diag(diag(iMat));
        [~,~,~,Fpr,Tpr,~,~,~,auc,~,thresh3,PPV,ACC]= ...
            mln_calcFalseRateextended(iMat,calresult.Connectivity,mln_issymetricM(Methods),1);
        chis=mln_chis(Mat,thresh3(1));
    end
    
    Meths.MSAUC(imethod,1)=auc;
    Meths.Fpr(imethod,:) = squeeze(Fpr);
    Meths.Tpr(imethod,:) = squeeze(Tpr);
    Meths.PPV(imethod,:) = squeeze(PPV);
    Meths.ACC(imethod,:) = squeeze(ACC);
    
    if isempty(chis)
        pause
    end
    
    
    Meths.Mth(imethod,1)=chis;
    Meths.Mat(:,:,imethod)=iMat;
end

save(['./',dirname,'/AUC/',filesaved],'Meths');
%genTopROC(['./',dirname,'/AUC/',filesaved], 10);
%genTopROC(['./',dirname,'/AUC/',filesaved], Nmethod);