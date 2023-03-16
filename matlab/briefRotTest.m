% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
im = im2gray(imread("../data/cv_cover.jpg"));


%% Compute the features and descriptors
countFast = [];
countSurf = [];

fastFeat = detectFASTFeatures(im);
surfFeat = detectSURFFeatures(im);
[descFast, locsFast] = computeBrief(im, fastFeat.Location);
[descSurf, locsSurf] = extractFeatures(im, surfFeat.Location, 'Method', 'SURF');

for i = 0:36
    %% Rotate image
    im_rot = imrotate(im, i*10);
    

    %% Compute features and descriptors
    fastFeatRot = detectFASTFeatures(im_rot);
    surfFeatRot = detectSURFFeatures(im_rot);
    [descFastRot, locsFastRot] = computeBrief(im_rot, fastFeatRot.Location);
    [descSurfRot, locsSurfRot] = extractFeatures(im_rot, surfFeatRot.Location, 'Method', 'SURF');


    %% Match features
    fastPairs = matchFeatures(descFast, descFastRot, 'MatchThreshold', 10.0, 'MaxRatio', 0.67); 
    surfPairs = matchFeatures(descSurf, descSurfRot, 'MatchThreshold', 10.0);
    
    if(i == 5 || i == 10 || i == 15)
        matchesFastRot = locsFastRot(fastPairs(:, 2), :); % rot image
        matchesFast = locsFast(fastPairs(:, 1), :); % og image
        matchesSurfRot = locsSurfRot(surfPairs(:, 2), :); % rot image
        matchesSurf = locsSurf(surfPairs(:, 1), :); % og image

        figure('Name', strcat('Fast ', int2str(i)))
        showMatchedFeatures(im, im_rot, matchesFast, matchesFastRot, 'montage');
        
        figure('Name', strcat('Surf ', int2str(i)))
        showMatchedFeatures(im, im_rot, matchesSurf, matchesSurfRot, 'montage');
    end

    %% Update histogram
    countFast = [countFast, size(fastPairs(:, 1), 1)];
    countSurf = [countSurf, size(surfPairs(:, 1), 1)];

end

%% Display histogram
figure('Name', 'Fast Historgram')
bar(countFast)
figure('Name', 'Surf Historgram')
bar(countSurf)

