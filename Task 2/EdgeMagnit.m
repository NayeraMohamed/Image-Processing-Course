function G =  EdgeMagnit(I)
% EdgeMagnit Summary of this function goes here
%   Detailed explanation goes here
X = LinearFilter(I,Sobel('H'),'absolute');
Y = LinearFilter(I,Sobel('V'),'absolute');

[H,W] = size(X);
G = uint8(zeros(H,W));
for i = 1:H
    for j = 1:W
        G(i,j) = X(i,j) + Y(i,j);
        if G(i,j) < 0 
            G(i,j) = 0;
        elseif G(i,j) > 255 
            G(i,j) = 255; 
        end    
    end    
 end


end

