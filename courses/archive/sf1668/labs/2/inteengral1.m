clear all, close all;
%Integraler
function ret = func(x)
    ret = 64*exp(-0.3*(x-3).^2);
end

function ret = punc(x)
    ret = (x-1).^6;
end

function ret = gunc(x)
    ret = func(x)-punc(x);
end

%löst algebraiskt
xskarning = 3;

P = [xskarning;func(xskarning)];
antalsteg = 100;
xstart = 0;
xslut = xskarning;
intervalllangd = xslut-xstart;
h = intervalllangd/antalsteg;

x=xstart:h:xslut; % ange lampligt intervall


f=func(x); % vektor med f-vardena for dessa x.
p=punc(x); % vektor med p-vardena for dessa x.
xx=[x(:); flip(x(:))];
yy=[f(:); flip(p(:))];
fill(xx,yy,'g');

%% c, skriv en trapetsregel

Integraler = [];

for i = 1:10
    antalsteg = 2^i;

    xstart = 0;
    xslut = xskarning;
    intervalllangd = xslut-xstart;
    h = intervalllangd/antalsteg;
    x=xstart:h:xslut; % ange lampligt intervall

    t = 0.5*gunc(x(1));

    if length(x)>2
        for i = x(2:end-1)
            t = t + gunc(i);
        end
    end

    t = t + (1/2)*gunc(x(end));

integral = h*t;
disp(integral)
Integraler(1, end+1) = integral;
Integraler(2, end) = antalsteg;
end


plot(Integraler(2, :), Integraler(1, :))


%% 1e
Integraler = [];

iterationer = 16;

for i = 1:iterationer
    antalsteg = 2^i;

    xstart = 0;
    xslut = xskarning;
    intervalllangd = xslut-xstart;
    h = intervalllangd/antalsteg;
    x=xstart:h:xslut; % ange lampligt intervall

    t = 0.5*gunc(x(1));

    if length(x)>2
        for i = x(2:end-1)
            t = t + gunc(i);
        end
    end

    t = t + (1/2)*gunc(x(end));

integral = h*t;
Integraler(1, end+1) = integral;
Integraler(2, end) = antalsteg;
end

format long;

T_hatt = [];
for j = 2:length(Integraler)
    Th = Integraler(1, j-1);
    steg = Integraler(2, j-1);
    T2h = Integraler(1, j);
    richard = Th - (Th - T2h)/(3);
    disp(richard)
    T_hatt(:, end+1) = [richard; steg];
end

disp("ANTAL STEG")
disp(T_hatt(2, end))