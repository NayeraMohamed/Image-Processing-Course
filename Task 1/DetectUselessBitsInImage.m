function [B] = DetectUselessBitsInImage(I)
%convert image to grey scale
I = rgb2gray(I);

%initialize array holding sum counters with 0s
bitSum = zeros(8,1);

% loop over all rows and columns
for i = 1:size(I, 1) %rows
    for j = 1:size(I, 2) %columns
        % get pixel value
        pixel = I(i,j);
          % and pixel value with bit mask
          for x = 1:8
              bitMask = power(2, x - 1);
              if bitand(pixel, bitMask) > 0
              bitSum(x)= bitSum(x) + 1;
              end
          end
    end
end

%add to the array if bit plane < 10% of image pixels (rows * cols)
tenPercentOfImage = 0.1 * size(I, 1) * size(I, 2);
B = zeros(8, 1); %1D array of size 8 (max bit size) initialized with zeroes
count = 0;
%loop on the sum counters' array to check for useless bits
for i=1:8
    if(bitSum(i) < tenPercentOfImage)
        B(count + 1) = i;
        count = count + 1;
    end
end

B = B(1:count); %remove extra zeroes from array
end