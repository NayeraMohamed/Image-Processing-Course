
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
