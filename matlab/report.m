% task1
I1 = imread("../data/cv_cover.jpg");
I2 = imread("../data/cv_desk.png");
[locs1, locs2] = matchPics(I1, I2);
showMatchedFeatures(I1, I2, locs1, locs2, 'montage');


% homography test 4.3, 4.4, 4.5

H = computeH(locs1, locs2);
tform = projtform2d(H);
points = [randperm(350, 10)', randperm(450, 10)'];
transform = transformPointsForward(tform,points);
figure('Name', 'computeH');
showMatchedFeatures(I1, I2, points, transform, 'montage');

H = computeH_norm(locs1, locs2).';
tform = projtform2d(H);
points = [randperm(350, 10)', randperm(450, 10)'];
transform = transformPointsForward(tform,points);
figure('Name', 'computeH_norm');
showMatchedFeatures(I1, I2, inliers, transform, 'montage');

[H,inliers] = computeH_ransac(x1, x2);
tform = projtform2d(H);
transform = transformPointsForward(tform,inliers);
figure('Name', 'computeH_ransac');
showMatchedFeatures(I1, I2, inliers, transform, 'montage');
