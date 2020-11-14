function Out = LinearFilter(I, Filter, Postproc) 

[iRows,iCols]= size(I);
%padding
[fRows,fCols] = size(Filter);
rPadding= fix(fRows/2);
cPadding = fix(fCols/2);
newR=iRows+(2*rPadding);
newC= iCols+(2*cPadding);
temp= zeros(newR,newC );
temp(rPadding+1:newR-rPadding,cPadding+1:newC-cPadding)=I;
temp= im2double(temp);

%convolution
Out = zeros(iRows,iCols);

for i = 1:iRows
    for j= 1:iCols
        rSum=0;
        r=i;
        for ii=1:fRows
              c=j;
            for jj=1:fCols
                rSum = rSum+(temp(r,c)*Filter(ii,jj));
                c=c+1;
            end
            r=r+1;
        end
        Out(i,j)=rSum;    
    end  
end

%cutoff...
if strcmp(Postproc,'cutoff') ==1
    
for i = 1:iRows
   for j= 1:iCols
       if Out(i,j)>255
           Out(i,j)=255;
       end
       if Out(i,j)<0
           Out(i,j)=0;
       end
   end
end
         
 %absolute...   
elseif strcmp(Postproc,'absolute')==1
    
 for i = 1:iRows
   for j= 1:iCols   
           Out(i,j)=abs(Out(i,j));
   end
 end
end

end