function [map] = MapToLegend(colors,samples,percentages,uniqueC)
disp("mapping starts here............");
map=zeros(size(percentages));
    red=1;
    green=2;
    blue=3;
for i=1:uniqueC
        r=1;
        g=2;
        b=3;
    difference=255*ones(1,3);
    totalDifference=1000;
    for j=1:uniqueC
        if (abs(colors(r)-samples(red))+abs(colors(g)-samples(green))+abs(colors(b)-samples(blue))<totalDifference)|(abs(colors(r)-samples(red))<=difference(1) &abs(colors(g)-samples(green))<=difference(2)&abs(colors(b)-samples(blue))<=difference(3))
            difference(1)=abs(colors(r)-samples(red));
            difference(2)=abs(colors(g)-samples(green));
            difference(3)=abs(colors(b)-samples(blue));
            totalDifference=abs(colors(r)-samples(red))+abs(colors(g)-samples(green))+abs(colors(b)-samples(blue));
            index=j;
        end
        r=r+3;
        g=g+3;
        b=b+3;
        
    end
    map(index)=percentages(i);
    
    red=red+3;
    green=green+3;
    blue=blue+3;
      
end
end