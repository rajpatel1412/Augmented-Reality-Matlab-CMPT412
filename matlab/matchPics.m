function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
im1 = im2gray(I1);
im2 = im2gray(I2);


%% Detect features in both images
features1 = detectFASTFeatures(im1);
features2 = detectFASTFeatures(im2);


%% Obtain descriptors for the computed feature locations
[desc1, l1] = computeBrief(im1, features1.Location);
[desc2, l2] = computeBrief(im2, features2.Location);


%% Match features using the descriptors
pairs = matchFeatures(desc1, desc2, 'MatchThreshold', 10.0, 'MaxRatio', 0.67);
locs1 = l1(pairs(:, 1), :);
locs2 = l2(pairs(:, 2), :);

% showMatchedFeatures(im1, im2, locs1, locs2, 'montage');

end

