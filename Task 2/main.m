%I = imread('I.bmp');
%convert image to grey scale
%I = rgb2gray(I);
%M = MeanMask(3, 11);
%M = Gauss1(Size,Sig);
%M = Gauss2(4);
%M = LaplacianSharp();
%M = Sobel('H');
%M = Sobel('V');
%G = EdgeMagnit(I);

%Out = uint8(LinearFilter(I, M, Postproc));
%figure, imshow(Out), title('Filter Applied');