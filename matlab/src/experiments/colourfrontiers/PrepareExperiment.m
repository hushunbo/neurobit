minim_D65 = [0.001; 0.003; 0.005];
MondrianParameters.SquareNumber = 600;
MondrianParameters.MeanSize = 80;
MondrianParameters.ColorNumber = 36;
MondrianParameters.NameableRate = 0; % this parameter is useless
MondrianParameters.Id_ColourList = [0, 1, 0]; % indicates the list to read
ExperimentParameters.Mondrian3D = 1;
OriginalMondrianPage = 1;
labplane1 = 36;
labplane2 = 58;
labplane3 = 81;
fastsampling = 5;
numfrontiers = 19;
frame_name = 1;
Black_palette_name = 2;
shadow_name = 2;
Central_patch_name = 3;
joystickdelay = 0.05;
textposition_x = 75;
textposition_y = 30;
White_CIE1931 = crsSpaceToSpace(CRS.CS_RGB, [1, 1, 1], CRS.CS_CIE1931, 0);
D65_XYZ = whitepoint('d65') ./ max(whitepoint('d65')) .* White_CIE1931(3);
refillum = D65_XYZ;
D65_RGB = crsSpaceToSpace(CRS.CS_CIE1931, XYZ2xyLum(D65_XYZ), CRS.CS_RGB, 0);
condition_elapsedtime = 0;
% condition_starttime = 0;
plotresults = 1;
answer = {};
currentrun = 0;
blackpalette = repmat(minim_D65,1,256); % This was actually measured!  %junkpalette;
junkpalette = blackpalette;
junkpalette(:, 256) = [256; 256; 256];
% conditions = [];
rawtimes = [];
rawcolours = [];