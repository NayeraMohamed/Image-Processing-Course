function [Icropped] = SegmentLegend(I)
R = I;
BW = im2bw(R,0.95);

%Reverse, erode then dilate to segment the bars and circle alone
BW=~(BW);
se=strel('square',30);
  d = imerode(BW,se);
  d = imdilate(d,se);
  
%Re-reverse (to have a black shape) => then loop and whiten this black shape from Original img  
d=~(d);
  for i=1:size(d,1)
      for j=1:size(d,2)
          if d(i,j)==0 || i==1 || j==1 || i==size(d,1) || j==size(d,2)
              R(i,j,1)=255;
              R(i,j,2)=255;
              R(i,j,3)=255;
          end
      end
  end

d=im2bw(R,0.7);
% Detect black line
BW = d < 1;

% Detect rectangle region (inside the line)
BW = imclearborder(~BW);

%Discard small white splatters
BW = bwareafilt(BW,1);
% Calculate bounding box
s = regionprops(BW,'BoundingBox');

% Crop the bounded box from the original image
Icropped = imcrop(I,s.BoundingBox);
end
