clear all, close all;
format longG;

function ret = yprim(x, y, beta)
    ret = 2/3*sin(y - 3*x) + beta.*y;
end

%X är vektorn startx:steglängd:slutx
function funkvarden = euler_y(X, y0, beta)
    funkvarden = [];
    funkvarden(end+1) = y0;
    f_this = y0;
    for i = 1:length(X)-1
        x_this = X(i);
        x_next = X(i+1);

        delta_x = x_next-x_this;
        dydx = yprim(x_this, f_this, beta);

        f_next = f_this + dydx*(delta_x);

        f_this = f_next;
        funkvarden(end+1) = f_this;
    end
end

function [integral, fel] = rotations_integral(X, Y, y0, beta)
    antalsteg = length(X)-1;
    %OBS: detta förutsätter att steglängden är konstant
    delta_x = X(2) - X(1);
    integral = 0;

    for i = 1:antalsteg
        r = Y(i);
        R = Y(i+1);
        %Vi använder formeln för volymen av en trunkerad kon.
        V = (pi/3)*delta_x*(R^2 + r^2 + R*r); 
        integral = integral + V;
    end
    X_2 = [];
    for i = 2:2:length(X)
        X_2(end+1) = X(i);
    end
    %Y_2 har dubbla steglängden av Y.
    Y_2 = euler_y(X_2, y0, beta);

    E = abs(Y(end) - Y_2(end));
    totE = (pi)*delta_x*(E^2);
    fel = totE;
end

function ret = malFunc(X, y0, beta)
    Y = euler_y(X, y0, beta);
    [V, E] = rotations_integral(X, Y, y0, beta);
    ret = V-2000;
end

%Antal steg från 2d
%antalsteg = 33554432;
antalsteg = 2^15; 
x_start = 0;
x_slut = pi/0.27;
h = (x_slut-x_start)/antalsteg;
X = x_start:h:x_slut;

%begynnelsevärde i x=0
y0 = 2;

%Vi börjar på samma intervall som förut
prev_prev_beta = 0.05;
prev_beta = 0.05;

this_beta = 0.4;
f_this = malFunc(X, y0, prev_beta);
count = 0;
%Samma tolerans som förut
tic;
allabetan = [];
while abs(f_this) >0.5*10^(-4)
    count = count + 1;
    f_prev = f_this;
    f_this = malFunc(X, y0, this_beta);
    taljare = f_this - f_prev;

    %Kolla om täljaren är så liten att det blir nolldivision i beräkningen
    if abs(taljare) < 10^(-9)

        disp("NOLLDIVISION")
        disp(taljare)
        break
    end

    faktor = (this_beta - prev_beta)/(taljare);
    new_beta = this_beta - faktor*f_this;
    prev_prev_beta = prev_beta;
    prev_beta = this_beta;
    this_beta = new_beta;
    allabetan(end+1) = this_beta;
end
tid = toc;



% BERÄKNA FEL
X_compare = [];
for i = 2:2:length(X)
    X_compare(end+1) = X(i);
end

Y = euler_y(X, y0, this_beta);

[Vol_1, felh] = rotations_integral(X, Y, y0, this_beta);
Y_compare = euler_y(X_compare, y0, this_beta);
[Vol_2, fel2h] = rotations_integral(X_compare, Y_compare, y0, this_beta);
volfel = abs(Vol_1 + felh - Vol_2 + fel2h);

betafel = abs(this_beta - prev_beta);
betakvot = betafel/abs(prev_beta - prev_prev_beta);


disp("BETA")
disp(this_beta)
disp("")
disp("ROTATIONSVOLYM")
[Vol, bryr_mig_inte] = rotations_integral(X, euler_y(X, y0, this_beta), y0, this_beta);
disp(Vol)
disp("")
disp("TID")
disp(tid)

disp("------------------------")
disp("FEL I BETA +-")
disp(betafel)
plot(log(1:length(allabetan)),log(allabetan));
disp("")
disp("FEL I VOLYM +-")
disp(volfel)
%%
antal_rotsteg = 20;
fi = linspace(0,2*pi, antal_rotsteg);


plot_X = X'.*ones(size(fi));
plot_Y = Y'.*cos(fi);
plot_Z = Y'.*sin(fi);
mesh(plot_Z, plot_Y, plot_X)