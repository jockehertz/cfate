clear, close all;
addpath("data");
load STHLMARN2021.mat Td;
disp("-----------------")

% identitet för sinus av två vinklar:
% sin(u+v) = sin(u)cos(v) + sin(v)cos(u)
% u = wt, v = -wts
% sin(wt - wts) = sin(wt)cos(-wts) + sin(-wts)cos(wt)
% sin(wt - wts) = sin(wt)cos(wts) - sin(wts)cos(wt)
% c3sin(wt-wts) = c3cos(wts)sin(wt) + (-c3sin(wts))cos(wt)
% A0 = c3cos(wts), A1 = -c3sin(wts)
% c3sin(wt-wts) = A0sin(wt) + A1cos(wt) QED.

w = 2*pi/(365*24);
period = 365*24;

t = (1:length(Td))';

A = [cos(w*t), sin(w*t), t, ones(size(t))];

coefficients = A \ Td; % Solve for coefficients using least squares
% Extract coefficients for sinusoidal components
A1 = coefficients(1);
A0 = coefficients(2);
c2 = coefficients(3);
c1 = coefficients(4);

ym = @(t) c1 + c2*t + A0*sin(w*t) + A1*cos(w*t);

T = ym(t);
year_1 = T(1:period);

% Calculate amplitude from max and min of year 1 projection.
amplitude = (max(year_1) - min(year_1))/2; 

shift = (1/w)*acos(A0/amplitude);

residualnorm = norm(Td - T, 2);

% Den linjära konsanten är pyttepytteliten. Ingen märkvärdig ökning eller
% minskning givet antalet värdeisffror vi fått
disp("LINJÄR KONSTANT: " + c2);
disp("AMPLITUD: " + amplitude);
disp("FASFÖRSKJUTNING: " + shift);
disp("NORM FÖR RESIDUALEN: " + residualnorm);

f1 = figure;
plot(1:length(Td), Td);
hold on;

title 'Temperatur över tid, per timme';
plot(t, T);

legend("Uppmätt data", "Modell");
hold off;

%%
%
%
%
%
%

disp("--------------------")
disp("")

Tdag = [];

for i =1:24:(length(Td)-24)
    Tdag(end+1, 1) = mean(Td(i:i+24));
end

t2 = (1:length(Tdag))';
w2 = 2*pi/365;
period=365;

Adag = [cos(w2*t2), sin(w2*t2), t2, ones(size(t2))];

coefficients = Adag \ Tdag; % Solve for coefficients using least squares
% Extract coefficients for sinusoidal components
A1 = coefficients(1);
A0 = coefficients(2);
c2 = coefficients(3);
c1 = coefficients(4);

ym = @(t) c1 + c2*t + A0*sin(w2*t) + A1*cos(w2*t);

T = ym(t2);
year_1 = T(1:period);

% Calculate amplitude from max and min of year 1 projection.
amplitude = (max(year_1) - min(year_1))/2; 

shift = (1/w)*acos(A0/amplitude);

residualnorm = norm(Tdag - T, 2);

% Den linjära konsanten är pyttepytteliten. Ingen märkvärdig ökning eller
% minskning givet antalet värdeisffror vi fått

% Residualen i denna blev betydligt mindre än den förra.
disp("LINJÄR KONSTANT (DAG): " + c2);
disp("AMPLITUD (DAG): " + amplitude);
disp("FASFÖRSKJUTNING (DAG): " + shift);
disp("NORM FÖR RESIDUALEN FÖR DAGSMODELL: " + residualnorm);

f2 = figure;

plot(t2, Tdag);
hold on;
title 'Temperatur över tid, dagsmedeltemperatur';
plot(t2, T);
legend("Uppmätt data", "Modell");
hold off;