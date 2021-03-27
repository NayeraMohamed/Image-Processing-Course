function [M] = AnalyzeCircle(I, uniqueColors, uniqueC)

total=0;
colorsCounter=zeros(1,6);
samples=zeros(1,18);

R=im2bw(uint8(I),0.9);
[r,c,z]=size(R);
R=imdilate(R,ones(5,5));
%figure, imshow(I), title('BW');
e= edge(uint8(R),'canny');
%figure, imshow(e), title('edge');
e2= imdilate(e,ones(3,3));
%figure, imshow(e2), title('edge2');
e2 =~e2;
[L, num]=bwlabel(e2);
rgb= label2rgb(L);
%figure, imshow(rgb), title('rgbL');
ratio= r*c*0.001;

counter=0; 
for i=1:num
    this=0;
    x = uint8(L==i);
    f = sum(sum(x==1));
    if(f < ratio)
        continue;
    end
    segment = zeros(size(I));
    segment(:,:,1) = uint8(x).*uint8(I(:,:,1));
    segment(:,:,2) = uint8(x).*uint8(I(:,:,2));
    segment(:,:,3) = uint8(x).*uint8(I(:,:,3));
    if i==1
        continue;
    end
    counter=counter+1;
    %figure,imshow(uint8(segment)),title("Segment");

    for row=1:r
        for col=1:c
            
          if ((segment(row,col,1) == 0) & (segment(row,col,2) == 0) & (segment(row,col,3) == 0))
              continue;
          elseif ((segment(row,col,1) == 255) & (segment(row,col,2) == 255) & (segment(row,col,3) == 255))       
              continue; 
          else 
                this=this+1;
                total=total+1;
                index=(counter-1)*3;
                samples(1,index+1)=segment(row,col,1);
                samples(1,index+2)=segment(row,col,2);
                samples(1,index+3)=segment(row,col,3);
          end      
        end
    end
    %uniqueC=uniqueC+1;
    colorsCounter(counter)=this;  
end

%If the pie chart can not be edge segmented.................
if colorsCounter(2)==0
M= CalculatePercentage(uniqueColors,uniqueC,I);
else
p=zeros(1,6);
for k=1:uniqueC
    p(k)=(colorsCounter(k)/total)*100;  
end
M = MapToLegend(uniqueColors,samples,p,uniqueC);
end
end