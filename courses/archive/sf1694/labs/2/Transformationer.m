clear, close all;
addpath("data");
load BatMan.mat X;
X_2 = X;

%./functions är en mapp som innehåller alla externa funktioner
addpath("functions");


ALTERNATIV = ["1", "2", "3", "4", "5"];
while 1
    % Ta input från användaren
    disp("Programmet kan genomföra följande:");
    disp(ALTERNATIV(1) + ": rotation");
    disp(ALTERNATIV(2) + ": spegling kring linje");
    disp(ALTERNATIV(3) + ": skuvning");
    disp(ALTERNATIV(4) + ": skuvning och rotation");
    disp(ALTERNATIV(5) + ": avsluta programmet");
    
    
    % hämta alternativet från användaren, och be den försöka igen om det inte
    % är ett alternativ
    while 1
        mode = input("Välj vad du vill göra: ", "s");
        if ismember(mode, ALTERNATIV)
            disp("")
            break
        else
            disp("Inte ett giltigt alternativ, försök igen!");
        end
    
    end
    
    
    switch mode
        case ALTERNATIV(1)
            theta = input("Ange rotationsvinkel (grader): ");
            R = rotation(theta);
            X_2 = R*X_2;
    
        case ALTERNATIV(2)
            a = input("Riktingskoefficient för linjen: ");
            b = input("Skärning av y-axeln för linjen: ");
            M = mirror(a, b);
            X_2 = M*X_2;
    
        case ALTERNATIV(3)
            shear_factor = input("Ange skuvningsfaktor: ");
            S = shear(shear_factor);
            X_2 = S*X_2;
    
        case ALTERNATIV(4)
            shear_factor = input("Ange skuvningsfaktor: ");
            theta = input("Ange rotationsvinkel (grader): ");
            S = shear(shear_factor);
            R = rotation(theta);
            T = R*S;
            X_2 = T*X_2;
    
        case ALTERNATIV(5)
            break;
    end
    figure;
    subplot(1, 2, 1);
    PlotFigure(X);
    title("Original");


    subplot(1,2,2);
    PlotFigure(X_2);
    title("Transformerad");
    disp("---------------------------------")
    disp("")
end