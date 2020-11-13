%I = imread('I.bmp');
%M = MeanMask(3, 5);
%M = Gauss1(Size,Sig);
%M = Gauss2(Sig);
%M = LaplacianSharp();
%M = Sobel('H');
%M = Sobel('V');
%G = EdgeMagnit(I);

%Out = uint8(LinearFilter(I, M, Postproc));
%figure, imshow(Out), title('Filter Applied');