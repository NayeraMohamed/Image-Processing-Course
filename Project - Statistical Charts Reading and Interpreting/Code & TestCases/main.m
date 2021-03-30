I = imread('1.jpg');
figure, imshow(I);
%other f awl case n2sa
Legend = SegmentLegend(I);
I = RemoveColoredBackground(I);
[uniqueColors, uniqueC, text] = SegmentText(Legend);

circle = IsCircle(I);
if circle == 1
    disp('circle');
    percentages = AnalyzeCircle(I, uniqueColors, uniqueC);

else %histogram
    disp('bar');
    percentages = AnalyseBar(I);
end
DisplayResults(Legend, percentages);
