%TEST VALUES
% p = [cykel bil kollektivt]'
% A = [1->1 1->2 1->3; 2->1 2->2 2->3; 3->1 3->2 3->3]'
% pStart = [0.3 0.2 0.5]';
% A = [0.7 0.1 0.2; 0.2 0.6 0.2; 0.3 0.1 0.6]';
% n = 5;

%% Create transition matrix
startYearData = 2005;
endYearData = 2019;

addpath("data");

states = ["Cykel", "Bil", "Kollektivt"];
fileExtension = ".csv";

tab1 = readtable(states(1)+fileExtension);
tab2 = readtable(states(2)+fileExtension);
tab3 = readtable(states(3)+fileExtension);

tab1 = removevars(tab1, "Daily");
tab2 = removevars(tab2, "Daily");
tab3 = removevars(tab3, "Daily");

tab1 = renamevars(tab1, "Total", "Antal passager: "+states(1));
tab2 = renamevars(tab2, "Total", "Antal passager: "+states(2));
tab3 = renamevars(tab3, "Total", "Antal påstigningar: "+states(3));

data = innerjoin(tab1, tab2, "keys", "Year");
data = innerjoin(data, tab3, "keys", "Year");

data.Properties.RowNames = string(table2array(data(:, "Year")));  % Adds years as ronames for indexing
data = removevars(data, "Year");

% Remap to parts instead of numbers
parts = data;
for i = 1:height(data)
    rowsum = sum(table2array(data(i, :)));
    for j = 1:length(parts.Properties.VariableNames)
        variable = string(parts.Properties.VariableNames(j));
        parts.(variable)(i) = data.(variable)(i)/rowsum;
    end
end

%T = transitionMatrix(startYearData, endYearData, parts)
T = [ 0.98,   0.01,  0.01;
      0.01,   0.94,  0.005;
      0.01,   0.05,  0.985 ];

%%  Calculate and present the result
startYearMod = 2005;
endYearMod = 2030;
pStart = [table2array(parts([string(startYearMod)], :))]';   % Extracts data from row with name specified by startYearMod

% pStart = [0 1 0]';
n = endYearMod-startYearMod;

pMat = markovChain(pStart, T, n);
pEnd = pMat(:, end);

% Plot
pStartPercent = round(100*pStart,1);
pEndPercent = round(100*pEnd, 1);

pStartString = states;
pEndString = states;
for i = 1:length(states)
    pStartString(i) = pStartString(i)+": "+pStartPercent(i)+" %";
    pEndString(i) = pEndString(i)+": "+pEndPercent(i)+" %";
end


header = "Tränad enligt data från "+string(startYearData)+" till "+string(endYearData);

x = startYearMod:endYearMod;
figure()


plotBoxX = 160;
plotBoxY = 50;
plotBoxWidth = 700;
plotBoxHeight = 500;
set(gca, 'Units', 'pixels', 'Position', [plotBoxX, plotBoxY, plotBoxWidth, plotBoxHeight])
hold on
for i = size(pMat, 1):-1:1
    plot(x, pMat(i, :), "LineWidth", 2, "DisplayName", states(i) + " (Modell)")
end

for j = width(parts):-1:1
    y = nan(1, length(x));
    years = str2double(parts.Properties.RowNames);
    if startYearMod > years(end)
        break
    elseif endYearMod > years(end)
        realData = table2array(parts(string(startYearMod:years(end)), j));
    else
        realData = table2array(parts(string(x), j));
    end
    y(1:length(realData)) = realData;
    plot(x, y, "LineStyle","--", "LineWidth", 2, "DisplayName", states(j) + " (Data)");
end

hold off
xline(endYearData, "Color", [1 0 0],  "LineWidth", 5, "Alpha", 0.2, "DisplayName", "Data cut-off")
legend()
grid on
xlabel("år")
%xticks(2005:25:2200)
xticks(x)
ylim([0 1.3])

title(header)
textBoxWidth = 120;
textBoxHeight = 100;
startBox = annotation("textbox", [0 0 0 0], "String", pStartString, "VerticalAlignment", "middle", "Units", "pixels");
startBox.Position = [plotBoxX-textBoxWidth-30, plotBoxY+plotBoxHeight/2-textBoxHeight/2, textBoxWidth, textBoxHeight];
endBox = annotation("textbox", [0 0 0 0], "String", pEndString, "VerticalAlignment", "middle", "Units", "pixels");
endBox.Position = [plotBoxX+plotBoxWidth+10, plotBoxY+plotBoxHeight/2-textBoxHeight/2, textBoxWidth, textBoxHeight];