I = imread('Moon.bmp');
figure, imshow(I), title('Before Filter');
%convert image to grey scale
%I = rgb2gray(I);
%M = MeanMask(13, 5);
%M = Gauss2(4);
M = LaplacianSharp();
%M = Sobel('H');
%M = Sobel('V');
%Out = EdgeMagnit(I);

Out = uint8(LinearFilter(I, M, '')); %absolute | cutoff
figure, imshow(Out), title('Filter Applied');