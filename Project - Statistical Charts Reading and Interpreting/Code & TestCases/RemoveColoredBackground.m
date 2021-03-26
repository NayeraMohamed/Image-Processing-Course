function [R] = removeColoredBackground(R)  
for i = 1:size(R, 1)
      for j=1:size(R,2)
          if ((R(i,j,1)>=150 && R(i,j,1)<=200) && (R(i,j,2)>=200 && R(i,j,2)<=255) &&(R(i,j,3)>=200 && R(i,j,3)<=255))
               R(i,j,1)=255;
               R(i,j,2)=255;
               R(i,j,3)=255;
          end
      end
end
end
