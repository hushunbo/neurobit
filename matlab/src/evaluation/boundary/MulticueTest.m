function MulticueTest(FolderPath, TestName, TypeName, doedge, dothresh)

if nargin < 1
  FolderPath = '/home/arash/Software/Repositories/neurobit/data/dataset/multicue/';
end
if nargin < 2
  TestName = 'tmp';
end
if nargin < 3
  TypeName = 'boundaries';
end
if nargin < 4
  doedge = true;
end
if nargin < 5
  dothresh = true;
end

ImageDirectory = [FolderPath, 'images/'];
ResultDirectory = [FolderPath, 'results/', TypeName, '/', TestName];
if ~exist(ResultDirectory, 'dir')
  mkdir(ResultDirectory);
end

ImageList = dir([ImageDirectory, '*left*.png']);
nfiles = length(ImageList);

tic;
if doedge
  parfor i = 1:nfiles
    disp(['processing ', ImageList(i).name]);
    CurrentFileName = ImageList(i).name;
    ImagePath = [ImageDirectory, '/', CurrentFileName];
    CurrentImage = imread(ImagePath);
    CurrentImage = double(CurrentImage) ./ 255;
    
    if strcmpi(TestName, 'sco')
      EdgeImage = SCOBoundary(CurrentImage, 1.1, 6, -0.7, 5);
    elseif strcmpi(TestName, 'co')
      EdgeImage = SCOBoundary(CurrentImage, 1.1, 6, -0.7, 0);
    elseif strcmpi(TestName, 'canny')
      EdgeImage = pbCannyColour(CurrentImage);
    elseif strcmpi(TestName, 'mci')
      EdgeImage = MCIContour(CurrentImage);
    else
      EdgeImage = SurroundModulationEdgeDetector(CurrentImage);
    end
    
    ResultName = CurrentFileName(1:end-4);
    imwrite(EdgeImage, [ResultDirectory, '/', ResultName, '.png']);
  end
end
toc;

% boundary benchmark for results stored as contour images

GroundtruthDirectory = [FolderPath, 'ground-truth/images/', TypeName];
PlotsDirectory = [FolderPath, 'plot/', TypeName, '/', TestName];
nthresh = 99;

tic;
if dothresh
  if exist(PlotsDirectory, 'dir')
    rmdir(PlotsDirectory, 's');
  end
  mkdir(PlotsDirectory);
  boundaryBench(ImageDirectory, GroundtruthDirectory, ResultDirectory, PlotsDirectory, nthresh);
end
toc;

plot_eval(PlotsDirectory, '-mx', 'isoF.fig');

end