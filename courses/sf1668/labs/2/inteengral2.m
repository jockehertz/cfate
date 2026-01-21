clear all, close all;

function ret = yunc(x, beta)
    ret = (exp((-x.*beta))+0.6).*(1+((x./9).^3));
end

function ret = rotintunc(x, beta, h)
    integral = 0;
    t = (1/2)*(yunc(x(1), beta)^2);
    if length(x)>2
        for i = 2:length(x)-1
            t = t + (yunc(x(i), beta)^2);
        end
    end
    t = t + ((1/2)*yunc(x(end), beta)^2);

    integral = t*h;

    vol = pi*integral;

    ret = vol;
end

function ret = richard(Volymer, antal_hattar)
    iterationer = length(Volymer);
    V_hatt = [];
    for i = 1:iterationer-1
        Vh = Volymer(1, i+1);
        V2h = Volymer(1, i);
        nya_v = Vh + (Vh - V2h)/(2^(2*antal_hattar+1)-1);
        V_hatt(:, end+1) = [nya_v; Volymer(2, i+1)];
    end
    ret = V_hatt;
end

Volymer = [];
iterationer = 18;

for i = 1:iterationer
    antalsteg = 2^i;
    xstart = 0;
    xslut = 26;
    xlangd = xslut-xstart;
    h = xlangd/antalsteg;
    x = xstart:h:xslut;

    beta = 0.2;

    y = yunc(x,beta);

    volym = rotintunc(x, beta, h);

    disp(volym);

    Volymer(:, end+1) = [volym; antalsteg];
end

disp("RICHARDSONEXTRAPOLERING")
antal_hattar = 0;
V_richard = Volymer;
for i = 1:iterationer-2
    V_richard = richard(V_richard, antal_hattar);
    antal_hattar = antal_hattar+1;
end
disp(V_richard);

kvot = (Volymer(1, end-2)-Volymer(1, end-1))/(Volymer(1, end-1) - Volymer(1, end));
disp("KVOT")
disp(kvot)

disp("ETRUNK")

etrunk1 = abs(Volymer(1, end-1) - Volymer(1, end));

etrunk2 = abs(V_richard(1, end-1) - V_richard(1, end));

disp("Vanligt:")
disp(etrunk1)
disp("")
disp("Richardsson-extrapolering")
disp(etrunk2)

%% 2c
format long;
clear all;

antalsteg = 2^17;
xstart = 0;
xslut = 26;
xlangd = xslut-xstart;
h = xlangd/antalsteg;
x = xstart:h:xslut;


function ret = malFunc(x, beta, h)
    ret = rotintunc(x, beta, h) - 3500;
end


%Om slutbetat (this_beta) är för stort så blir funktionen för flak.
%0.4 funkade inte.
prev_beta = 0.05;

this_beta = 0.2;

disp("Sekantmetoden")
count = 0;

while abs(malFunc(x, this_beta, h)) > 10^(-7) 
    count = count+1;

    f_prev = malFunc(x, prev_beta, h);
    f_this = malFunc(x, this_beta, h);
    taljare = f_this - f_prev;

    %Kolla om täljaren är så liten att det blir nolldivision i beräkningen
    if abs(taljare) < 10^(-9)
        disp("NOLLDIVISION")
        disp(taljare)
        break
    end

    faktor = (this_beta - prev_beta)/(taljare);
    new_beta = this_beta - faktor*f_this;
    prev_beta = this_beta;
    this_beta = new_beta;
end

err = abs(this_beta - prev_beta);

disp("----------------------")
disp("ITERATIONER")
disp(count);
disp("")
%disp(prev_beta);
disp("BETA")
disp(this_beta);
disp("MED ABSOLUTA FELET")
disp(err)
disp("")
disp("VÄRDE FÖR ROTATIONSINTEGRALEN")
disp(rotintunc(x, this_beta, h))