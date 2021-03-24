I = imread('12.png');
circle = imread('11.png');
%I = im2bw(I,0.9);
d=I;

for row=1:size(I,1)
    for col=1:size(I,2)
        d(row,col,:)=255-I(row,col,:);
    end
end
d = im2bw(d,0.1);
se=strel('square',8);
d = imerode(d,se);
d= uint8(d);
I = uint8(I);
d= d.*I;

figure, imshow(d);
colors = zeros(1,30);
sizeColors = size(colors,2)/3;

%disp(colors);
%colors= ColorInRGB.empty(10);
countColors = zeros(1,10);
totalColors=0;
uniqueC=0;
%M = containers.Map(I(1,1,1),0);
for row=1:size(d,1)
    for col=1:size(d,2)
        %disp(row)
        %disp(col)
       
            if ((d(row,col,1) == 0) & (d(row,col,2) ==  0) & (d(row,col,3) ==  0))
                continue;
            end
            red = 1;
            green = 2;
            blue = 3;
            flag=0;
            index=1;
            
            for c=1:sizeColors
                index=c;
                %if I(row,col,:)==colors[c]
                if (colors(red)==0 & colors(green)==0 & colors(blue)==0)
                    break;
                
                elseif(d(row,col,1) == colors(red)) & (d(row,col,2) == colors(green)) & (d(row,col,3) == colors(blue))
                    %countColors(c)=countColors(c)+1;
                    flag =1;
                    %totalColors= totalColors+1;
%                  disp(red);
%                 disp(green);
%                 disp(blue);
%                 disp('--------------');
                    break;
                else
                red = red+3;
                blue = blue+3;
                green= green+3;
                
                end
            end
            if flag == 0
%                 colorIndex=(index-1)*3;
%                 red=red+colorIndex;
%                 green=green+colorIndex;
%                 blue=blue+colorIndex;
                
                colors(red)=d(row,col,1);
                colors(green)=d(row,col,2);
                colors(blue)=d(row,col,3);
                %countColors(index)=1;
                %totalColors= totalColors+1;
                uniqueC=uniqueC+1;
              
            %end
            %end
            
     end
    end
end

for row=1:size(circle,1)
    for col=1:size(circle,2)
        
         red = 1;
            green = 2;
            blue = 3;
            
            
            for c=1:sizeColors
                if(circle(row,col,1) == colors(red)& circle(row,col,2) == colors(green) & circle(row,col,3) == colors(blue))
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
      disp(totalColors);
      disp('totalColors-----------');
      disp(countColors);
      disp('countColors-----------');
disp(uniqueC);
disp('uniqueC-----------');
disp(colors);
disp('colors-----------');

