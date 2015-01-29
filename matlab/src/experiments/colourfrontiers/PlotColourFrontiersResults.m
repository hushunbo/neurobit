function labs = PlotColourFrontiersResults(FilePath, condition)
%PlotColourFrontiersResults Summary of this function goes here
%   Detailed explanation goes here

MatFile = load(FilePath);
ExperimentResult = MatFile.ExperimentResults;

angles = ExperimentResult.angles;
radii = ExperimentResult.radii;
luminances = ExperimentResult.luminances;
conditions = ExperimentResult.conditions;
ResultTable = [angles, radii, luminances, conditions'];
ExperimentColours = lower(ExperimentResult.FrontierColours);

if nargin > 1
  FilteredConditions = ResultTable(:, 4) == condition;
  ResultTable = ResultTable(FilteredConditions, :);
  ExperimentColours = ExperimentColours(FilteredConditions, :);
end

nexperiments = size(ResultTable, 1);
labs = zeros(nexperiments, 3);
for i = 1:nexperiments
  labs(i, :) = pol2cart3([ResultTable(i, 1), ResultTable(i, 2), ResultTable(i, 3)], 1);
end

figure('NumberTitle', 'Off', 'Name', ['Colour Frontiers - ', ExperimentResult.type]);
hold on;
grid on;

[CartFocals, ~] = FocalColours();
[UniqueConditions, IndexConditions, ~] = unique(conditions);
for i = UniqueConditions
  ColourA = ExperimentColours{IndexConditions(i), 1};
  colour1 = CartFocals.(ColourA);
  ColourB = ExperimentColours{IndexConditions(i), 2};
  colour2 = CartFocals.(ColourB);
  
  pp = [colour1(1, 1), colour1(1, 2)];
  plot([pp(1), 0], [pp(2), 0], 'r');
  text(pp(1), pp(2), ColourA, 'color', 'r');
  
  pp = [colour2(1, 1), colour2(1, 2)];
  plot([pp(1), 0], [pp(2), 0], 'r');
  text(pp(1), pp(2), ColourB, 'color', 'r');
end

plot(labs(:, 2), labs(:, 3), '*r');

end
