clear all, close all;
format long;
start_nodUpper = [0;1];
start_nodLower = [0; 0.8];
slut_nod = [1; 0.5];
%slut_nod = ginput();
antal_noder = 12;
kraft = -100;
d = start_nodUpper(2)-start_nodLower(2); %avståndet mellan startnoderna

function ret = skapaFackverk(start_nodUpper, start_nodLower, slut_nod, antal_noder, d)
    %Delar upp noderna i övre och undre rad
    antal_noderUpper = ceil(antal_noder/2);
    antal_noderLower = floor(antal_noder/2);

    %Räknar ut om slutnoden är i övre eller undre raden
    is_slut_nod_upper = mod(antal_noder,2) == 1;
    Noder_Lower = start_nodLower;
    Noder_Upper = start_nodUpper;
    Noder = [;];

    %Räknar ut längden på de längsmedliggande balkarna
    if is_slut_nod_upper
       balk_length_b = norm(slut_nod-start_nodUpper)/antal_noderUpper;
       kranvinkel = atan((slut_nod(2)-start_nodUpper(2))/(slut_nod(1)-start_nodUpper(1)));
    else
       balk_length_b = norm(slut_nod-start_nodLower)/antal_noderLower;
       kranvinkel = atan((slut_nod(2)-start_nodLower(2))/(slut_nod(1)-start_nodLower(1)));
    end

    c = d*sin(pi/2-kranvinkel);
    %Räknar ut längden på de tvärgående balkarna
    balk_length_a = sqrt(power(c, 2) + power(balk_length_b/2, 2));

    %Räknar ut vinkeln på balkarna
    theta = atan(balk_length_b/(2*c));

    %Skapar fackverket, den generar en rad utifrån den andra, beroende på
    %om slutnoden är överst eller underst
    if is_slut_nod_upper
        delta_x = (slut_nod(1)-start_nodUpper(1))/antal_noderUpper;
        delta_y = (slut_nod(2)-start_nodUpper(2))/antal_noderUpper;
        x0 = start_nodUpper(1);
        y0 = start_nodUpper(2);
        for i = 1:antal_noderUpper
            x1 = x0 + delta_x;
            x0 = x1;

            y1 = y0 + delta_y;
            y0 = y1;

            Noder_Upper(1,end+1) = x1;
            Noder_Upper(2,end) = y1;
        end
        %r1 är kranens riktningsvektor
        r1 = 1/2*[delta_x; delta_y];
        r2x = sqrt(power(c, 2)/(1+power((delta_x/delta_y), 2)));
        r2y = -1*(delta_x/delta_y)*r2x;
        r2 = [r2x; r2y];
        r = r1-r2;

        for i = 1:(antal_noderUpper)
            Noder_Upper(:, i);
            r;
            ny_nod = Noder_Upper(:, i+1) + r;
            Noder_Lower(:, end+1) = ny_nod;
        end

        for i = 1:(antal_noderUpper)
            %nyss ändrat
            Noder(:, end+1) = Noder_Upper(:, i);
            Noder(:, end+1) = Noder_Lower(:, i);
        end
        Noder(:, end+1) = Noder_Upper(:, end);
    else
        delta_x = (slut_nod(1)-start_nodLower(1))/antal_noderLower;
        delta_y = (slut_nod(2)-start_nodLower(2))/antal_noderLower;
        x0 = start_nodLower(1);
        y0 = start_nodLower(2);
        for i = 1:antal_noderLower
            x1 = x0 + delta_x;
            x0 = x1;

            y1 = y0 + delta_y;
            y0 = y1;

            Noder_Lower(1,end+1) = x1;
            Noder_Lower(2,end) = y1;
        end

        %r1 är kranens riktningsvektor
        r1 = 1/2*[delta_x; delta_y];
        r2x = sqrt(power(c, 2)/(1+power((delta_x/delta_y), 2)));
        r2y = -1*(delta_x/delta_y)*r2x;
        r2 = [r2x; r2y];
        r = r1+r2;

        for i = 1:(antal_noderLower)
            ny_nod = Noder_Lower(:, i) + r;
            Noder_Upper(:, end+1) = ny_nod;
        end

        for i = 1:(antal_noderLower+1)
            Noder(:, end+1) = Noder_Upper(:, i);
            Noder(:, end+1) = Noder_Lower(:, i);
        end

    end

    %Returnerar noderna i en matris
    ret = Noder;

end

function ret = skapaBalkar(noder)
    n = length(noder);
    is_slut_nod_upper = mod(n,2) == 1;

    if is_slut_nod_upper
        bars = [1 3; 2 3; 2 4];
        for i = 3:(n-2)

                bars(end+1, :) = [i i+1];
                bars(end+1, :) = [i i+2];

        end
        bars(end+1, :) = [n n-1];
    else
        bars = [1 3];
        for i = 2:(n-2)
            bars(end+1, :) = [i i+1];
            bars(end+1, :) = [i i+2];
        end

        bars(end+1, :) = [n-1 n];

    end
    ret = bars;
