function [man] = ExtractMan(Image1)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[r,c,z]=size(Image1);
man=zeros(r,c,z);
figure,imshow(Image1);
for i=1:r
    for j = 1:c
        if (Image1(i,j,1)>(Image1(i,j,3)) || Image1(i,j,2)>(Image1(i,j,3))||( Image1(i,j,2) + Image1(i,j,1))> (Image1(i,j,3)) )&& Image1(i,j,3)<140
            man(i,j,:)=Image1(i,j,:);
        end
        if Image1(i,j,1)>140 && Image1(i,j,2)>140 && Image1(i,j,3)>140
             man(i,j,:)=Image1(i,j,:);
        end
            
     
    end
end

figure, imshow(uint8(man));
bwMan=im2bw(uint8(man),0.01);
bwMan = medfilt2( bwMan,[4,4]);
figure, imshow(bwMan), title('BW');
e= edge(uint8(bwMan),'canny');
figure, imshow(e), title('edge');
e2= imdilate(e,ones(5,5));
figure, imshow(e2), title('edge2');
e2 =~e2;
[L, num]=bwlabel(e2);
rgb= label2rgb(L);
figure, imshow(rgb), title('rgbL');
ratio= r*c*0.0001;


for i=1:num
    x = uint8(L==i);
    f = sum(sum(x==1));
    if(f < ratio)
        continue;
    end
    man = zeros(size(Image1));
    man(:,:,1) = uint8(x).*Image1(:,:,1);
    man(:,:,2) = uint8(x).*Image1(:,:,2);
    man(:,:,3) = uint8(x).*Image1(:,:,3);

    figure,imshow(uint8(man));
end


end