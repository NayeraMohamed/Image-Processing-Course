%initial commit
function Out = LinearFilter(I, Filter, Postproc) 
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

I= imread("Filters.png");
g = rgb2gray(I);
[iRows,iCols,z]= size(g);

%padding
[fRows,fCols] = size(Filter);
rPadding= fix(fRows/2);
cPadding = fix(fCols/2);
newR=iRows+(2*rPadding);
newC= iCols+(2*cPadding);
temp= zeros(newR,newC );
temp(rPadding+1:newR-rPadding,cPadding+1:newC-cPadding)=g;

%convolution
result = zeros(g);

for i = 1:iRows
    for j= 1:iCols
        rSum=0;
        r=i;
        for ii=1:fRows
              c=j;
            for jj=1:fCols
                rSum=rSum+(temp(r,c)*Filter(ii,jj));
                c=c+1;
            end
            r=r+1;
        end
        result(i,j)=rSum;
        
    end
    
end

%cutoff...
if strcmp(Postproc,'cutoff') ==1
    
for i = 1:iRows
   for j= 1:iCols
       if result(i,j)>255
           result(i,j)=255;
       end
       
   end
end
        
   
 %absolute...   
elseif strcmp(Postproc,'absolute')==1
    
 for i = 1:iRows
   for j= 1:iCols
      
           result(i,j)=abs(result(i,j));
       
   end
end
    
    
end

figure, imshow(result), title('Filter Applied');

end
