%% Iterates through every directory with the format [name]_Sub[# iteration] and saves adjacency matrices of the mean, min,
%% and max edge values for all the methods and a list of the mean, min, and max edge values for each methods and for 
%% all methods.
%% Parameters
% name: name of the data
% start: # of first subject
% finish: # of last subject
%% Example execution: multisub_analyze ADHD 1 70
% Note: multisub_analyze will iterate through every consecutive subject number from the start value to the finish value

function multisub_analyze(name, start, finish)
    extraZero = '00';
    diagonalOnes = diag(diag(ones(49,49)));
    Combined = zeros(str2num(finish)-str2num(start), 3);
    mkdir('Analysis');
    
    % Iterate through results
    for j=str2num(start):str2num(finish)
      if j < 100 & j > 9
        extraZero = '0';
      elseif j >= 100
        extraZero = '';
      end
      foldername = [name, '_Sub', extraZero, num2str(j)];
      method = '';
      meanMat = zeros(49,49);
      minMat = ones(49,49);
      maxMat = zeros(49,49);
      All = zeros(42,3);
      All(:,2) = 1;
      mkdir(['Analysis/', foldername, '_analysis']);
      mkdir(['Analysis/', foldername, '_analysis/AllMatrices']);
      
      % Iterate through each individual method's adjacency matrix. Can be adjusted to select certain method's results.
      for i=1:41
        switch i
          case 1
            method = 'AS';
          case 2
            method = 'Af';
          case 3
            method = 'COH1';
          case 4
            method = 'COH2';
          case 5
            method = 'DC1';
          case 6
            method = 'DTF';
          case 7
            method = 'GGC';
          case 8
            method = 'GPDC';
          case 9
            method = 'MVAR';
          case 10
            method = 'PDC';
          case 11
            method = 'Smvar';
          case 12
            method = 'dDTF';
          case 13
            method = 'ffDTF';
          case 14
             method = 'hmvar';
          case 15
             method = 'oPDCF';
          case 16
             method = 'pCOH2';
          case 17
             method = 'BCohF';
          case 18
             method = 'PCohF';
          case 19
             method = 'Genie';
          case 20
             method = 'CondGC';
          case 21
             method = 'GC';
          case 22
             method = 'PGC';
          case 23
             method = 'BH2D';
          case 24
             method = 'BH2U';
          case 25
             method = 'PH2D';
          case 26
             method = 'PH2U';
          case 27
             method = 'BMITD1';
          case 28
             method = 'BMITD2';
          case 29
             method = 'BMITU';
          case 30
             method = 'PMITD1';
          case 31
             method = 'PMITD2';
          case 32
             method = 'PMITU';
          case 33
             method = 'BTED';
          case 34
             method = 'BTEU';
          case 35
             method = 'PTED';
          case 36
             method = 'PTEU';
          case 37
             method = 'Tigress';
          case 38
             method = 'BCorrD';
          case 39
             method = 'BCorrU';
          case 40
             method = 'PCorrD';
          case 41
             method = 'PCorrU';
          otherwise
             method = '';
        end
      load([foldername, '/ToutResults/Tout_', foldername, 'fmriCS100S1N204.mat']);
      adj = eval(method);
      adj = abs(adj);
      dlmwrite(['Analysis/', foldername, '_analysis/AllMatrices/', method, '_Adj.txt'], adj, 'delimiter', '\t');
      
      % Check and compare every edge for min and max
      for m=1:49
        for n=1:49
          if m ~= n
            if adj(m,n) > maxMat(m,n)
              maxMat(m,n) = adj(m,n);
            end
            if adj(m,n) < minMat(m,n)
              minMat(m,n) = adj(m,n);
            end
          end
        end
      end
      
      % Add all edge values from the method for the mean
      tempMat = adj - diag(diag(adj));
      meanMat = meanMat + tempMat;
      
      % Add mean, min, and max edges for the method to the complete list
      All(i,1) = sum(sum(tempMat)) / 2352;
      All(i,2) = min(min(tempMat + diagonalOnes));
      All(i,3) = max(max(tempMat));
      All(42,1) = All(42,1) + All(i,1);
    end
    
    % Compile all analysis results into their respective matrices
    All(42,1) = All(42,1) / 41;
    All(42,2) = min(min(minMat));
    All(42,3) = max(max(maxMat));
    meanMat = meanMat / 41;
    meanMat = meanMat + diagonalOnes;
    maxMat = maxMat + diagonalOnes;
    Combined(j - str2num(start) + 1,:)= All(42,:);
    
    % Save all analysis results for the subject
    dlmwrite(['Analysis/', foldername, '_analysis/MeanMatrix.txt'], meanMat, 'delimiter', '\t');
    dlmwrite(['Analysis/', foldername, '_analysis/MinMatrix.txt'], minMat, 'delimiter', '\t');
    dlmwrite(['Analysis/', foldername, '_analysis/MaxMatrix.txt'], maxMat, 'delimiter', '\t');
    dlmwrite(['Analysis/', foldername, '_analysis/AllMethodsAnalysis.txt'], All, 'delimiter', '\t');
  end
  
  % Save combined analysis results from all subjects
  dlmwrite(['Analysis/', name, '_CombinedAnalysis.txt'], Combined, 'delimiter', '\t');
