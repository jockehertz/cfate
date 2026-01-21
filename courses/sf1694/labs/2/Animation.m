clear, close all;
addpath("data");
load BatMan.mat X;
addpath("functions");

theta = 5;
varv = 1.5;
R = rotation(theta);

PlotFigure(X);

for i = 0:theta:varv*360-theta
    X = R*X;
    PlotFigure(X);
    drawnow;
end