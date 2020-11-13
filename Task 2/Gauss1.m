function M = Gauss1(Size,Sig)
%GAUSS1 Generates a 3x3 Gaussian Filter using sigma and given size
l = -(Size/2);
tmp= l;
r = l;
sum=0;

%Fill the mask values using the sigma
for i = 1:Size
    for j = 1:Size
        M(i,j) = (1/((2*pi)*(Sig*Sig)))* exp(-((l*l)+(r*r)) / (2 * Sig* Sig));
        r=r+1;
        sum=sum+M(i,j);
    end
    l=l+1;
    r=tmp;
end
M= M*(1/sum);
end

