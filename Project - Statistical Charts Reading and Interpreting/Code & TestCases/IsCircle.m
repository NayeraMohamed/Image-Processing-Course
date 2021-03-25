function [N] = IsCircle(I)
d = I;
for row=1:size(I,1)
    for col=1:size(I,2)
        d(row,col,:)=255-I(row,col,:);
    end
end
d = im2bw(d,0.1);
 %to fill the gaps between circle
se=strel('disk',8);
d = imdilate(d,se);
d = imerode(d,se);

%to extract the circle only
se=strel('disk',70);
d = imerode(d,se);
d = imdilate(d,se);

%get number of connected components, if 1 then it is a circle
%else bar
[~, N] = bwlabel(d);
end
