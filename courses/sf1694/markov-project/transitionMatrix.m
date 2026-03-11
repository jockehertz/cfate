function T = transitionMatrix(startYear,endYear, Table)
%LEASTSQUARE Summary of this function goes here

years = str2double(Table.Properties.RowNames);

if startYear < years(1)
    disp("Invalid start year, earliest is", years(1));
    exit;
elseif endYear > years(end)
    disp("Invalid end year, lates is", years(end));
    exit;
end

% Pick out the years we want
rows = string(startYear:1:endYear);
Table = Table(rows, :);

Data = table2array(Table);

% Remap to parts instead of numbers
Parts = zeros(height(Data), width(Data));
for i = 1:height(Data)
    rowsum = sum(Data(i, :));
    for j = 1:width(Data)
        Parts(i, j) = Data(i, j)/rowsum;
    end
end

Y = Parts(2:end, :);
X = Parts(1:end-1, :);

% Least Squares
%T = (Y \ X)';

% Supresses the display from lsqlin
options = optimoptions('lsqlin', 'Display', 'off');
n = width(Y);
T = zeros(n);
% These two define that the sum of all row elements equal 1
Aeq = ones(1, n);
beq = 1;

% The lower bound - no negative values allowed
lb = zeros(n, 1);

% Solve it row-by-row with lsqlin
for i = 1:n
    T(:, i) = lsqlin(X, Y(:, i), [], [], Aeq, beq, lb, [], [], options);
    % T(:, i) = lsqnonneg(X, Y(:, i));
    % T(:, i) = X \ Y(:, i);
    % T(:, i) = T(:, i) ./ sum(T(:, i));
end
end