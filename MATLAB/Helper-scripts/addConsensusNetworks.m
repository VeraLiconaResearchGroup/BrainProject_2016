% Huifang Wang, Sep. 26, 2013
% Huifang Wang, Nov. 26, 2013 update Method Structure AUC for mlnI
function flg=addConsensusNetworks(dirname,prenom)

flg=0; % flg for the error

molecMeths ={'Genie' 'Tigress'};

topK = {'PCorrD', 'BCohF', 'Genie', 'BCorrD', 'BCorrU'};

top10 = {'BCorrD' 'Genie' 'BCohF' 'BCorrU' 'PCohF' 'Tigress' 'BH2U' ...
        'BH2D' 'BMITD2' 'PCorrD'};

% 2015's top five
% topK = {'Tigress', 'BCohF', 'Genie', 'BCorrD', 'BCorrU'};

% 2015's top ten
% top10 = {'BCorrD' 'Genie' 'BCohF' 'BCorrU' 'PCohF' 'Tigress' 'BH2U' ...
%         'BH2D' 'BTED' 'BTEU'};

exclude = {'AllMethods' 'NeuroMethods' 'MolecBioMethods' 'TopK' 'Top10' 'BCohW' 'PCohW' ...
           'pCOH1', 'Connectivity', 'Params'};

% exclude = {'AllMethods' 'NeuroMethods' 'MolecBioMethods' 'Top10' 'BCohW' 'PCohW' ...
%            'pCOH1', 'Connectivity', 'Params'};

filename1=['./',dirname,'/ToutResults/Tout_',prenom,'.mat'];
calresult=load(filename1);

fieldname=fieldnames(calresult);


consensustopKmean=zeros(size(calresult.Connectivity,1));

consensustopKmedian=zeros(size(calresult.Connectivity,1));

consensustop10mean=zeros(size(calresult.Connectivity,1));

consensustop10median=zeros(size(calresult.Connectivity,1));

consensustop10meanDIAG=zeros(size(calresult.Connectivity,1));

consensustop10medianDIAG=zeros(size(calresult.Connectivity,1));

count = 0.0;


for i=1:length(topK)
  methodname = topK{i};
  mat = calresult.(methodname);
  if any(isnan(mat(:)))
  else
      mat = abs(mat);
      consensustopKmean = consensustopKmean + mat;
      count = count + 1;
  end
end
consensustopKmean = consensustopKmean/double(count);

count = 0.0;
for i=1:10
  methodname = top10{i};
  mat = calresult.(methodname);
  if any(isnan(mat(:)))
  else
      mat = abs(mat);
      consensustop10mean = consensustop10mean + mat;
      count = count + 1;
  end
end
consensustop10mean = consensustop10mean/double(count);

count = 0.0;
for i=1:10
  methodname = top10{i};
  mat = calresult.(methodname);
  if any(isnan(mat(:)))
  else
      mat = abs(mat);
      consensustop10meanDIAG = consensustop10meanDIAG + mat;
      count = count + 1;
  end
end
consensustop10meanDIAG = consensustop10meanDIAG/double(count);
consensustop10meanDIAG = consensustop10meanDIAG - diag(diag(consensustop10meanDIAG));

% for i=1:10
%   methodname = top10{i};
%   mat = calresult.(methodname);
% %   mat = mat - diag(diag(mat));
%   if any(isnan(mat(:)))
%   else
%       mat = abs(mat);
%       consensustop10meanDIAG = consensustop10meanDIAG + mat;
%       count = count + 1;
%   end
% end
% consensustop10meanDIAG = consensustop10meanDIAG/double(count);
% % consensustop10meanDIAG = consensustop10meanDIAG - diag(diag(consensustop10meanDIAG));

listMethodEntries = zeros(length(topK),1) % dummy vector k1 k2 k3 k4 k5
for i=1:numel(consensustopKmedian) % for each entry in the 49 x 49 that we need to fill
    for j=1:length(listMethodEntries) % recreate the dummy vector with corresponding values
        listMethodEntries(j) = calresult.(topK{j})(i)
    end
    consensustopKmedian(i) = median(abs(listMethodEntries))
end

listMethodEntries = zeros(length(top10),1) % dummy vector k1 k2 k3 k4 k5
for i=1:numel(consensustop10median) % for each entry in the 49 x 49 that we need to fill
    for j=1:length(listMethodEntries) % recreate the dummy vector with corresponding values
        listMethodEntries(j) = calresult.(top10{j})(i)
    end
    consensustop10median(i) = median(abs(listMethodEntries))
end

listMethodEntries = zeros(length(top10),1) % dummy vector k1 k2 k3 k4 k5
for i=1:numel(consensustop10medianDIAG) % for each entry in the 49 x 49 that we need to fill
    for j=1:length(listMethodEntries) % recreate the dummy vector with corresponding values
        listMethodEntries(j) = calresult.(top10{j})(i)
    end
    consensustop10medianDIAG(i) = median(abs(listMethodEntries))
    consensustop10medianDIAG = consensustop10medianDIAG - diag(diag(consensustop10medianDIAG))
end


molecCount = 0.0;
brainCount = 0.0;
consensus44=zeros(size(calresult.Connectivity,1));
consensus42=zeros(size(calresult.Connectivity,1));
consensus2=zeros(size(calresult.Connectivity,1));

for i=1:length(fieldname)
  methodname = fieldname{i};
  mat = calresult.(methodname);
  
  if ismember(methodname, exclude) | any(isnan(mat(:)))
  else
      mat = abs(mat);
      if ismember(methodname, molecMeths)
          consensus2 = consensus2+mat;
          molecCount = molecCount + 1;
      else
          consensus42 = consensus42+mat;
          brainCount = brainCount + 1;
      end
      
      consensus44 = consensus44+mat;
  end 
end

consensus44 = consensus44/double(brainCount + molecCount);
consensus42 = consensus42/double(brainCount);
consensus2 = consensus2/double(molecCount);

calresult.('AllMethods') = consensus44;
calresult.('NeuroMethods') = consensus42;
calresult.('MolecBioMethods') = consensus2;
calresult.('TopKmean') = consensustopKmean;
calresult.('TopKmedian') = consensustopKmedian;
calresult.('Top10mean') = consensustop10mean;
calresult.('Top10median') = consensustop10median;
calresult.('Top10meanDIAG') = consensustop10meanDIAG;
calresult.('Top10medianDIAG') = consensustop10medianDIAG;

save(['./',dirname,'/ToutResults/Tout_',prenom, '_extended', '.mat'], '-struct', 'calresult');