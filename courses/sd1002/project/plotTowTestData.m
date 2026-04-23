
% -------------------------------------------------------------------------
% Read and plot test data:
% 

% clear figs and workspace
clear
fH1 = figure(1);
clf(fH1);

% load data file names to plot:
[FileNames,PathName,FilterIndex] = uigetfile('*.csv','Select test files to plot.','MultiSelect','on');
addpath(PathName);

% set start and stop values for calc of statistics
startCalc   = 3000;     % (mm)
stopCalc    = 6000;     % (mm)


if ischar(FileNames)
    filename    = FileNames;
    numFiles    = 1;
else
    filename    = FileNames{fid};
    numFiles    = length(FileNames);
end

for fid = 1:numFiles

    delimiterIn     = ',';
    headerlinesIn   = 1;
    A               = importdata(filename,delimiterIn,headerlinesIn);

    headers     = A.colheaders(1:3);
    data        = A.data;
    
    time    = data(:,1);                % (sec)
    force   = data(:,2);                % (N)
    dist    = data(:,3);                % (mm)
    vel     = diff(dist)./diff(time);    % (mm/sec)
    
    startInd    = findClosest(dist, startCalc);
    stopInd     = findClosest(dist, stopCalc);

    meanForce   = mean(force(startInd:stopInd));
    maxForce    = max(force(startInd:stopInd));
    minForce    = min(force(startInd:stopInd));
    
    meanVel   = mean(vel(startInd:stopInd));
    maxVel    = max(vel(startInd:stopInd));
    minVel    = min(vel(startInd:stopInd));
    
    disp(['Mean force = ',num2str(meanForce),' (N)']);
    %disp(['Max force = ',num2str(maxForce),' (N)']);
    %disp(['Min force = ',num2str(minForce),' (N)']);
    
    disp(['Mean vel = ',num2str(meanVel),' (mm/s)']);
    %disp(['Max vel = ',num2str(maxVel),' (mm/s)']);
    %disp(['Min vel = ',num2str(minVel),' (mm/s)']);
    
    % plot results
    
	subplot(2,1,1);
        hold on
        plot(dist(1:end-1),vel(1:end),'*')
        ylabel('Vel     (mm/s)')
        xlabel('Dist    (mm)')
        legend(filename);
        
        %dim = [.2 .5 .8 .8];
        %str = ['mean=',num2str(meanVel),'(',num2str(startCalc),'-',num2str(stopCalc)];
        %annotation('textbox',dim,'String',str,'FitBoxToText','on');
        grid on;    
    subplot(2,1,2);
        hold on
        plot(time,force,'x');
        ylabel('Force (N)')
        xlabel('Dist (mm)')
        legend(filename);
        grid on;
        
end

figSave = ['Results'];
saveas(fH1,'Results.png')





