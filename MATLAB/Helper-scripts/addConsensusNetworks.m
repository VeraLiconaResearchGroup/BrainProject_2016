% Huifang Wang, Sep. 26, 2013
% Huifang Wang, Nov. 26, 2013 update Method Structure AUC for mlnI
function flg=addConsensusNetworks(dirname,prenom)

flg=0; % flg for the error

molecMeths ={'Genie' 'Tigress'};

top2 = {'BCorrD' 'Genie'};

top3 = {'BCorrD' 'Genie' 'Tigress'};

top4 = {'BCorrD' 'Genie' 'Tigress' 'BCohF'};

top5 = {'BCorrD' 'Genie' 'Tigress' 'BCohF' 'BCorrU'};

top6 = {'BCorrD' 'Genie' 'Tigress' 'BCohF' 'BCorrU' 'BH2D'};

top7 = {'BCorrD' 'Genie' 'Tigress' 'BCohF' 'BCorrU' 'BH2D'...
    'PCohF'};

top8 = {'BCorrD' 'Genie' 'Tigress' 'BCohF' 'BCorrU' 'BH2D'...
    'PCohF' 'BTED'};

top9 = {'BCorrD' 'Genie' 'Tigress' 'BCohF' 'BCorrU' 'BH2D'...
    'PCohF' 'BTED' 'BTEU'};

top10 = {'BCorrD' 'Genie' 'Tigress' 'BCohF' 'BCorrU' 'BH2D'...
    'PCohF' 'BTED' 'BTEU' 'PTED'};

% 2015's top five
% top9 = {'Tigress', 'BCohF', 'Genie', 'BCorrD', 'BCorrU'};

% 2015's top ten
% top10 = {'BCorrD' 'Genie' 'BCohF' 'BCorrU' 'PCohF' 'Tigress' 'BH2U' ...
%         'BH2D' 'BTED' 'BTEU'};

exclude = {'AllMethods' 'NeuroMethods' 'MolecBioMethods' 'top9' 'Top10' 'BCohW' 'PCohW' ...
           'pCOH1', 'Connectivity', 'Params'};

% exclude = {'AllMethods' 'NeuroMethods' 'MolecBioMethods' 'Top10' 'BCohW' 'PCohW' ...
%            'pCOH1', 'Connectivity', 'Params'};

filename1=['./',dirname,'/ToutResults/Tout_',prenom,'.mat'];
calresult=load(filename1);

fieldname=fieldnames(calresult);

consensustop2mean=zeros(size(calresult.Connectivity,1));

consensustop2median=zeros(size(calresult.Connectivity,1));

consensustop3mean=zeros(size(calresult.Connectivity,1));

consensustop3median=zeros(size(calresult.Connectivity,1));

consensustop4mean=zeros(size(calresult.Connectivity,1));

consensustop4median=zeros(size(calresult.Connectivity,1));

consensustop5mean=zeros(size(calresult.Connectivity,1));

consensustop5median=zeros(size(calresult.Connectivity,1));

consensustop6mean=zeros(size(calresult.Connectivity,1));

consensustop6median=zeros(size(calresult.Connectivity,1));

consensustop7mean=zeros(size(calresult.Connectivity,1));

consensustop7median=zeros(size(calresult.Connectivity,1));

consensustop8mean=zeros(size(calresult.Connectivity,1));

consensustop8median=zeros(size(calresult.Connectivity,1));

consensustop9mean=zeros(size(calresult.Connectivity,1));

consensustop9median=zeros(size(calresult.Connectivity,1));

consensustop10mean=zeros(size(calresult.Connectivity,1));

consensustop10median=zeros(size(calresult.Connectivity,1));

%consensustop10meanDIAG=zeros(size(calresult.Connectivity,1));

%consensustop10medianDIAG=zeros(size(calresult.Connectivity,1));

count = 0.0;


for i=1:length(top9)
  methodname = top9{i};
  mat = calresult.(methodname);
  if any(isnan(mat(:)))
  else
      mat = abs(mat);
      consensustop9mean = consensustop9mean + mat;
      count = count + 1;
  end
end
consensustop9mean = consensustop9mean/double(count);

