function [uniqueColors, uniqueC, text] = SegmentText(I)
Image = I;
%Resizing image to get clear image of text
Image = imresize(Image,3);
text = Image;

%Convert image to black and white 
BW = im2bw(Image,0.949);

%Get inverse of image to make background black
inverse = abs(1-BW);

%Get colors only from legend
se=strel('square',21);
inverse = imerode(inverse,se);
inverse = imdilate(inverse,se);

%legend colors...............
 colors = uint8(inverse).*uint8(Image);
[uniqueColors,uniqueC]=SegmentLegendColor(colors);

%Get text only without colors by setting colors to white
for i=1:size(inverse,1)
    for j=1:size(inverse,2)
        if inverse(i,j) == 1 
            text(i,j,1) = 255;
            text(i,j,2) = 255;
            text(i,j,3) = 255;
        end       
    end
end

%Threshold to increase intensity of black 
text = im2bw(text,0.5);
end