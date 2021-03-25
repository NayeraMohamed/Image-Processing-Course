function [percentage] = AnalyseHistogram(I)  
R=I;
BW = im2bw(R,0.95);

%Reverse, erode then dilate to segment the bars and circle alone
BW=~(BW);
se=strel('square',30);
d = imerode(BW,se);
d = imdilate(d,se);
bars = d ; 

%%% extracting Y-axis and bars heights  %%%

  % gettting height of each bar
  [x, n] = bwlabel(bars);
  stats1 = regionprops (x, 'BoundingBox');
  heights = [] ;
 
  for i = 1 : n
    boundingBox = stats1(i).BoundingBox;
    heights(i) = boundingBox(4) ;
  end

 % vertical edge detection for detecting y -axis
 I = BW;
 I = edge(I,'Prewitt','vertical');
  
 I = bwareaopen(I,200);
 I = imfill(I, 'holes');

 % getting largest vert. edge (Y axis)
 [x, n] = bwlabel(I);
 stats1 = regionprops (x, 'BoundingBox' );
 BB = stats1(1).BoundingBox;
 yAxis = BB(4);

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % using Bounding box of Y axis -> get the highest value on y axis
  boundingBox = BB ;
  boundingBox(1) =  boundingBox(1) - 50 ;
  boundingBox(2) =  boundingBox(2) - 10 ;
  boundingBox(3) =  boundingBox(3) + (13* boundingBox(3)) ;
  boundingBox(4) =  boundingBox(4) - (0.9 * boundingBox(4)) ;

  subImage = imcrop(R ,boundingBox);

  txt = ocr (subImage  ,'CharacterSet' , '0123456789', 'TextLayout','word' );
  words = {txt(:).Text};
  words = deblank(words);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % calculate the percentage of each bar with respect to y-axis  
  yMax = str2double(words) %from OCR 
  
 for j =1 : size(heights, 2) % # of bars  
     percentage(j) =( heights(j)*yMax )/yAxis ; 
     percentage(j)=  round (percentage(j), 0 ) ;
 end
end
