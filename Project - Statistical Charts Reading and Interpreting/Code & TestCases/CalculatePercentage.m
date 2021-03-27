function [p]= CalculatePercentage(colors,uniqueC,circle)
%circle = imread('11.png');
sizeColors = size(colors,2)/3;
countColors = zeros(1,10);
p=zeros(1,uniqueC);
totalColors=0;
for row=1:size(circle,1)
    for col=1:size(circle,2)
        
         red = 1;
            green = 2;
            blue = 3;
            
            
            for c=1:uniqueC
                if(circle(row,col,1)==colors(red)& circle(row,col,2)==colors(green) &circle(row,col,3)==colors(blue))
                    countColors(c) =  countColors(c) +1;
                    totalColors = totalColors + 1;
                    break;
            end
                red = red + 3;
                green = green +3;
                blue = blue + 3;
                
            end
    end
end

%Percentage calculations...
for e=1:uniqueC
    p(e)=countColors(e)/totalColors*100;

end
disp(p);
end