count = 0.0;


for i=1:length(top8)
  methodname = top8{i};
  mat = calresult.(methodname);
  if any(isnan(mat(:)))
  else
      mat = abs(mat);
      consensustop8mean = consensustop8mean + mat;
      count = count + 1;
  end
end
consensustop8mean = consensustop8mean/double(count);

count = 0.0;


for i=1:length(top7)
  methodname = top7{i};
  mat = calresult.(methodname);
  if any(isnan(mat(:)))
  else
      mat = abs(mat);
      consensustop7mean = consensustop7mean + mat;
      count = count + 1;
  end
end
consensustop7mean = consensustop7mean/double(count);


count = 0.0;


for i=1:length(top6)
  methodname = top6{i};
  mat = calresult.(methodname);
  if any(isnan(mat(:)))
  else
      mat = abs(mat);
      consensustop6mean = consensustop6mean + mat;
      count = count + 1;
  end
end
consensustop6mean = consensustop6mean/double(count);

count = 0.0;


for i=1:length(top5)
  methodname = top5{i};
  mat = calresult.(methodname);
  if any(isnan(mat(:)))
  else
      mat = abs(mat);
      consensustop5mean = consensustop5mean + mat;
      count = count + 1;
  end
end
consensustop5mean = consensustop5mean/double(count);

count = 0.0;


for i=1:length(top4)
  methodname = top4{i};
  mat = calresult.(methodname);
  if any(isnan(mat(:)))
  else
      mat = abs(mat);
      consensustop4mean = consensustop4mean + mat;
      count = count + 1;
  end
end
consensustop4mean = consensustop4mean/double(count);

count = 0.0;


for i=1:length(top3)
  methodname = top3{i};
  mat = calresult.(methodname);
  if any(isnan(mat(:)))
  else
      mat = abs(mat);
      consensustop3mean = consensustop3mean + mat;
      count = count + 1;
  end
end
consensustop3mean = consensustop3mean/double(count);

count = 0.0;


for i=1:length(top2)
  methodname = top2{i};
  mat = calresult.(methodname);
  if any(isnan(mat(:)))
  else
      mat = abs(mat);
      consensustop2mean = consensustop2mean + mat;
      count = count + 1;
  end
end
consensustop2mean = consensustop2mean/double(count);

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

%count = 0.0;
% for i=1:10
%   methodname = top10{i};
%   mat = calresult.(methodname);
%   if any(isnan(mat(:)))
%   else
%       mat = abs(mat);
%       consensustop10meanDIAG = consensustop10meanDIAG + mat;
%       count = count + 1;
%   end
%end
% consensustop10meanDIAG = consensustop10meanDIAG/double(count);
% consensustop10meanDIAG = consensustop10meanDIAG - diag(diag(consensustop10meanDIAG));

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

listMethodEntries = zeros(length(top9),1); % dummy vector k1 k2 k3 k4 k5
for i=1:numel(consensustop9median) % for each entry in the 49 x 49 that we need to fill
    for j=1:length(listMethodEntries) % recreate the dummy vector with corresponding values
        listMethodEntries(j) = calresult.(top9{j})(i);
    end
    consensustop9median(i) = median(abs(listMethodEntries));
end

listMethodEntries = zeros(length(top8),1); % dummy vector k1 k2 k3 k4 k5
for i=1:numel(consensustop8median) % for each entry in the 49 x 49 that we need to fill
    for j=1:length(listMethodEntries) % recreate the dummy vector with corresponding values
        listMethodEntries(j) = calresult.(top8{j})(i);
    end
    consensustop8median(i) = median(abs(listMethodEntries));
end

listMethodEntries = zeros(length(top7),1); % dummy vector k1 k2 k3 k4 k5
for i=1:numel(consensustop7median) % for each entry in the 49 x 49 that we need to fill
    for j=1:length(listMethodEntries) % recreate the dummy vector with corresponding values
        listMethodEntries(j) = calresult.(top7{j})(i);
    end
    consensustop7median(i) = median(abs(listMethodEntries));
end

