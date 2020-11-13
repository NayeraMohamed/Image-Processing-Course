function [M] = MeanMask(W, H)
%MeanMask: 2D array of size W x H and all values = 1 (W * H)
M = repmat((1 / (W * H)), [W H]);
end