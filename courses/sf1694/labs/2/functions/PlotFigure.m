% Den har funktionen ritar upp en figur pa
% skarmen givet ett antal sammanhangande punkter
% Punkterna ska vara lagrade i en vektor X dar 
% X(1,:) innehaller x-vardena och X(2,:) innehaller 
% motsvarande y-varden.

function PlotFigure(X);
X(:,end+1) = X(:,1);

% Interpolera med splines for jamnare konturer
% [m,n]=size(X);
% t = 1:n;
% ts = 1: 0.1: n;
% xs = spline(t,X(1,:),ts);
% ys = spline(t,X(2,:),ts); 

xs=X(1,:);
ys=X(2,:);
h=fill(xs,ys,1/255*[216 41 0]);
set(h,'edgecolor',1/255*[216 41 0]);
hold on
plot(xs,ys,'Color',1/255*[0 153 153],'LineWidth',2);

% Fixera skalan pa axlarna. Använd helst samma skala for ursprunglig figure och
% transformerad figur. 

xmax=max(X(1,:));xmin=min(X(1,:));ymax=max(X(2,:));ymin=min(X(2,:));
maxx=30;
if xmax>maxx || xmin<-maxx || ymax>maxx || ymin<-maxx 
    axis([xmin-0.1*abs(xmin) xmax+0.1*abs(xmax) ymin-0.1*abs(ymin) ymax+0.1*abs(ymax)])
else
    axis([-maxx maxx -maxx maxx])
end
axis square
grid on
hold off

