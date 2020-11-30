function [out] = AddMan(Image2,man)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[r,c,z]= size(man);
man=uint8(man);
for i= 1:r
    for j=1:c
        if man(i,j,:)~=0
            Image2(i,j,:)=man(i,j,:);
        end
    end
end
out = Image2;
figure, imshow(out), title('Man Added');
end