function ColouredBelongingImage = PlotAllChannels(ImageRGB, BelongingImage, EllipsoidsTitles, EllipsoidsRGBs, FigureTitle)

if nargin < 3
  EllipsoidsTitles = [];
  EllipsoidsRGBs = [];
  FigureTitle = [];
end

if isempty(EllipsoidsTitles)
  FunctionLocalPath = 'matlab/src/algorithms/colourcategorisation/PlotAllChannels';
  FunctionPath = mfilename('fullpath');
  EllipsoidDicMatPath = strrep(FunctionPath, FunctionLocalPath, 'matlab/data/mats/EllipsoidDic.mat');
  EllipsoidDicMat = load(EllipsoidDicMatPath);
  ncolours = size(BelongingImage, 3);
  for i = 1:ncolours
    EllipsoidsTitles{1, i} = EllipsoidDicMat.EllipsoidDic{1, i};
  end
end

if isempty(EllipsoidsRGBs)
  ncolours = size(EllipsoidsTitles, 2);
  EllipsoidsRGBs = zeros(ncolours, 3);
  for i = 1:ncolours
    EllipsoidsRGBs(i, :) = name2rgb(EllipsoidsTitles{i});
  end
end

if isempty(FigureTitle)
  FigureTitle = 'Colour Categorisation';
end

titles = EllipsoidsTitles;
figure('NumberTitle', 'Off', 'Name', FigureTitle);
subplot(4, 4, 1.5);
imshow(ImageRGB);
title('Org');
subplot(4, 4, 3.5);
ColouredBelongingImage = ColourBelongingImage(BelongingImage, EllipsoidsRGBs);
imshow(ColouredBelongingImage);
title('Max');

[~, ~, nelpisd] = size(BelongingImage);
for i = 1:nelpisd
  PlotIndex = i + 4;
  if PlotIndex > 12
    PlotIndex = PlotIndex + 0.5;
  end
  subplot(4, 4, PlotIndex);
  imshow(BelongingImage(:, :, i), []);
  title(titles{i});
end

end

function ColouredBelongingImage = ColourBelongingImage(BelongingImage, EllipsoidsRGBs)

[~, ~, chns] = size(BelongingImage);

[vals, inds] = max(BelongingImage(:, :, 1:chns), [], 3);
% if the maximum value is 0 it means neither of the colours did categorise
% this pixel.
inds(vals == 0) = 11;

ColouredBelongingImage = ColourLabelImage(inds, EllipsoidsRGBs);

end