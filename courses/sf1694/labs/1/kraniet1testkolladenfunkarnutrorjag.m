clear all;
format long;
start_nodUpper = [0;1];
start_nodLower = [0; 0.8];
slut_nod = [1; 0.5];
antal_noder = 10;
d = 0.2; %avståndet mellan startnoderna

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
       kranvinkel = atan((slut_nod(1)-start_nodLower(1))/(slut_nod(2)-start_nodLower(2)));
    end

    %Räknar ut längden på de tvärgående balkarna
    balk_length_a = sqrt(power(d, 2) + power(balk_length_b/2, 2));

    %Räknar ut vinkeln på balkarna
    theta = atan(balk_length_b/(2*d));
    
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

        v = pi - (kranvinkel + theta);
        delta_x = balk_length_a.*sin(v);
        delta_y = balk_length_a.*cos(v);

        for i = 1:(antal_noderUpper-1)
            ny_nod_x = Noder_Upper(1, i+1) + delta_x;
            ny_nod_y = Noder_Upper(2, i+1) + delta_y;
            Noder_Lower(1, end+1) = ny_nod_x;
            Noder_Lower(2, end) = ny_nod_y;
        end

        for i = 1:(antal_noderUpper)
            Noder(1, end+1) = Noder_Lower(1, i);
            Noder(2, end) = Noder_Lower(2, i);
            Noder(1, end+1) = Noder_Upper(1, i);
            Noder(2, end) = Noder_Upper(2, i);
        end
        Noder(1, end+1) = Noder_Upper(1, end);
        Noder(2, end) = Noder_Upper(2, end);
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

        v = -1*(theta + kranvinkel);
        delta_x = balk_length_a*sin(v);
        delta_y = balk_length_a*cos(v);

        for i = 1:(antal_noderLower)
            ny_nod_x = Noder_Lower(1, i) + delta_x;
            ny_nod_y = Noder_Lower(2, i) + delta_y;
            Noder_Upper(1, end+1) = ny_nod_x;
            Noder_Upper(2, end) = ny_nod_y;
        end

        for i = 1:(antal_noderLower+1)
            Noder(1, end+1) = Noder_Upper(1, i);
            Noder(2, end) = Noder_Upper(2, i);
            Noder(1, end+1) = Noder_Lower(1, i);
            Noder(2, end) = Noder_Lower(2, i);
        end

        Noder(1, end+1) = Noder_Lower(1, end);
        Noder(2, end) = Noder_Lower(2, end);
    
    end
    
    %Returnerar noderna i en matris
    ret = Noder;
    
end

Noder = skapaFackverk(start_nodUpper, start_nodLower, slut_nod, antal_noder, d);
plot(Noder(1, :), Noder(2, :), "*")
hold on;
axis equal;
hold off;


