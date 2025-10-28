clear all;
start_nodUpper = [0;1];
start_nodLower = [0; 0.8];
slut_nod = [1; 0.5];
antal_noder = 10;
d = 0.2; %avståndet mellan startnoderna

function ret = skapaFackverk(start_nodUpper, start_nodLower, slut_nod, antal_noder, d)
    antal_noderUpper = ceil(antal_noder/2);
    antal_noderLower = floor(antal_noder/2);

    is_slut_nod_upper = mod(antal_noder,2) == 1;
    Noder_Lower = start_nodLower;
    Noder_Upper = start_nodUpper;
    Noder = [;];

    if (is_slut_nod_upper)
        dist_Upper = slut_nod-start_nodUpper;
        %skriv vidare för om upper har fler noder än lower      
    
    else
        dist_Lower = slut_nod-start_nodLower;
        balk_length_b = norm(dist_Lower)/antal_noderLower;
        balk_length_a = sqrt((balk_length_b/2).^2+d.^2);
        whos balk_length_a balk_length_b
        
        %lutning = (slut_nod(2)-start_nodLower(2))/(slut_nod(1)-start_nodLower(1));
        delta_x = (slut_nod(1)-start_nodLower(1))/antal_noderLower
        delta_y = (slut_nod(2)-start_nodLower(2))/antal_noderLower

        disp("slask")
        
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
        

        %Räknar ut diverse vinklar. Se bild för förtydligande
        %kom ihåg att vi redan är i nedre
        theta = atan(balk_length_b/(2*d))

        kranvinkel = atan((slut_nod(1)-start_nodLower(1))/(slut_nod(2)-start_nodLower(2)))

        v = kranvinkel + theta;
        v = abs(v);

        delta_x = balk_length_a.*sin(v);
        delta_y = balk_length_a.*cos(v);
        for i = 1:(antal_noderLower)
            ny_nod_x = Noder_Lower(1, i) + delta_x;
            ny_nod_y = Noder_Lower(2, i) + delta_y;
            Noder_Upper(1, end+1) = ny_nod_x;
            Noder_Upper(2, end) = ny_nod_y;
        end

        for i = 1:(antal_noderLower+1)
            Noder(1, end+1) = Noder_Lower(1, i);
            Noder(2, end) = Noder_Lower(2, i);
            Noder(1, end+1) = Noder_Upper(1, i);
            Noder(2, end) = Noder_Upper(2, i);
        end
        Noder_Lower
        Noder_Upper
        disp(Noder)

    end
    
    ret = Noder;
    
end

Noder = skapaFackverk(start_nodUpper, start_nodLower, slut_nod, antal_noder, d);
plot(Noder(1, :), Noder(2, :), "*")