listMethodEntries = zeros(length(top6),1); % dummy vector k1 k2 k3 k4 k5
for i=1:numel(consensustop6median) % for each entry in the 49 x 49 that we need to fill
    for j=1:length(listMethodEntries) % recreate the dummy vector with corresponding values
        listMethodEntries(j) = calresult.(top6{j})(i);
    end
    consensustop6median(i) = median(abs(listMethodEntries));
end

listMethodEntries = zeros(length(top5),1); % dummy vector k1 k2 k3 k4 k5
for i=1:numel(consensustop5median) % for each entry in the 49 x 49 that we need to fill
    for j=1:length(listMethodEntries) % recreate the dummy vector with corresponding values
        listMethodEntries(j) = calresult.(top5{j})(i);
    end
    consensustop5median(i) = median(abs(listMethodEntries));
end

listMethodEntries = zeros(length(top4),1); % dummy vector k1 k2 k3 k4 k5
for i=1:numel(consensustop4median) % for each entry in the 49 x 49 that we need to fill
    for j=1:length(listMethodEntries) % recreate the dummy vector with corresponding values
        listMethodEntries(j) = calresult.(top4{j})(i);
    end
    consensustop4median(i) = median(abs(listMethodEntries));
end

listMethodEntries = zeros(length(top3),1); % dummy vector k1 k2 k3 k4 k5
for i=1:numel(consensustop3median) % for each entry in the 49 x 49 that we need to fill
    for j=1:length(listMethodEntries) % recreate the dummy vector with corresponding values
        listMethodEntries(j) = calresult.(top3{j})(i);
    end
    consensustop3median(i) = median(abs(listMethodEntries));
end

listMethodEntries = zeros(length(top2),1); % dummy vector k1 k2 k3 k4 k5
for i=1:numel(consensustop2median) % for each entry in the 49 x 49 that we need to fill
    for j=1:length(listMethodEntries) % recreate the dummy vector with corresponding values
        listMethodEntries(j) = calresult.(top2{j})(i);
    end
    consensustop2median(i) = median(abs(listMethodEntries));
end

listMethodEntries = zeros(length(top10),1); % dummy vector k1 k2 k3 k4 k5
for i=1:numel(consensustop10median) % for each entry in the 49 x 49 that we need to fill
    for j=1:length(listMethodEntries) % recreate the dummy vector with corresponding values
        listMethodEntries(j) = calresult.(top10{j})(i);
    end
    consensustop10median(i) = median(abs(listMethodEntries));
end

% listMethodEntries = zeros(length(top10),1) % dummy vector k1 k2 k3 k4 k5
% for i=1:numel(consensustop10medianDIAG) % for each entry in the 49 x 49 that we need to fill
%     for j=1:length(listMethodEntries) % recreate the dummy vector with corresponding values
%         listMethodEntries(j) = calresult.(top10{j})(i)
%     end
%     consensustop10medianDIAG(i) = median(abs(listMethodEntries))
%     consensustop10medianDIAG = consensustop10medianDIAG - diag(diag(consensustop10medianDIAG))
% end


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
calresult.('top9mean') = consensustop9mean;
calresult.('top9median') = consensustop9median;
calresult.('top8mean') = consensustop8mean;
calresult.('top8median') = consensustop8median;
calresult.('top7mean') = consensustop7mean;
calresult.('top7median') = consensustop7median;
calresult.('top6mean') = consensustop6mean;
calresult.('top6median') = consensustop6median;
calresult.('top5mean') = consensustop5mean;
calresult.('top5median') = consensustop5median;
calresult.('top4mean') = consensustop4mean;
calresult.('top4median') = consensustop4median;
calresult.('top3mean') = consensustop3mean;
calresult.('top3median') = consensustop3median;
calresult.('top2mean') = consensustop2mean;
calresult.('top2median') = consensustop2median;
calresult.('Top10mean') = consensustop10mean;
calresult.('Top10median') = consensustop10median;
%calresult.('Top10meanDIAG') = consensustop10meanDIAG;
%calresult.('Top10medianDIAG') = consensustop10medianDIAG;

save(['./',dirname,'/ToutResults/Tout_',prenom, '_extended', '.mat'], '-struct', 'calresult');