function [colors,uniqueC] = SegmentLegendColor(colorImage)
d=colorImage;

 d = im2bw(d,0.1);

 r = regionprops(d,'BoundingBox');
 dMatrix = vertcat(r(:).BoundingBox);
 %height
 hig = min(dMatrix(:,3));

 %width
 wid = min(dMatrix(:,4));

se=strel('rectangle',[wid-4,hig-4]);
d = imerode(d,se);

d= uint8(d);
colorImage = uint8(colorImage);
d= d.*colorImage;

colors = zeros(1,30);
sizeColors = size(colors,2)/3;
uniqueC=0;
x=1; y=1;
for row=1:size(d,1)
    for col=1:size(d,2)
  
            if ((d(row,col,1) == 0) && (d(row,col,2) ==  0) && (d(row,col,3) ==  0))
                continue;
            elseif ((d(row,col,1) == 255) && (d(row,col,2) ==  255) && (d(row,col,3) ==  255))
                continue
            end
            red = 1;
            green = 2;
            blue = 3;
            flag=0;
            
            for c=1:sizeColors
                    
                if (colors(red)==0 && colors(green)==0 && colors(blue)==0)
                    break;
                
                elseif(d(row,col,1) == colors(red)) && (d(row,col,2) == colors(green)) && (d(row,col,3) == colors(blue))
                    flag =1;
                    break;
                else
                red = red+3;
                blue = blue+3;
                green= green+3;
                
                end
            end
            if flag == 0
                if row-x >= 10 || col-y>=10
                colors(red)=d(row,col,1);
                colors(green)=d(row,col,2);
                colors(blue)=d(row,col,3);
                uniqueC=uniqueC+1;
                x = row; y = col;
                end     
            end
    end
end
end