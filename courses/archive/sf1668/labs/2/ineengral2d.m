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

function integral = rotations_integral(X, Y)
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
end

antalsteg_1 = 2;
antalsteg_2 = 2*antalsteg_1;
xslut = pi/0.27;
xstart = 0;
xlangd = xslut-xstart;
Rotvolymer = [];

this_h = xlangd/antalsteg_1;
next_h = xlangd/antalsteg_2;
X_1 = xstart:this_h:xslut;
X_2 = xstart:next_h:xslut;

beta = 0.07;

y0 = 2;

Y_1 = euler_y(X_1, y0, beta);
Y_2 = euler_y(X_2, y0, beta);

rotvolym_1 = rotations_integral(X_1, Y_1);
rotvolym_2 = rotations_integral(X_2, Y_2);
Rotvolymer(:, 1) = [ rotvolym_1; antalsteg_1 ];
Rotvolymer(:, 2) = [ rotvolym_2; antalsteg_2 ];

while abs(rotvolym_2 - rotvolym_1) >= 0.5*10^(-4)
    antalsteg_1 = antalsteg_2;
    antalsteg_2 = 2*antalsteg_1;

    %Konsekvens av att nya antalsteg_1 = gamla antalsteg_2
    %Vi hårdkodar det för att spara tid
    rotvolym_1 = rotvolym_2;

    this_h = xlangd/antalsteg_1;
    next_h = xlangd/antalsteg_2;
    X_1 = xstart:this_h:xslut;
    X_2 = xstart:next_h:xslut;
    
    %Samma anledning som rotvolym_1 = rotvolym_2
    Y_1 = Y_2;

    Y_2 = euler_y(X_2, y0, beta);
    rotvolym_2 = rotations_integral(X_2, Y_2);
    Rotvolymer(:, end+1) = [ rotvolym_2; antalsteg_2 ];
end

disp("NÄST SISTA VOLYMEN")
disp(Rotvolymer(1, end-1))
disp("")
disp("SLUTLIG VOLYM")
disp(Rotvolymer(1, end));

plot(Rotvolymer(2, :), Rotvolymer(1, :));

