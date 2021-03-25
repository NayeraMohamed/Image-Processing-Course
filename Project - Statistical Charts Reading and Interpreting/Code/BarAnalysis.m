close all; 

p21 = 'E:\collage\4th year\1st term\IP\Lab 7- Projects & Practical problems\Projects\4 Statistical Charts Reading and Interpreting\Test Cases\Case 2\1.png';
p22 = 'E:\collage\4th year\1st term\IP\Lab 7- Projects & Practical problems\Projects\4 Statistical Charts Reading and Interpreting\Test Cases\Case 2\2.jpg';
p42 = 'E:\collage\4th year\1st term\IP\Lab 7- Projects & Practical problems\Projects\4 Statistical Charts Reading and Interpreting\Test Cases\Case 4\2.png';
p41 = 'E:\collage\4th year\1st term\IP\Lab 7- Projects & Practical problems\Projects\4 Statistical Charts Reading and Interpreting\Test Cases\Case 4\1.jpg';
p8 ='E:\collage\4th year\1st term\IP\Lab 7- Projects & Practical problems\Projects\4 Statistical Charts Reading and Interpreting\Test Cases\Bonuses\Case 8\1.JPG';

I = imread(p21);

%I = imread('1.2.jpg');
R=I;
figure,imshow(R);

% making sure the background is white 
for i=1:size(R,1)
      for j=1:size(R,2)
          if ((R(i,j,1)>=150 && R(i,j,1)<=200) && (R(i,j,2)>=200 && R(i,j,2)<=255) &&(R(i,j,3)>=200 && R(i,j,3)<=255))
               R(i,j,1)=255;
               R(i,j,2)=255;
               R(i,j,3)=255;
          end
      end
  end
%figure,imshow(R);

% Thresholding 
BW = im2bw(R,0.95);
%figure,imshow(BW);

%Reverse, erode then dilate to segment the bars and circle alone
BW=~(BW);
se=strel('square',30);
d = imerode(BW,se);
d = imdilate(d,se);
figure,imshow(d);
bars = d ; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% extracting Y-axis and bars hights  %%%%%%%%%%%%%%%%%%%%%

  % gettting hight of each bar
  [x, n] = bwlabel(bars);
  stats1 = regionprops (x, 'BoundingBox');
  hights = [] ;
 
  for i = 1 : n
    boundingBox = stats1(i).BoundingBox;
    hights(i) = boundingBox(4) ;
  
  end

  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % vertical edge detection for detecting y -axis
 I = BW;
 I = edge(I,'Prewitt','vertical');
 %figure,imshow( I);
  
 I = bwareaopen(I,200);
 I = imfill(I, 'holes');
 %figure,imshow( I);

 % gitting largest vert. edge (Y axis )
 [x, n] = bwlabel(I);
 stats1 = regionprops (x, 'BoundingBox' );
 BB = stats1(1).BoundingBox;
 yAxis = BB(4);
   
    


 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % using Bounding box of Y axis -> get the highest value of y axis
 
  %*************************************************************
  % boundingBox = [xLeft, yTop, width, height] ;
  boundingBox = BB ;
  boundingBox(1) =  boundingBox(1) - 50 ;
  boundingBox(2) =  boundingBox(2) - 10 ;
  boundingBox(3) =  boundingBox(3) + (13* boundingBox(3)) ;
  boundingBox(4) =  boundingBox(4) - (0.9 * boundingBox(4)) ;

  subImage = imcrop(R ,boundingBox);
  figure,imshow(subImage);


  txt = ocr (subImage  ,'CharacterSet' , '0123456789', 'TextLayout','word' );
  words = {txt(:).Text};
  words = deblank(words);
  display (words);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % calculate the percentage of each bar with respect to y-axis  
  yMax = str2double(words) %from OCR 

  
 for j =1 : size(hights ,2) % # of bars  
     percentage(j) =( hights(j)*yMax )/yAxis ; 
     percentage(j)=  round ( percentage(j) , 0 ) ;
 end
 disp (percentage);
