function M = Gauss2(Sig)
%GAUSS2 Generates a 3x3 Gaussian Filter using sigma and given size
% get the mask size using sigma
N = fix(3.7*Sig) - 0.5;
MaskSize = (N*2) +1;

%use Gauss1 function to generate the filter
M=Gauss1(MaskSize,Sig);
end

