

%Threshold to increase intensity of black 
text = im2bw(text,0.5);

%dilate text to view each text as one connected component
text = ~text;
se=strel('rectangle', [9,23]);
inverse = imdilate(text,se);
%get connected components in image
[L, n] = bwlabel(inverse);
s = regionprops (L, 'BoundingBox');

%remove vertical borders found in image
h = s(1).BoundingBox(4); %height of vertical border found in image
se = strel('line', h, 90);
sub = imerode(inverse, se);
i = inverse - sub;

%restore any changes that happened to text
se = strel('rectangle', [10,1]); 
i = imdilate(i, se);

%%get connected components (all text found) in image
[L, n] = bwlabel(i);
s = regionprops (L, 'BoundingBox');
s = s(2:end); %remove first BB, to remove background and save the text only

%arrange bounding boxes according to their x and y coordinates
%to preserve original text order
M = containers.Map('KeyType','double','ValueType','double');
  for i = 1 : n - 1
    boundingBox = s(i).BoundingBox;
    x  = boundingBox(1);
    y = boundingBox(2);
    M(x + y) = i; 
  end
  
 %loop on the ordered map to display each text with its corresponding
 %result that is calculated before
 k = M.keys();
 for i = 1:length(M)
     text = M(k{i});
     boundingBox = s(text).BoundingBox;
     Icropped = imcrop(Image, boundingBox);
     position =  [0, 0];
     value = percentages(i);
     Icropped = insertText(Icropped, position, value,'AnchorPoint','LeftTop', 'FontSize', 18);
     Icropped = imresize(Icropped,2);

     figure, imshow(Icropped);
     %Icropped = imresize(Icropped,2);

 end
end