end

function fackverksplot(xnod,ynod,bars)



% fackverksplot(xnod,ynod,bars) ritar upp fackverket med noder i
% (xnod,ynod) och stanger mellan nod-index givna i bars.

for k=1:size(bars,1)
    plot(xnod(bars(k,1:2)),ynod(bars(k,1:2)),'b'); hold on
end
axis equal
plot(xnod,ynod,'*')
fill([0;0; -0.1;-0.1],[1.1;-0.1;-0.1;1.1],'g')
hold off

end

function A=genstiffnmatr(xnod,ynod,bars)
%Labb 1 SF1694

C=1e4; %Styvhetskonstant

%Assemblering av styvhetsmatrisen A
A=zeros(2*length(xnod),2*length(xnod));
%A=spalloc(2*length(xnod),2*length(xnod),40*length(xnod));
for i=1:length(xnod)
    for j=1:length(xnod)
        %Kontroll om det finns stang mellan (x_i,y_i) och (x_j,y_j)
        flag=0;
        for k=1:size(bars,1)
            if isequal([i,j],bars(k,:)) || isequal([j,i],bars(k,:))
                flag=1;
            end
        end
        if flag==1   %Om det finns stang mellan (x_i,y_i) och (x_j,y_j)
            S=length(xnod);
            A(i,i)=A(i,i)+K(i,j,0);
            A(i,j)=A(i,j)+L(i,j,0);
            A(i,i+S)=A(i,i+S)+M(i,j,0);
            A(i,j+S)=A(i,j+S)+N(i,j,0);
            A(i+S,i)=A(i+S,i)+K(i,j,1);
            A(i+S,j)=A(i+S,j)+L(i,j,1);
            A(i+S,i+S)=A(i+S,i+S)+M(i,j,1);
            A(i+S,j+S)=A(i+S,j+S)+N(i,j,1);
        end
    end
end


%Tar bort rader och kolumner som motvarar de tva forsta noderna, som sitter
%fast i vaggen:

A=A([3:length(xnod) length(xnod)+3:2*length(xnod)], [3:length(xnod) length(xnod)+3:2*length(xnod)]);


function coeff=K(i,j,dim) %i, j=nodindex. dim=0 motsv x, dim=1 motsv y.
x1=xnod(i);
y1=ynod(i);
x2=xnod(j);
y2=ynod(j);

Len=sqrt((x1-x2)^2+(y1-y2)^2);
if dim==0
    coeff=C/Len^3*(x1-x2)^2;
else
    coeff=C/Len^3*(x1-x2)*(y1-y2);
end
end

function coeff=L(i,j,dim) %i, j=nodindex. dim=0 motsv x, dim=1 motsv y.
x1=xnod(i);
y1=ynod(i);
x2=xnod(j);
y2=ynod(j);

Len=sqrt((x1-x2)^2+(y1-y2)^2);
if dim==0
    coeff=-C/Len^3*(x1-x2)^2;
else
    coeff=-C/Len^3*(x1-x2)*(y1-y2);
end

end

function coeff=M(i,j,dim) %i, j=nodindex. dim=0 motsv x, dim=1 motsv y.
x1=xnod(i);
y1=ynod(i);
x2=xnod(j);
y2=ynod(j);

Len=sqrt((x1-x2)^2+(y1-y2)^2);
if dim==0
    coeff=C/Len^3*(x1-x2)*(y1-y2);
else
    coeff=C/Len^3*(y1-y2)^2;
end
end

function coeff=N(i,j,dim) %i, j=nodindex. dim=0 motsv x, dim=1 motsv y.
x1=xnod(i);
y1=ynod(i);
x2=xnod(j);
y2=ynod(j);

Len=sqrt((x1-x2)^2+(y1-y2)^2);
if dim==0
    coeff=-C/Len^3*(x1-x2)*(y1-y2);
else
    coeff=-C/Len^3*(y1-y2)^2;
end

end

end











Noder = skapaFackverk(start_nodUpper, start_nodLower, slut_nod, antal_noder, d);

bars = skapaBalkar(Noder);

A = genstiffnmatr(Noder(1, 1:end), Noder(2, 1:end), bars);

b = zeros(1, (2*(length(Noder)-2)))';

b(end) = kraft;

z = A\b;

n_free_nodes = length(Noder) - 2;
z_x = z(1: n_free_nodes);
z_y = z(n_free_nodes+1: end);

NyaNoder = Noder;

for i = 3:length(NyaNoder)
    NyaNoder(1, i) = NyaNoder(1, i) + z_x(i-2);
    NyaNoder(2, i) = NyaNoder(2, i) + z_y(i-2);
end

fackverksplot(Noder(1, :), Noder(2, :), bars);

hold on;

axis equal;

fackverksplot(NyaNoder(1, :), NyaNoder(2, :), bars);

hold off;


%uppgift 2

cond1 = cond(A);

disp("KONDITIONSTAL:")
disp(cond1)
